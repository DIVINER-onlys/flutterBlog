import 'package:flutter/material.dart';
import 'package:flutter_blog/page/demo/views/popup_demo/popup_demo.dart' show PopupDemo;

class DemoRouter {
  static Map<String, WidgetBuilder> routerNameConfig = {
    '/popupdemo': (ctx) => PopupDemo()
  };
}