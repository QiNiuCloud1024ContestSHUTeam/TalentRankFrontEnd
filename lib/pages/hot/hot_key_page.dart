import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:wan_android_flutter/pages/hot/hot_common_view_model.dart';
import 'package:wan_android_flutter/pages/search/search_page.dart';

import '../../common_ui/common_styles.dart';
import '../../route/RouteUtils.dart';

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
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
    model.initKeyList(true); // 初始加载第一页数据
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return model;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SmartRefreshWidget(
                    controller: _refreshController,
                    enablePullUp: true,
                    // 启用上拉加载
                    enablePullDown: false,
                    onLoading: () {
                      model.initKeyList(true, complete: (isLoadMore) {
                        if (isLoadMore) {
                          _refreshController.loadComplete();
                        } else {
                          _refreshController.refreshCompleted();
                        }
                      });
                    },
                    child: SingleChildScrollView(
                        child: Column(children: [
                      _titleWidget("全部领域", true, onTap: () {
                        RouteUtils.push(context, const SearchPage());
                      }),
                      SizedBox(height: 20.h),
                      _searchAllKeysListView(),
                      SizedBox(height: 20.h),
                    ]))))));
  }

  Widget _titleWidget(String title, bool search, {GestureTapCallback? onTap}) {
    return Column(children: [
      Container(width: double.infinity, height: 0.5.h, color: Colors.black12),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15.w, right: 10.w),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 45.h,
        child: search
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                normalText(title),
                GestureDetector(
                    onTap: onTap,
                    child: Image.asset("assets/images/icon_search.png",
                        width: 30.r, height: 30.r))
              ])
            : normalText(title),
      ),
      Container(width: double.infinity, height: 0.5.h, color: Colors.black12)
    ]);
  }

  ///搜索热门领域
  // Widget _searchHotKeyListView() {
  //   return Consumer<HotCommonViewModel>(builder: (context, value, child) {
  //     return _gridview(
  //         itemBuilder: (context, index) {
  //           var name = value.hotKeyList[index].name;
  //           return _item(name, onTap: () {
  //             RouteUtils.push(context, SearchPage(keyWord: name,type: "false",nation: "None",));
  //           });
  //         },
  //         itemCount: value.hotKeyList.length);
  //   });
  // }

  ///搜索全部领域
  Widget _searchAllKeysListView() {
    return Consumer<HotCommonViewModel>(builder: (context, value, child) {
      return _gridview(
          itemBuilder: (context, index) {
            var name = value.allKeyList[index].topicName;
            return _item(name, onTap: () {
              RouteUtils.push(
                  context,
                  SearchPage(
                    topicId: value.allKeyList[index].topicId,
                  ));
            });
          },
          itemCount: value.allKeyList.length);
    });
  }

  ///常用网站列表
  // Widget _commonWebsiteListView({GestureTapCallback? itemClick}) {
  //   return Consumer<HotCommonViewModel>(builder: (context, value, child) {
  //     return _gridview(
  //         itemBuilder: (context, index) {
  //           return _item(value.websiteList[index].name, onTap: () {
  //             //进入网页
  //             RouteUtils.push(
  //                 context,
  //                 WebViewPage(
  //                     loadResource: value.websiteList[index].link ?? "",
  //                     webViewType: WebViewType.URL,
  //                     showTitle: true,
  //                     title: value.websiteList[index].name));
  //           });
  //         },
  //         itemCount: value.websiteList.length);
  //   });
  // }

  ///通用网格布局
  Widget _gridview<T>(
      {required NullableIndexedWidgetBuilder itemBuilder, int? itemCount}) {
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
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 5.w, right: 5.w),
      child: InkWell(
          onTap: onTap,
          child: Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: blackTextStyle13,
          )),
    );
  }
}
