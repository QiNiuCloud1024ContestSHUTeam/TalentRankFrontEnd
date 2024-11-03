import 'package:dio/dio.dart';
import 'package:wan_android_flutter/http/dio_instance.dart';
import '../model/common_website_model.dart';
import '../model/home_list_model.dart';
import '../model/search_hot_key_model.dart';
import '../model/search_list_model.dart';

class ZzyApi {
  static ZzyApi? _instance;

  ZzyApi._internal();

  static ZzyApi instance() {
    return _instance ??= ZzyApi._internal();
  }

  //魔改版搜索页结果呈现，实际上与搜索无关，别管。样例是：获取文章列表
  Future<HomeListModel?> homeList(String pageCount) async {
    // Dio dio = Dio();
    // dio.options = BaseOptions(
    //     method: "GET",
    //     baseUrl: "https://www.wanandroid.com/",
    //     connectTimeout: Duration(seconds: 30),
    //     receiveTimeout: Duration(seconds: 30),
    //     sendTimeout: Duration(seconds: 30));
    // Response response = await dio.get("article/list/0/json");
    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json");
    // var model = HomeListModel();
    // model.fromData(response.data);
    return HomeListModel.fromJson(response.data);
    // return null;
  }
  ///获取置顶文章列表
  Future<HomeTopListModel> topHomeList() async {
    Response response = await DioInstance.instance().get(path: "article/top/json");
    return HomeTopListModel.fromJson(response.data);
  }


  //当前需求：增加一个常用领域的后端接口
  ///获取搜索热词
  Future<List<SearchHotKeyModel>?> searchHotKeys() async {
    Response response = await DioInstance.instance().get(path: "hotkey/json");
    var model = SearchHotKeyListModel.fromJson(response.data);
    return model.list;
  }

  ///获取常用网站
  Future<List<CommonWebsiteModel>?> commonWebsiteList() async {
    Response response = await DioInstance.instance().get(path: "friend/json");
    var model = CommonWebsiteListModel.fromJson(response.data);
    return model.list;
  }


  ///老版本搜索
  Future<List<SearchListItemModel>?> search({required String keyWord}) async {
    Response rsp = await DioInstance.instance()
        .post(path: "article/query/0/json", queryParameters: {"k": keyWord});

    // 输出完整的请求 URL 到控制台demo
    // final baseUrl = "https://bigzzy.good/"; // 替换为你的基础 URL
    // final fullUrl = "$baseUrl/article/query/0/json?k=$keyWord";
    // print("Request URL: $fullUrl");

    SearchListModel? model = SearchListModel.fromJson(rsp.data);
    if (model.datas != null && model.datas?.isNotEmpty == true) {
      return model.datas;
    }
    return [];
  }

  ///用户or领域搜索
  Future<List<SearchListItemModel>?> searchRe({required String keyWord,required String type}) async {
    Response rsp = await DioInstance.instance()
        .post(path: "article/query/0/json", queryParameters: {"k": keyWord,"type": type});
    SearchListModel? model = SearchListModel.fromJson(rsp.data);

    // print(type);
    // 输出完整的请求 URL 到控制台
    // final baseUrl = "https://https://bigzzy.good/"; // 替换为你的基础 URL
    // final fullUrl = "$baseUrl/article/query/0/json?k=$keyWord&type=$type";
    // print("Request URL: $fullUrl");

    if (model.datas != null && model.datas?.isNotEmpty == true) {
      return model.datas;
    }
    return [];
  }

}
