import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common_ui/web/webview_widget.dart';

///显示网页资源的页面
class WebViewPage extends StatefulWidget {
  WebViewPage({
    super.key,
    required this.loadResource,
    required this.webViewType,
    this.showTitle,
    this.title,
    this.jsChannelMap,
  });

  //是否显示标题
  final bool? showTitle;

  //标题内容
  final String? title;

  //需要加载的内容类型
  final WebViewType webViewType;

  //给webview加载的数据,可以是url，也可以是html文本
  final String loadResource;

  //与js通信的channel集合
  final Map<String, JsChannelCallback>? jsChannelMap;

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.showTitle ?? false)
          ? AppBar(title: _buildAppBarTitle(widget.showTitle, widget.title))
          : null,
      body: SafeArea(
        child: WebViewWidget(
          webViewType: widget.webViewType,
          loadResource: widget.loadResource,
          jsChannelMap: widget.jsChannelMap,
        ),
      ),
    );
  }

  Widget _buildAppBarTitle(bool? showTitle, String? title) {
    var show = showTitle ?? false;
    return show ? Text(title ?? "") : const SizedBox.shrink();
  }
}