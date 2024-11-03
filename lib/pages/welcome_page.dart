import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/background.jpg", // 使用图片的正确路径
            fit: BoxFit.cover, // 确保图片填满背景
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/hotkey'); // 导航到搜索页
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 60), // 设置最小宽度和高度
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 调整内边距
                backgroundColor: Colors.transparent, // 设置背景颜色为透明
                shadowColor: Colors.transparent, // 设置阴影颜色为透明（可选）
              ),
              child: Text(
                "快开启膜拜之旅吧！",
                style: TextStyle(
                  fontSize: 60, // 调整字体大小
                  fontWeight: FontWeight.w800, // 设置字体为粗体
                  color: Colors.black54,
                ),
              ),
            ),


          ),
        ],
      ),
    );
  }
}
