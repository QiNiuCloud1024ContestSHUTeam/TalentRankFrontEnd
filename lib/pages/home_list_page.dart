import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_flutter/repository/api/wan_api.dart';

import '../repository/model/home_list_model.dart';

///首页文章列表页面
class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeListPageState();
  }
}

class _HomeListPageState extends State<HomeListPage> {
  List<HomeListItemData>? listData;

  @override
  void initState() {
    super.initState();
    getHomeList();
  }

  ///获取数据
  Future getHomeList() async {
    HomeListModel? data = await WanApi.instance().homeList();
    if (data != null) {
      listData = data.datas ?? [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
            child: ListView.builder(
                itemCount: listData?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return _listItem(listData?[index]);
                })));
  }

  ///列表item
  Widget _listItem(HomeListItemData? item) {
    return Container(
        width: double.infinity,
        height: 60.h,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Text(
          item?.title ?? "",
          style: TextStyle(fontSize: 15.sp),
        ));
  }
}
