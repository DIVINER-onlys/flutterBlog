import 'package:flutter/material.dart';

import 'package:flutter_blog/router/router.dart' show Router;

class ListViewItem extends StatelessWidget {
  final String itemUrl;
  final String itemTitle;
  final String data;
  final String routerUrl;

  ListViewItem({
    this.itemUrl,
    this.itemTitle,
    this.data,
    this.routerUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        onTap: () {
          Router.push(routerUrl);
        },
        title: Padding(
          child: Text(
            itemTitle,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
          padding: EdgeInsets.only(top: 10.0),
        ),
        subtitle: Row(
          children: <Widget>[
            Padding(
              child: Text(
                data,
                style: TextStyle(color: Colors.black54, fontSize: 10.0),
              ),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            )
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
          size: 30.0,
        ),
      ),
    );
  }
}
