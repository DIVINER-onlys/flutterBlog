// 保存当前context
import 'package:flutter/material.dart';
import 'dart:collection';

class ContextMap {
  static LinkedHashMap<_ContextProviderState, BuildContext> contextMap =
      LinkedHashMap();

  static BuildContext getContextMap() {
    return contextMap.values.first;
  }
}

class ContextProvider extends StatefulWidget {
  final Widget child;

  ContextProvider({Key key, this.child}) : super(key: key);

  @override
  _ContextProviderState createState() => _ContextProviderState();
}

class _ContextProviderState extends State<ContextProvider> {
  @override
  void dispose() {
    ContextMap.contextMap.remove(this);
    print('context_provider, ContextProvider dispose this: $this');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) {
        ContextMap.contextMap[this] = ctx;
        print(
            'context_provider, ContextProvider build ctx: $ctx , tihs: $this');
        return widget.child;
      },
    );
  }
}
