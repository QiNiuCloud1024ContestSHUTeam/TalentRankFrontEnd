import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/knowledge/details/detail_tab_page.dart';

import '../../../repository/model/knowledge_detail_param.dart';
import 'knowledge_details_view_model.dart';

///知识体系明细页面
class KnowledgeDetailsPage extends StatefulWidget {
  final List<KnowledgeDetailParam>? params;

  const KnowledgeDetailsPage({super.key, this.params});

  @override
  State<StatefulWidget> createState() {
    return _KnowledgeDetailsPageState();
  }
}

class _KnowledgeDetailsPageState extends State<KnowledgeDetailsPage>
    with SingleTickerProviderStateMixin {
  var model = KnowledgeDetailsViewModel();
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: widget.params?.length ?? 0, vsync: this);
    model.initTabs(widget.params);
    log("KnowledgeDetailsPage params=${widget.params?.length}");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return model;
      },
      child: Scaffold(
          appBar: AppBar(
              title: TabBar(
            controller: controller,
            tabs: model.tabList,
            isScrollable: true,
            labelColor: Colors.deepOrange,
            indicatorColor: Colors.green,
          )),
          body: SafeArea(
              child: TabBarView(
            controller: controller,
            children: children(),
          ))),
    );
  }

  ///根据传进来的数据生成对应数量的tabPage
  List<Widget> children() {
    return widget.params?.map((e) {
          return DetailTabPage(id: e.id);
        }).toList() ??
        [];
  }
}