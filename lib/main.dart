import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, SystemChrome;
import 'dart:io' show Platform;

import 'package:flutter_blog/view/Tab/BaseTabBar.dart' show BaseTabBarPage;

void main() {
  runApp(FlutterBlog());

  // ios默认透明不用加，自定义手机顶部黑条样式（Android沉浸式）
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class FlutterBlog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBlog',
      theme: ThemeData(
        primaryColor: Colors.red,
        indicatorColor: Colors.red
      ),
      home: Builder(
        builder: (context) {
          return BaseTabBarPage();
        },
      ),
    );
  }
}
