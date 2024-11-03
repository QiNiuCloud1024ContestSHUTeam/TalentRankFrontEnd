import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common_ui/web/webview_page.dart';
import 'package:wan_android_flutter/common_ui/web/webview_widget.dart';

import 'package:wan_android_flutter/pages/search/search_page.dart';

import '../pages/hot/hot_key_page.dart';
import '../pages/welcome_page.dart';

///路由注册管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      //欢迎页
        case RoutePath.welcome:
        return pageRoute(WelcomePage(),settings: settings);

        //热点页
      case RoutePath.hotkey:
        return pageRoute(const HotKeyPage(),settings: settings);

      //显示网页资源的页面
      case RoutePath.web_view:
        return pageRoute(WebViewPage(loadResource: "", webViewType: WebViewType.URL),
            settings: settings);

      //搜索页
      case RoutePath.search:
        return pageRoute(const SearchPage(), settings: settings);
    }
    return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
        builder: (context) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

///路由地址
class RoutePath {

  //热点页面
  static const String hotkey = "/hotkey";

  //欢迎页
  static const String welcome = "/welcome";

  //显示网页资源的页面
  static const String web_view = "/web_view";

  //关于我们
  static const String about_us = "/about_us";

  //搜索页
  static const String search = "/search";
}
