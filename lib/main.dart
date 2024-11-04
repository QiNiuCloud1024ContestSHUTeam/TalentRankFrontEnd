import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'http/dio_instance.dart';

void main() async{
  DioInstance.instance().initDio(baseUrl: "https://www.wanandroid.com/");//基础url与后端沟通，要改
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}
