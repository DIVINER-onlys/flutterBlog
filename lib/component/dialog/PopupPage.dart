import 'package:flutter/material.dart';
// import 'package:znovel_flutter/store/index.dart' show Store;



class PopupWidget {
  final Widget child;
  final Duration duration;

  PopupWidget({ Key key, @required this.child, this.duration});

  // void push() {
  //   Navigator.push(Store.context, PopupPage(child: this.child, duration: this.duration));
  // }
}

class PopupPage extends PopupRoute {
  Duration _duration = Duration(milliseconds: 100);
  final Widget child;

  PopupPage({ @required this.child, Duration duration}) {
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
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return child;
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => _duration;
}


class Popup extends StatelessWidget {
  final Widget child;
  final Function onClick; //点击child事件
  final double left; //距离左边位置
  final double top; //距离上面位置
  final double right; //距离右边位置
  final double bottom; //距离下面位置

  Popup({
    @required this.child,
    this.onClick,
    this.left,
    this.top,
    this.right,
    this.bottom
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
              left: left??null,
              top: top??null,
              right: right??null,
              bottom: bottom??null,
            ),
          ],
        ),
        onTap: () {
          //点击空白处
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
