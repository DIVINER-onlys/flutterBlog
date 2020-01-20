import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, SystemChrome;
import 'dart:io' show Platform;
import 'package:oktoast/oktoast.dart' show OKToast;

import 'package:flutter_blog/router/router.dart' show Router;
import 'package:flutter_blog/store/store.dart' show Store;
import 'package:flutter_blog/config/app_theme/app_theme.dart' show AppTheme;

void main() {
  runApp(FlutterBlog());

  // ios默认透明不用加，自定义手机顶部黑条样式（Android沉浸式）
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class FlutterBlog extends StatefulWidget {
  @override
  _FlutterBlogState createState() => _FlutterBlogState();
}

class _FlutterBlogState extends State<FlutterBlog> {
  @override
  Widget build(BuildContext context) {
    Store.of(context);
    return OKToast(
      child: Store.init(
        context: context,
        child: MaterialApp(
          initialRoute: '/',
          onGenerateRoute: Router.onGenerateRoute,
          navigatorObservers: Router.navigatorObservers,
          title: 'FlutterBlog',
          theme: AppTheme.themeData,
        ),
      ),
    );
  }
}
