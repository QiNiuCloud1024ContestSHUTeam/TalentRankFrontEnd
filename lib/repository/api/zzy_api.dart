import 'package:dio/dio.dart';
import 'package:wan_android_flutter/http/dio_instance.dart';

// import '../model/common_website_model.dart';
import '../model/home_list_model.dart';
import '../model/rank_information_model.dart';
import '../model/search_allkey_model.dart';
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
    Response response =
        await DioInstance.instance().get(path: "article/list/$pageCount/json");
    print("111");
    // var model = HomeListModel();
    // model.fromData(response.data);
    return HomeListModel.fromJson(response.data);
    // return null;
  }


  ///获取全部领域
  Future<AllKeyModel> searchAllKeys({required int page}) async {
    Response response = await DioInstance.instance()
        .get(path: "/topic/listTopic", param: {"page": page, "pageSize": 40});
    print(response);
    var model = AllKeyModel.fromJson(response.data);
    return model;
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

//通过Id进行查找
  Future<UserDatum> searchReById(
      {required int page, required int topicId}) async {
    Response response = await DioInstance.instance().get(
        path: "/rank/rankByStaticTopic",
        param: {"page": page, "pageSize": 5, "topicIds": topicId});
    print(response);
    var model = UserDatum.fromJson(response.data);
    return model;
  }

  //通过q进行查找
  Future<UserDatum> searchReByQ({required int page, required String q, required String nation}) async {
    Response response = await DioInstance.instance().get(
        path: "/rank/rankBySearchString",
        param: {"page": page, "pageSize": 5, "q": q,"nation": nation}
    );
    print(response);
    var model = UserDatum.fromJson(response.data);
    return model;
  }

  //通过用户进行查找
  Future<UserDatum> searchReByUser(
      {required int page, required String user}) async {
    Response response = await DioInstance.instance().get(
        path: "/user/localSearch",
        param: {"page": page, "pageSize": 5, "keyword": user});
    print(response);
    var model = UserDatum.fromJson(response.data);
    return model;
  }

}
