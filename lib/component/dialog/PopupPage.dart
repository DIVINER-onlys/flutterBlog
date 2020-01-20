import 'package:flutter/material.dart';
import 'package:flutter_blog/store/store.dart' show Store;

class PopupWidget {
  // 展示一个透明路由层
  static push({child, duration}) {
    Navigator.push(
      Store.context,
      PopupPage(child: child, duration: duration),
    );
  }

  // 展示loading
  static showLoading() {
    Navigator.push(
      Store.context,
      PopupPage(
        child: Container(
          width: MediaQuery.of(Store.context).size.width,
          height: MediaQuery.of(Store.context).size.height,
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(), // 加载进度loading
          ),
        ),
      ),
    );
  }
  // 隐藏loading
  static hideLoading() {
    Navigator.pop(Store.context);
  }

  // 自定义poupmenuButton 位置自定义
  static popupPositioned({
    @required Widget child,
    Function onClick,
    double top,
    double left,
    double right,
    double bottom,
  }) {
    Navigator.push(
      Store.context,
      PopupPage(
        child: PopupPositioned(
          child: child,
          onClick: onClick,
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        ),
      ),
    );
  }
}

// 继承PopupRoute可以弹出透明的布局抽象路由
class PopupPage extends PopupRoute {
  Duration _duration = Duration(milliseconds: 100);
  final Widget child;

  PopupPage({@required this.child, Duration duration}) {
    if (duration != null) {
      _duration = duration;
    }
  }

  @override
  // TODO: implement barrierColor
  Color get barrierColor => null;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return child;
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => _duration;
}

class PopupPositioned extends StatelessWidget {
  final Widget child;
  final Function onClick; //点击child事件
  final double left; //距离左边位置
  final double top; //距离上面位置
  final double right; //距离右边位置
  final double bottom; //距离下面位置

  PopupPositioned({
    @required this.child,
    this.onClick,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              child: GestureDetector(
                  child: child,
                  onTap: () {
                    //点击子child
                    if (onClick != null) {
                      Navigator.of(context).pop();
                      onClick();
                    }
                  }),
              left: left ?? null,
              top: top ?? null,
              right: right ?? null,
              bottom: bottom ?? null,
            ),
          ],
        ),
        onTap: () {
          //点击空白处
          Navigator.of(context).pop();
        },
        onVerticalDragStart: (DragStartDetails details) {
          print('onVerticalDragStart $details');
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
