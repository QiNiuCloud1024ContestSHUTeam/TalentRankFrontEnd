import 'package:dio/dio.dart';
import 'package:wan_android_flutter/http/base_model.dart';
import 'package:wan_android_flutter/http/dio_instance.dart';
import 'package:wan_android_flutter/repository/model/home_banner_model.dart';
import 'package:wan_android_flutter/repository/model/home_list_model.dart';
import 'package:wan_android_flutter/repository/model/knowledge_detail_list_model.dart';
import 'package:wan_android_flutter/repository/model/knowledge_list_model.dart';

import '../model/common_website_model.dart';
import '../model/search_hot_key_model.dart';
import '../model/user_info_model.dart';

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

  ///获取置顶文章列表
  Future<HomeTopListModel> topHomeList() async {
    Response response = await DioInstance.instance().get(path: "article/top/json");
    return HomeTopListModel.fromJson(response.data);
  }

  ///获取首页banner数据
  Future<List<HomeBannerModel?>?> bannerList() async {
    Response response = await DioInstance.instance().get(path: "banner/json");
    var model = HomeBannerListModel.fromJson(response.data);
    return model.bannerList;
  }

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

  ///知识体系列表
  Future<List<KnowledgeModel?>?> knowledgeList() async {
    Response response = await DioInstance.instance().get(path: "tree/json");
    var model = KnowledgeListModel.fromJson(response.data);
    return model.list;
  }

  ///知识体系明细列表数据
  Future<List<KnowledgeDetailItem>?> knowledgeDetailList(String id) async {
    // article/list/0/json?cid=60
    Response response =
        await DioInstance.instance().get(path: "article/list/0/json", param: {"cid": id});
    var model = KnowledgeDetailListModel.fromJson(response.data);
    return model.datas;
  }

  ///登录
  Future<UserInfoModel?> login(String? name, String? pwd) async {
    Response response = await DioInstance.instance()
        .post(path: "/user/login", queryParameters: {"username": name, "password": pwd});
    return UserInfoModel.fromJson(response.data);
  }

  ///注册
  Future<UserInfoModel?> register(String? name, String? pwd, String? pwdTwice) async {
    Response response = await DioInstance.instance().post(
        path: "user/register",
        queryParameters: {"username": name, "password": pwd, "repassword": pwdTwice});
    return UserInfoModel.fromJson(response.data);
  }

  ///登出
  Future<bool> logout() async {
    Response response = await DioInstance.instance().get(path: "user/logout/json");
    if (response.data != null && response.data == true) {
      return true;
    }
    return false;
  }
}
