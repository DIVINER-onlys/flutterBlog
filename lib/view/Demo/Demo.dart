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
