import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///我的页面
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: null, body: SafeArea(child: Container(child: Text("MinePage")),));
  }
}
