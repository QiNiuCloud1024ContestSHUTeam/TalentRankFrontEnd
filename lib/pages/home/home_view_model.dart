import 'package:flutter/cupertino.dart';

import '../../repository/api/wan_api.dart';
import '../../repository/model/home_list_model.dart';

class HomeViewModel with ChangeNotifier {
  List<HomeListItemData>? listData = [];

  ///获取数据
  Future getHomeList() async {
    HomeListModel? data = await WanApi.instance().homeList();
    if (data != null) {
      listData = data.datas ?? [];
      notifyListeners();
    }
  }
}
