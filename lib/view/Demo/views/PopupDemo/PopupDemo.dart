import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_blog/component/dialog/PopupPage.dart' show PopupWidget;


class PopupDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('自定义PopupRoute'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                PopupWidget.showLoading();
                Future.delayed(Duration(seconds: 3), () {
                  PopupWidget.hideLoading();
                });
              },
              child: Center(
                child: Text('展示loading，3s后关闭'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                PopupWidget.popupPositioned(
                  child: showPositionedWidget(),
                  right: 20.0,
                  top: 90.0,
                );
              },
              child: Center(
                child: Text('自定义PopupMenuButton'),
              ),
            )
          ],
        ));
  }

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

}
