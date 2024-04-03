import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common_ui/navigation/navigation_bar_widget.dart';

///知识体系页面
class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: null, body: Container(child: Text("KnowledgePage")));
  }
}
