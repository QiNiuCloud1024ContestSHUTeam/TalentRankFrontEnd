import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_android_flutter/repository/api/wan_api.dart';

import '../../../repository/model/knowledge_detail_list_model.dart';
import '../../../repository/model/knowledge_detail_param.dart';

///知识体系业务逻辑层
class KnowledgeDetailsViewModel with ChangeNotifier {
  List<Tab> tabList = [];

  List<KnowledgeDetailItem> detailList = [];

  ///初始化tab列表
  void initTabs(List<KnowledgeDetailParam>? params) {
    if (params?.isNotEmpty == true) {
      params?.forEach((item) {
        tabList.add(Tab(text: item.name ?? ""));
      });
    }
  }

  ///知识体系明细列表数据
  void getDetailList(String? id) async {
    var list = await WanApi.instance().knowledgeDetailList(id ?? "");
    if (list?.isNotEmpty == true) {
      detailList = list ?? [];
      notifyListeners();
    }
  }
}
