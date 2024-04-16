import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/api/wan_api.dart';
import '../../repository/model/home_list_model.dart';

class HomeViewModel with ChangeNotifier {
  List<HomeListItemData>? listData = [];

  Future initDataList() async {
    listData?.clear();
    //先获取置顶列表
    _getTopHomeList().then((topList) {
      listData?.addAll(topList ?? []);
      _getHomeList().then((list) {
        listData?.addAll(list ?? []);
        notifyListeners();
      });
    });
  }

  ///获取数据
  Future<List<HomeListItemData>?> _getHomeList() async {
    HomeListModel? data = await WanApi.instance().homeList();
    if (data != null) {
      return data.datas;
    }
    return [];
  }

  ///获取置顶文章列表
  Future<List<HomeListItemData>?> _getTopHomeList() async {
    HomeTopListModel? data = await WanApi.instance().topHomeList();
    return data.dataList;
  }

  ///收藏文章
  Future collect(int index, String? id) async {
    bool success = await WanApi.instance().collect(id ?? "");
    if (success) {
      listData?[index].collect = true;
      notifyListeners();
    }
  }

  ///取消收藏文章
  Future cancelCollect(int index, String? id) async {
    bool success = await WanApi.instance().cancelCollect(id ?? "");
    if (success) {
      listData?[index].collect = false;
      notifyListeners();
    }
  }
}
