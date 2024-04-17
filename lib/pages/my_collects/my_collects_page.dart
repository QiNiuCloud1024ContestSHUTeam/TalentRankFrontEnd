import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/repository/model/my_collects_model.dart';

import '../../common_ui/common_styles.dart';
import 'my_collects_view_model.dart';

///我的收藏页面
class MyCollectsPage extends StatefulWidget {
  const MyCollectsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyCollectsPageState();
  }
}

class _MyCollectsPageState extends State<MyCollectsPage> {
  var model = MyCollectsViewModel();

  @override
  void initState() {
    super.initState();
    model.getMyCollects();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return model;
        },
        child: Scaffold(
            body: SafeArea(
                child: Selector<MyCollectsViewModel, List<MyCollectItemModel>?>(
          builder: (context, list, child) {
            return ListView.builder(
                itemCount: list?.length ?? 0,
                itemBuilder: (context, index) {
                  return _collectItem(list?[index], onTap: () {
                    model.cancelCollect(index, "${list?[index].id}");
                  });
                });
          },
          selector: (context, vm) {
            return vm.dataList;
          },
        ))));
  }

  Widget _collectItem(MyCollectItemModel? item, {GestureTapCallback? onTap}) {
    return Container(
        margin: EdgeInsets.all(10.r),
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Text("作者: ${item?.author}"),
            ),
            Text("时间: ${item?.niceDate}")
          ]),
          SizedBox(height: 6.h),
          Text("${item?.title}", style: titleTextStyle15),
          Row(children: [
            Expanded(child: Text("分类: ${item?.chapterName}")),
            collectImage(true, onTap: onTap)
          ]),
        ]));
  }
}
