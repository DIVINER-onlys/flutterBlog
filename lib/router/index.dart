import 'package:flutter/material.dart';


import 'package:flutter_blog/store/index.dart' show Store;

class Router {
  static push(widget, [context]) {
    if (context == null) {
      context = Store.context;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  static pop() {
    Navigator.of(Store.context, rootNavigator: true).pop();
  }
}