import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common_ui/navigation/navigation_bar_widget.dart';

///热点搜索页面
class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HotKeyPageState();
  }
}

class _HotKeyPageState extends State<HotKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: null, body: Container(child: Text("HotKeyPage")));
  }
}
