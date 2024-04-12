import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/knowledge/details/knowledge_details_view_model.dart';

import '../../../repository/model/knowledge_detail_list_model.dart';

class DetailTabPage extends StatefulWidget {
  final String? id;

  const DetailTabPage({super.key, this.id});

  @override
  State<StatefulWidget> createState() {
    return _DetailTabPageState();
  }
}

class _DetailTabPageState extends State<DetailTabPage> {
  var model = KnowledgeDetailsViewModel();

  @override
  void initState() {
    super.initState();
    model.getDetailList(widget.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<KnowledgeDetailsViewModel>().getDetailList(widget.id);
    // return Scaffold(body:
    // Consumer<KnowledgeDetailsViewModel>(builder: (context, value, child) {
    //   return ListView.builder(
    //       itemCount: value.detailList.length,
    //       itemBuilder: (context, index) {
    //         return _item(value.detailList[index]);
    //       });
    // }));
    //
    return ChangeNotifierProvider(
      create: (context) {
        return model;
      },
      child: Scaffold(body: Consumer<KnowledgeDetailsViewModel>(builder: (context, value, child) {
        return ListView.builder(
            itemCount: value.detailList.length,
            itemBuilder: (context, index) {
              return _item(value.detailList[index]);
            });
      })),
    );
  }

  Widget _item(KnowledgeDetailItem item) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 0.5.r)),
        child: Column(children: [
          Row(
            children: [
              Text("${item.superChapterName}"),

              Expanded(child: SizedBox()),
              Text("${item.niceShareDate}"),
            ],
          ),
          Text("${item.title}"),
          Row(
            children: [
              Text("${item.chapterName}"),
              Expanded(child: SizedBox()),
              Text("${item.shareUser}"),
            ],
          )
        ]));
  }
}
