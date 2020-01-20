import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blog/page/context_provider/context_provider.dart'
    show ContextProvider, ContextMap;
import 'package:flutter_blog/page/page_not_found.dart' show PageNotFound;
import 'package:flutter_blog/router/router_observer.dart' show RouterObserver;
import 'package:flutter_blog/config/router_config/router_config.dart' show HomeRouter;

class Router {
  // 路由 pushNamed 时调用
  // 目标页面通过ModalRoute方法获取数据
  // final ScreenArguments args = ModalRoute.of(context).settings.arguments;
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    bool isRTL = false; // 阿拉伯文需要反转的话通过当前语言判断
    Map<String, WidgetBuilder> allRouteNameConfig = {};

    allRouteNameConfig.addAll(HomeRouter.routerNameConfig);

    WidgetBuilder builderWidget = allRouteNameConfig[settings.name];
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return builderWidget == null
            ? PageNotFound()
            : Directionality(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                child: ContextProvider(
                  child: builderWidget(context),
                ),
              );
      },
      settings: settings,
    );
  }

  // 判断返回路由是否可以后退
  static canPop({bool isRoot: false, BuildContext context}) {
    print('router, canPop');
    return Navigator.of(context != null ? context : ContextMap.getContextMap(),
            rootNavigator: isRoot)
        .canPop();
  }

  // 入栈
  static Future<T> push<T extends Object>(String routeName, [arguments]) {
    print('router, flutter Router push $routeName');
    return Navigator.pushNamed(ContextMap.getContextMap(), routeName,
        arguments: arguments);
  }

  // WillPopScope  return false时不会返回
  static Future<bool> willPopScope(BuildContext context) async {
    print(
        'router, willPopScope can pop root ${canPop(context: context, isRoot: true)}');
    if (canPop(context: context, isRoot: true)) {
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    } else {
      return true;
    }
  }

  // 出栈
  static pop<T extends Object>({T result, bool isRoot = false}) {
    // 兼容系统后退
    print(
        'router, can pop ${Navigator.of(ContextMap.getContextMap(), rootNavigator: false).canPop()}');
    print(
        'router, can pop root ${Navigator.of(ContextMap.getContextMap(), rootNavigator: true).canPop()}');
    if (Router.canPop(isRoot: true)) {
      // 关闭弹窗系列
      return Navigator.of(ContextMap.getContextMap(), rootNavigator: true)
          .canPop();
    }
    if (Router.canPop()) {
      return Navigator.of(ContextMap.getContextMap(), rootNavigator: isRoot)
          .pop(result);
    }
  }

  // 替换栈
  static Future<T> replace<T extends Object>(String routeName, [arguments]) {
    print('router, flutter Router replace $routeName');
    return Navigator.pushReplacementNamed(ContextMap.getContextMap(), routeName,
        arguments: arguments);
  }

  // 关闭弹框后退
  static closeModel(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // 获取当前router name
  static String get routerName =>
      ModalRoute.of(ContextMap.getContextMap()).settings.name;

  // 路由守卫
  static List<NavigatorObserver> navigatorObservers = [RouterObserver()];
}
