import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/api/zzy_api.dart';
import 'package:wan_android_flutter/repository/model/search_allkey_model.dart';
import '../../repository/model/home_list_model.dart';
import '../../repository/model/rank_information_model.dart';
import '../../repository/model/search_list_model.dart';

class SearchViewModel with ChangeNotifier {

  //最终版搜索需要的数据模型
  List<ScoreUserList> RankList = [];
  // late int topicId;
  // late String q;
  // late String nation;
  // late String user;



  //魔改版需要的列表初始化
  Future initDataList({ValueChanged<bool>? complete}) async {

  }


//新的搜索——通过topicId
  Future<List<ScoreUserList>?> searchReById(topicId) async {
    UserDatum? list = await ZzyApi.instance()
        .searchReById(topicId: topicId);
    if (list != null) {
      return list.scoreUserList;
    }
      return [];
  }

  //新的搜索——通过关键词q
  Future<List<ScoreUserList>?> searchReByQ(String q,String nation) async {
    UserDatum? list =
        await ZzyApi.instance().searchReByQ(q: q, nation: '');
    if (list != null) {
      return list.scoreUserList;
    }
      return [];
  }

  //新的搜索——通过用户
  Future<List<ScoreUserList>?> searchReByUser(user) async {
    UserDatum? list =
        await ZzyApi.instance().searchReByUser(user: user);
    if (list != null) {
      return list.scoreUserList;
    }
      return [];
  }


}
