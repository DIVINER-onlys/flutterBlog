import 'package:flutter/material.dart';

import 'package:flutter_blog/router/index.dart' show Router;
import 'package:flutter_blog/view/Demo/views/PopupDemo/PopupDemo.dart'
    show PopupDemo;
import 'package:flutter_blog/view/Demo/views/OverLayDemo/OverLayDemo.dart'
    show OverLayDemo;

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
          ],
        ).toList()));
  }
}
