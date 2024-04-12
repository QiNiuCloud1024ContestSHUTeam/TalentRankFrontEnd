import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/api/wan_api.dart';

import '../../repository/model/common_website_model.dart';
import '../../repository/model/search_hot_key_model.dart';

class HotCommonViewModel with ChangeNotifier {
  List<SearchHotKeyModel> hotKeyList = [];
  List<CommonWebsiteModel> websiteList = [];

  Future getData() async {
    getHotKeyList();
    commonWebsiteList();
  }

  ///获取搜索热词
  Future getHotKeyList() async {
    var list = await WanApi.instance().searchHotKeys();
    if (list != null) {
      hotKeyList = list;
      notifyListeners();
    }
  }

  ///获取搜索热词
  Future commonWebsiteList() async {
    var list = await WanApi.instance().commonWebsiteList();
    if (list != null) {
      websiteList = list;
      notifyListeners();
    }
  }
}
