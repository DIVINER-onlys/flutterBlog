import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import './MiniRoomWidget.dart';
import 'package:flutter_blog/component/overlay/ZnovOverLay.dart' show ZnovOverLay;

class RotateRecord extends AnimatedWidget {
  final String imgUrl;
  RotateRecord({this.imgUrl, Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      height: 50.0,
      width: 50.0,
      child: new RotationTransition(
          turns: animation,
          child: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imgUrl),
              ),
            ),
          )),
    );
  }
}

///////////////////////////////////////////////////////////////////////////
class TestAnimDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestAnimDemoState();
  }
}

class _TestAnimDemoState extends State<TestAnimDemo>
    with TickerProviderStateMixin {
  AnimationController controller_record;
  Animation<double> animation_record;
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);
  @override
  void initState() {
    super.initState();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rotate build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotate'),
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Container(
              child: Column(
            children: <Widget>[
              RotateRecord(
                animation: _commonTween.animate(controller_record),
              ),
              MiniRoomFloatingWidget(
                  title: '我是房间标题',
                  bid: '12345',
                  onClose: () {
                    ZnovOverLay.remove();
                  }),
              FlatButton(
                child: Text('干！'),
                onPressed: () {
                  controller_record.forward();
                },
              ),
              // MiniRoomFloatingWidget(title: '我是房我是房我是房卧槽', bid: '123456',)
              FlatButton(
                child: Text('干！'),
                onPressed: () {
                  ZnovOverLay.show(
                      context: context,
                      view: MiniRoomFloatingWidget(
                        title: '我是房间标题',
                        bid: '12345',
                        onClose: () {
                          ZnovOverLay.remove();
                        },
                      ));
                },
              ),
            ],
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller_record.dispose();
    super.dispose();
  }
}
