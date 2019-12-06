import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blog/router/index.dart' show Router;
import 'package:flutter_blog/view/Demo/views/PopupDemo/PopupDemo.dart'
    show PopupDemo;
import 'package:flutter_blog/view/Demo/views/OverLayDemo/OverLayDemo.dart'
    show OverLayDemo;
import 'package:flutter_blog/view/Demo/views/CanvasDemo/CanvasDemo.dart'
    show CanvasDemo;
import 'package:flutter_blog/view/Demo/views/CanvasDemo/testCanvas.dart'
    show CustomPaintRoute;
import 'package:flutter_blog/view/Demo/views/CanvasDemo/camera.dart'
    show CameraApp;
import 'package:flutter_blog/view/Demo/views/ImSimple/ImSimple.dart'
    show IMSimpleWidget;

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("实验室")),
        body: ListView(
            children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text('PopupWidget'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Router.push(
                  PopupDemo(),
                );
              },
            ),
            ListTile(
              title: Text('OverLayWidget'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Router.push(
                  OverLayDemo(),
                );
              },
            ),
            ListTile(
              title: Text('CanvasDemo'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Router.push(
                  CanvasDemo(),
                );
              },
            ),
            ListTile(
              title: Text('CustomPaintRoute'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Router.push(
                  CustomPaintRoute(),
                );
              },
            ),
            ListTile(
              title: Text('IMSimpleWidget'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                List<Map> charList = [
                  {
                    "avatar": 'http://img.wxcha.com/file/201809/11/edcd6280cb.jpg',
                    "nickname": '曾系猪'
                  },
                  {
                    "avatar": 'https://tu1.whhost.net/uploads/20181103/15/1541230078-kmcrQJCypG.jpg',
                    "nickname": '林系猫'
                  },
                  
                  
                ];
                Router.push(
                  IMSimpleWidget(charList: charList),
                );
              },
            ),
            // ListTile(
            //   title: Text('CameraApp'),
            //   trailing: Icon(Icons.chevron_right),
            //   onTap: () async {
            //     var cameras = await availableCameras();
            //     Router.push(
            //       CameraApp(cameras: cameras,),
            //     );
            //   },
            // ),
          ],
        ).toList()));
  }
}
