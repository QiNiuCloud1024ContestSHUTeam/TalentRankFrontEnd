import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/common_ui/banner/home_banner_widget.dart';
import 'package:wan_android_flutter/pages/home/home_view_model.dart';

import '../../common_ui/common_styles.dart';
import '../../repository/model/home_list_model.dart';

///首页文章列表页面
class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeListPageState();
  }
}

class _HomeListPageState extends State<HomeListPage> {
  var model = HomeViewModel();
  BannerController? bannerController = BannerController();

  @override
  void initState() {
    super.initState();
    model.initDataList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return model;
      },
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              BannerWidget(
                controller: bannerController,
                itemClick: (url) {},
              ),
              Consumer<HomeViewModel>(
                builder: (context, value, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.listData?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return _listItem(value.listData?[index]);
                      });
                },
              )
            ],
          )),
        ));
      },
    );
  }

  ///列表item
  Widget _listItem(HomeListItemData? item) {
    return Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            border: Border.all(color: Colors.black26)),
        width: double.infinity,
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.asset("assets/images/luoxiaohei.png",
                      width: 25.r, height: 25.r, fit: BoxFit.fill)),
              SizedBox(width: 5.w),
              normalText(item?.author),
              const Expanded(child: SizedBox()),
              normalText(item?.niceShareDate),
              SizedBox(
                width: 10.w,
              ),
              Text(item?.type == 1 ? "置顶" : "",
                  style: TextStyle(
                      fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.blueAccent))
            ]),
            SizedBox(height: 5.h),
            Text(
              item?.title ?? "",
              style: titleTextStyle15,
            ),
            SizedBox(height: 5.h),
            Row(children: [
              Text(
                item?.chapterName ?? "",
                style: TextStyle(fontSize: 13.sp, color: Colors.green),
              ),
              const Expanded(child: SizedBox()),
              Image.asset(
                item?.collect == true
                    ? "assets/images/img_collect"
                        ".png"
                    : "assets/images/img_collect_grey.png",
                width: 25.r,
                height: 25.r,
              )
            ])
          ],
        ));
  }
}
