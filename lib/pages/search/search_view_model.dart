import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/api/zzy_api.dart';
import '../../repository/model/home_list_model.dart';
import '../../repository/model/search_list_model.dart';

class SearchViewModel with ChangeNotifier {
  List<SearchListItemModel>? dataList = [];
  //新列表收集器
  List<SearchListItemModel>? dataList1 = [];
  //魔改版文章列表需要的数据模型
  List<HomeListItemData>? listData = [];
  int _pageCount = 0;

  //魔改版需要的列表初始化
  Future initDataList(bool loadMore, {ValueChanged<bool>? complete}) async {
    //加载更多
    if (loadMore) {
      _pageCount++;
    } else {
      //重置页码
      _pageCount = 0;
      //刷新数据
      listData?.clear();
    }

    //先获取置顶列表
    _getTopHomeList(loadMore).then((topList) {
      if (!loadMore) {
        listData?.addAll(topList ?? []);
      }
      _getHomeList(loadMore).then((list) {
        listData?.addAll(list ?? []);
        notifyListeners();
        //完成后抛出回调
        complete?.call(loadMore);
      });
    });
  }


  //老的列表查询，之后会删
  Future searchList(String? keyWord) async {
    List<SearchListItemModel>? list = await ZzyApi.instance().search(keyWord: keyWord ?? "");
    if (list?.isNotEmpty == true) {
      dataList = list ?? [];
      notifyListeners();
    }
  }

  //新的列表查询业务层，需要保留
  Future searchReList(String? keyWord,String? type) async {
    List<SearchListItemModel>? list = await ZzyApi.instance().searchRe(keyWord: keyWord ?? "",type: type ?? "");
    if (list?.isNotEmpty == true) {
      dataList1 = list ?? [];
      notifyListeners();
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
  Future<List<HomeListItemData>?> _getTopHomeList(bool loadMore) async {
    //加载更多场景不需要获取置顶数据
    if (loadMore) {
      return [];
    }
    HomeTopListModel? data = await ZzyApi.instance().topHomeList();
    return data.dataList;
  }


  void clearList(){
    //print("为什么没有用？？？"); 此方法停用
    dataList?.clear();
    notifyListeners();
  }
}
