import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common_ui/navigation/navigation_bar_widget.dart';

///首页文章列表页面
class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeListPageState();
  }
}

class _HomeListPageState extends State<HomeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: null, body: Container(child: Text("HomeListPage")));
  }
}
