import 'package:flutter/material.dart';
import 'package:flutter_blog/page/home/home.dart' show Home;

class HomeRouter {
  static Map<String, WidgetBuilder> routerNameConfig = {
    '/': (ctx) => Home()
  };
}