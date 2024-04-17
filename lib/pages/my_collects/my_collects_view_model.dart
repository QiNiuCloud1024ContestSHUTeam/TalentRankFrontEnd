import 'package:flutter/material.dart';
import 'package:wan_android_flutter/repository/api/wan_api.dart';

import '../../repository/model/my_collects_model.dart';
//我的收藏页面逻辑层
class MyCollectsViewModel with ChangeNotifier {
  List<MyCollectItemModel>? dataList = [];

  ///获取我的收藏列表
  Future getMyCollects() async {
    var list = await WanApi.instance().getMyCollects();
    if (list != null && list.isNotEmpty == true) {
      dataList = list;
      notifyListeners();
    }
  }

  ///取消收藏文章
  Future cancelCollect(int index, String? id) async {
    bool success = await WanApi.instance().cancelCollect(id ?? "");
    if (success) {
      getMyCollects();
    }
  }
}
