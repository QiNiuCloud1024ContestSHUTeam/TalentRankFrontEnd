import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';

import '../base_model.dart';

///处理返回值拦截器
class RspInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //修改未登录的错误码为-1001，其他错误码为-1，成功为0，建议对errorCode 判断当不为0的时候，均为错误。
    if (response.statusCode == 200) {
      if (response.requestOptions.path.contains("apiv2/app/check")) {
        handler.next(response);
      } else {
        var rsp = BaseModel.fromJson(response.data);
        if (rsp.code == 1) {
          if (rsp.data == null) {
            handler.next(Response(requestOptions: response.requestOptions, data: true));
          } else {
            handler.next(Response(requestOptions: response.requestOptions, data: rsp.data));
          }
        } else if (rsp.code == -1001) {
          handler.reject(DioException(requestOptions: response.requestOptions, message: "..."));
          showToast("请先登录");
        } else {
          handler.reject(DioException(requestOptions: response.requestOptions));
        }
      }
    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
}
