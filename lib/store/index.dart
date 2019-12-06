import 'package:flutter/material.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider, Consumer, Provider;

import 'model/index.dart';
export 'model/index.dart';


class Store {
  static BuildContext context;

  static init({context, child}) {
    return MultiProvider(
      // TODO 抽离
      providers: [
        ChangeNotifierProvider(builder: (_) => IMSimpleModel()),
      ],
      child: child,
    );
  }

  static T value<T>([BuildContext context]) {
    context ??= Store.context;
    return Provider.of(context);
  }

  // TODO 增加多个多态
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(
      builder: builder,
      child: child,
    );
  }
}
