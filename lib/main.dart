import 'package:flutter/material.dart';

import 'app.dart';
import 'http/dio_instance.dart';
import 'package:provider/provider.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: "https://www.wanandroid.com/");
  runApp(const MyApp());
}
