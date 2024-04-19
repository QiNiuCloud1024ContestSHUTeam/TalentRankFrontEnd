import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/about/about_us_page.dart';
import 'package:wan_android_flutter/pages/auth/login_page.dart';
import 'package:wan_android_flutter/pages/mine/mine_view_model.dart';
import 'package:wan_android_flutter/pages/my_collects/my_collects_page.dart';
import 'package:wan_android_flutter/route/RouteUtils.dart';
import 'package:wan_android_flutter/route/Routes.dart';

import '../../common_ui/common_styles.dart';

///我的页面
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  var model = MineViewModel();

  @override
  void initState() {
    super.initState();
    model.initData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return model;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: null,
            body: SafeArea(
                child: Column(children: [
              //用户信息区域
              _userArea(children: _userHead(onTap: () {
                //点击头像或者用户名
                if (model.shouldLogin == true) {
                  log("点击头像或者用户名去登录");
                  RouteUtils.pushForNamed(context, RoutePath.login);
                }
              })),
              _commonItem(
                  title: "我的收藏",
                  onTap: () {
                    if (model.shouldLogin == true) {
                      RouteUtils.push(context, const LoginPage());
                    } else {
                      RouteUtils.push(context, const MyCollectsPage());
                    }
                  }),
              _commonItem(title: "检查更新", onTap: () {
                model.checkUpdate();
              }),
              _commonItem(
                  title: "关于我们",
                  onTap: () {
                    RouteUtils.push(context, const AboutUsPage());
                  }),
              _logoutButton(() {
                model.logout();
              })
            ]))));
  }

  Widget _userArea({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      height: 200.h,
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  List<Widget> _userHead({GestureTapCallback? onTap}) {
    return [
      GestureDetector(
        onTap: onTap,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40.r)),
            child: Image.asset(
              "assets/images/logo.png",
              width: 80.r,
              height: 80.r,
            )),
      ),
      SizedBox(
        height: 5.h,
      ),
      GestureDetector(
          onTap: onTap,
          child: Selector<MineViewModel, String?>(builder: (context, value, child) {
            return Text(value ?? "", style: whiteTextStyle14);
          }, selector: (context, value) {
            return value.userName;
          }))
    ];
  }

  Widget _commonItem({required String title, GestureTapCallback? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.only(left: 10.w, right: 5.w),
            margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 0.5.r),
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            width: double.infinity,
            height: 45.h,
            child: Row(children: [
              Expanded(child: Text(title, style: blackTextStyle13)),
              Image.asset("assets/images/img_arrow_right.png", width: 20.r, height: 20.r)
            ])));
  }

  ///退出登录按钮
  Widget _logoutButton(GestureTapCallback? onTap) {
    return Selector<MineViewModel, bool>(builder: (context, value, child) {
      return !value
          ? GestureDetector(
              onTap: onTap,
              child: Container(
                  width: double.infinity,
                  height: 40.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 100.h),
                  decoration: BoxDecoration(
                      color: Colors.teal, borderRadius: BorderRadius.all(Radius.circular(20.r))),
                  child: Text(
                    "退出登录",
                    style: whiteTextStyle14,
                  )))
          : const SizedBox();
    }, selector: (context, m) {
      return m.shouldLogin ?? false;
    });
  }
}
