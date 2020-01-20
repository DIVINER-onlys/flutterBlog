import 'package:flutter/material.dart';

class RouterObserver extends NavigatorObserver {
  // 处理路由监听
  static void dealRouter(Route route) {
    switch (route?.settings?.name) {
      case '/':
        break;
    }
    print(
        'router_observer, 通过对应的 route.setting.name = ${route?.settings?.name} 获取路由名称，做相应响应');
  }

  @override
  void didPush(Route route, Route previousRoute) {
    print(
        'router_observer, didPush ${route?.settings?.name} ${previousRoute?.settings?.name}');
    dealRouter(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    print(
        'router_observer, didPop ${route?.settings?.name} ${previousRoute?.settings?.name}');
    dealRouter(route);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    print(
        'router_observer, didRelpace ${newRoute?.settings?.name} ${oldRoute?.settings?.name}');
    dealRouter(newRoute);
    super.didReplace();
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    print(
        'router_observer, didRemove ${route?.settings?.name} ${previousRoute?.settings?.name}');
    dealRouter(route);
    super.didRemove(route, previousRoute);
  }
}
