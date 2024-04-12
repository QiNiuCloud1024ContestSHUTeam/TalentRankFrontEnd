import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/hot/hot_common_view_model.dart';

///热点搜索页面
class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HotKeyPageState();
  }
}

class _HotKeyPageState extends State<HotKeyPage> {
  var model = HotCommonViewModel();

  @override
  void initState() {
    super.initState();
    model.getData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return model;
        },
        child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: [
          _titleWidget("搜索热词"),
          SizedBox(height: 20.h),
          //搜索热词列表
          _searchHotKeyListView(),
          SizedBox(height: 20.h),
          _titleWidget("常用网站"),
          SizedBox(height: 20.h),
          //常用网站列表
          _commonWebsiteListView(),
          SizedBox(height: 20.h),
        ])))));
  }

  Widget _titleWidget(String title) {
    return Container(
      color: Colors.lightBlueAccent,
      padding: EdgeInsets.only(left: 15.w),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 45.h,
      child: Text(title),
    );
  }

  ///搜索热词列表
  Widget _searchHotKeyListView() {
    return Consumer<HotCommonViewModel>(builder: (context, value, child) {
      return _gridview(
          itemBuilder: (context, index) {
            return _item(value.hotKeyList[index].name, onTap: () {});
          },
          itemCount: value.hotKeyList.length);
    });
  }

  ///常用网站列表
  Widget _commonWebsiteListView() {
    return Consumer<HotCommonViewModel>(builder: (context, value, child) {
      return _gridview(
          itemBuilder: (context, index) {
            return _item(value.websiteList[index].name, onTap: () {});
          },
          itemCount: value.websiteList.length);
    });
  }

  ///通用网格布局
  Widget _gridview<T>({required NullableIndexedWidgetBuilder itemBuilder, int? itemCount}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: GridView.builder(
            //禁止滑动
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10.r, //主轴间隔
                crossAxisSpacing: 10.r, //横轴间隔
                maxCrossAxisExtent: 120.0, //最大横轴范围
                childAspectRatio: 2.0 //宽高比为2
                ),
            itemBuilder: itemBuilder,
            itemCount: itemCount));
  }

  ///通用网格item
  Widget _item(String? title, {GestureTapCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(30.r))),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
      child: InkWell(
          onTap: onTap,
          child: Text(
            title ?? "",
            textAlign: TextAlign.center,
          )),
    );
  }
}
