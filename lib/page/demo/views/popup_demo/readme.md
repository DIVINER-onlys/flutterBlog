# flutter自定义Dialog样式，实现自定义Popupmenu

## 前言
在做项目过程中有一个需求是需要弹出对话框PopupMenu，要实现对PopupMenu指定位置并且需要改变PopuMenu的样式，flutter提供的PopupMenu虽然可以实现自由自定位置，但是没办法改变样式，对PopupMenu需要更多了解的可以参考[图解 PopupMenu 那些事儿](https://www.jianshu.com/p/06e84fff63f1)。

本文主要实现一个的dialog弹层，可自行修改dialog样式，通过弹层可以实现对PopupMenu的自定义、loading封装等等。


## 效果
![flutter自定义Dialog样式，实现自定义Popupmenu.gif](https://user-gold-cdn.xitu.io/2019/8/3/16c56da40495514e?w=376&h=758&f=gif&s=1595738)
## 实现
通过阅读源码可知showGeneralDialog返回一个_DialogRoute，而_DialogRoute 继承了PopupRoute，

因此通过继承PopupRoute,可以实现弹出透明的布局抽象路由，代码如下
```dart
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
```
上面PopupPage继承PopupRoute， 使用PopupPage将其push到路由中即可
```dart
class PopupWidget {
  // 展示一个透明路由层
  static push({child, duration}) {
    Navigator.push(
      Store.context,
      PopupPage(child: child, duration: duration),
    );
  }
}
```
到这里只要你调用PopupWidget.push(child: child)，传入对应的child既可以，但为实现上述效果，我们封装多一次loading和自定义位置，以下为扩展内容，代码量偏多，请选择性阅读
```dart
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
            child: CircularProgressIndicator(), // 加载进度loading 可自行定义loading样式
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
        child: PopupPositioned( // 该组件代码实现在下文中
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
```

展示loading调用PopupWidget.showLoading();

因为loading展示是向页面覆盖一层路由，所以要隐藏loading也是通过Navigator.pop(context)实现的，调用PopupWidget.hideLoading();

自定位置思路：在界面最外层覆盖一个Container,宽高占满整个屏幕，在用Stack去进行绝对定位
```dart
lass PopupPositioned extends StatelessWidget {
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
```
通过PopupWidget.popupPositioned(
                  child: showPositionedWidget(),
                  right: 20.0,
                  top: 90.0,
                );
就可以实现自定义位置，showPositionedWidget实现自定义样式。

附上showPositionedWidget代码：
```dart
  Widget showPositionedWidget() {
    return Stack(
      children: <Widget>[
        Material(
          elevation: 6,
          color: Color(0xff47444F),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
          child: Container(
              // width: ScreenUtil().setWidth(200),
              constraints: BoxConstraints(
                  // maxHeight: ScreenUtil().setxWidth(180)
                  ),
              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      opWidget('取消关注', () {}),
                      opWidget('举报', () {})
                    ],
                  )),
        ),
        Positioned(
          top: ScreenUtil().setWidth(-14),
          right: ScreenUtil().setWidth(30),
          child: Container(
            width: ScreenUtil().setWidth(0),
            height: ScreenUtil().setWidth(0),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                  color: Colors.transparent, width: ScreenUtil().setWidth(14)),
              top: BorderSide(
                  color: Color(0xff47444F), width: ScreenUtil().setWidth(14)),
              right: BorderSide(
                  color: Colors.transparent, width: ScreenUtil().setWidth(14)),
              left: BorderSide(
                  color: Colors.transparent, width: ScreenUtil().setWidth(14)),
            )),
          ),
        )
      ],
      overflow: Overflow.visible,
    );
  }

  Widget opWidget(String text, Function doOperation) {
    return GestureDetector(
      onTap: doOperation,
      child: Container(
        // width: ScreenUtil().setWidth(200),
        // color: Colors.red,
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(30),
          left: ScreenUtil().setWidth(44),
          right: ScreenUtil().setWidth(44),
        ),
        child: Text(
          text,
          style:
              TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
```

代码量比较多，主要是前面实现PopupPage继承PopupRoute即可，其他都是通过利用PopupPage去加多的扩展，还有其他很多的用处，比如公用确认弹层，toast实现等等。

## 最后
欢迎更多学习flutter的小伙伴加入QQ群 Flutter UI： 798874340

敬请关注我们正在开发的：[efoxTeam/flutter-ui](https://github.com/efoxTeam/flutter-ui)

[作者](https://github.com/DIVINER-onlys)



