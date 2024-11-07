import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/api/zzy_api.dart';
import 'package:wan_android_flutter/repository/model/search_allkey_model.dart';
import '../../repository/model/home_list_model.dart';
import '../../repository/model/rank_information_model.dart';
import '../../repository/model/search_list_model.dart';

class SearchViewModel with ChangeNotifier {

  //最终版搜索需要的数据模型
  List<ScoreUserList>? RankList = [];
  late int topicId;
  late String q;
  late String nation;
  late String user;
  int _pageCount = 0;


  //魔改版需要的列表初始化
  Future initDataList(bool loadMore,int type, {ValueChanged<bool>? complete}) async {
    //加载更多
    if (loadMore) {
      _pageCount++;
    } else {
      //重置页码
      _pageCount = 0;
      //刷新数据
      RankList?.clear();
    }

    if(type==0){
      //searchReId方法的上拉加载
      searchReById(loadMore,topicId).then((topList) {
        if (loadMore) {
          RankList?.addAll(topList ?? []);
          notifyListeners();
          //完成后抛出回调
          complete?.call(loadMore);
        };
      });
    }


    if(type==1){
      //searchReByQ
      searchReByQ(loadMore,q,nation).then((topList) {
        if (loadMore) {
          RankList?.addAll(topList ?? []);
          notifyListeners();
          //完成后抛出回调
          complete?.call(loadMore);
        };
      });
    }


    if(type==2){
      //searchReByUser
      searchReByUser(loadMore,user).then((topList) {
        if (loadMore) {
          RankList?.addAll(topList ?? []);
          notifyListeners();
          //完成后抛出回调
          complete?.call(loadMore);
        };
      });
    }


  }


//新的搜索——通过topicId
  Future<List<ScoreUserList>?> searchReById(bool loadMore,topicId) async {
    UserDatum? list = await ZzyApi.instance()
        .searchReById(page: _pageCount, topicId: topicId);
    if (list != null) {
      return list.scoreUserList;
    } else {
      //加载更多场景，拿不到数据，页码-1
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
      return [];
    }
  }

  //新的搜索——通过关键词q
  Future<List<ScoreUserList>?> searchReByQ(bool loadMore,String q,String nation) async {
    UserDatum? list =
        await ZzyApi.instance().searchReByQ(page: _pageCount, q: q, nation: '');
    if (list != null) {
      return list.scoreUserList;
    } else {
      //加载更多场景，拿不到数据，页码-1
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
      return [];
    }
  }

  //新的搜索——通过用户
  Future<List<ScoreUserList>?> searchReByUser(bool loadMore, user) async {
    UserDatum? list =
        await ZzyApi.instance().searchReByUser(page: _pageCount, user: user);
    if (list != null) {
      return list.scoreUserList;
    } else {
      //加载更多场景，拿不到数据，页码-1
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
      return [];
    }
  }

  //魔改版搜索页结果呈现，实际上与搜索无关，别管。样例是：获取文章列表+置顶列表
  ///获取数据
  Future<List<HomeListItemData>?> _getHomeList(bool loadMore) async {
    HomeListModel? data = await ZzyApi.instance().homeList("$_pageCount");
    if (data != null && data.datas?.isNotEmpty == true) {
      return data.datas;
    } else {
      //加载更多场景，拿不到数据，页码-1
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
      return [];
    }
  }
  ///获取置顶文章列表
  // Future<List<HomeListItemData>?> _getTopHomeList(bool loadMore) async {
  //   //加载更多场景不需要获取置顶数据
  //   if (loadMore) {
  //     return [];
  //   }
  //   HomeTopListModel? data = await ZzyApi.instance().topHomeList();
  //   return data.dataList;
  // }

  void clearList() {
    //print("为什么没有用？？？"); 此方法停用
    RankList?.clear();
    notifyListeners();
  }
}
