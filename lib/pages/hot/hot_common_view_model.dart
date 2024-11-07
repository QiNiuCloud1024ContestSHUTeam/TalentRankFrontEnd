import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/api/zzy_api.dart';
import '../../repository/model/search_allkey_model.dart';

class HotCommonViewModel with ChangeNotifier {
  List<Topic> allKeyList = [];
  int _pageCount = 0;

  Future initKeyList(bool loadMore, {ValueChanged<bool>? complete}) async {
    //加载更多
    if (loadMore) {
      _pageCount++;
    } else {
      //重置页码
      _pageCount = 1;
      //刷新数据
      allKeyList.clear();
    }

    //先获取置顶列表
    _getAllKeyList(loadMore).then((topList) {
      if (loadMore) {
        allKeyList?.addAll(topList ?? []);
        notifyListeners();
        //完成后抛出回调
        complete?.call(loadMore);
      };
    });
  }

  // Future getData({VoidCallback? complete}) async {
  //   getHotKeyList(complete: () {
  //     commonWebsiteList(complete: () {
  //       complete?.call();
  //     });
  //   });
  // }

  ///获取热门领域
  // Future getHotKeyList({VoidCallback? complete}) async {
  //   var list = await ZzyApi.instance().searchHotKeys(page: page);
  //   if (list != null) {
  //     hotKeyList = list;
  //     notifyListeners();
  //   }
  //   complete?.call();
  // }

  ///获取全部领域
  Future<List<Topic>?> _getAllKeyList(bool loadMore) async {
    AllKeyModel? data = await ZzyApi.instance().searchAllKeys(page: _pageCount);
    // print('1111111111111Fetched rows: ${data.rows}');
    // print('Fetched data: ${data?.toJson()}');
    if (data != null && data.rows?.isNotEmpty == true) {
      return data.rows;
    } else {
      //加载更多场景，拿不到数据，页码-1
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
      return [];
    }
  }

  ///获取常用网站
  // Future commonWebsiteList({VoidCallback? complete}) async {
  //   var list = await ZzyApi.instance().commonWebsiteList();
  //   if (list != null) {
  //     websiteList = list;
  //     notifyListeners();
  //   }
  //   complete?.call();
  // }
}
