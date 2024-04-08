import 'package:dio/dio.dart';

import '../base_model.dart';

class RspInterceptor extends Interceptor{
    @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode == 200){
      var rsp = BaseModel.fromJson(response.data);
      if(rsp.errorCode == 0){
        handler.next(Response(requestOptions: response.requestOptions,data: rsp.data));
      }else{
        handler.reject(DioException(requestOptions: response.requestOptions));
      }
    }else{
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
}
