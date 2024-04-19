import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wan_android_flutter/constants.dart';
import 'package:wan_android_flutter/repository/api/wan_api.dart';
import 'package:wan_android_flutter/utils/sp_utils.dart';

import '../../repository/model/app_check_update_model.dart';

class MineViewModel with ChangeNotifier {
  String? userName;
  bool? shouldLogin;

  Future initData() async {
    String? name = await SpUtils.getString(Constants.SP_USER_NAME);
    log("MineViewModel $name");
    if (name == null || name.isEmpty == true) {
      userName = "未登录";
      shouldLogin = true;
    } else {
      userName = name;
      shouldLogin = false;
    }

    notifyListeners();
  }

  ///退出登录
  Future logout() async {
    var success = await WanApi.instance().logout();
    if (success) {
      userName = "未登录";
      shouldLogin = true;
      //清除缓存
      SpUtils.remove(Constants.SP_USER_NAME);
      notifyListeners();
    } else {
      showToast("网络异常");
    }
  }

  Future checkUpdate() async {
    AppCheckUpdateModel? model = await WanApi.instance().checkUpdate();
    if (model?.code == 0 && model?.data != null) {
      showToast("checkUpdate success");
    }
  }
}
