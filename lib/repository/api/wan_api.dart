import 'package:dio/dio.dart';
import 'package:wan_android_flutter/http/base_model.dart';
import 'package:wan_android_flutter/http/dio_instance.dart';
import 'package:wan_android_flutter/repository/model/home_list_model.dart';

class WanApi {
  static WanApi? _instance;

  WanApi._internal();

  static WanApi instance() {
    return _instance ??= WanApi._internal();
  }

  ///获取首页文章列表
  Future<HomeListModel?> homeList() async {

    // Dio dio = Dio();
    // dio.options = BaseOptions(
    //     method: "GET",
    //     baseUrl: "https://www.wanandroid.com/",
    //     connectTimeout: Duration(seconds: 30),
    //     receiveTimeout: Duration(seconds: 30),
    //     sendTimeout: Duration(seconds: 30));
    // Response response = await dio.get("article/list/0/json");
    Response response = await DioInstance.instance().get(path: "article/list/0/json");
    // var model = HomeListModel();
    // model.fromData(response.data);
    return HomeListModel.fromJson(response.data);
    // return null;
  }
}
