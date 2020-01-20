import 'package:flutter/material.dart';

import 'package:flutter_blog/component/overlay/ZnovOverLay.dart'
    show ZnovOverLay;
import './MiniRoomWidget.dart' show MiniRoomFloatingWidget;

class OverLayDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OverLayDemo'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            ZnovOverLay.show(
              context: context,
              view: MiniRoomFloatingWidget(
                key: GlobalKey(),
                title: 'overLay widget',
                bid: '12345678',
                imgUrl:
                    'https://desk-fd.zol-img.com.cn/t_s960x600c5/g5/M00/09/02/ChMkJlah6XmIYC1_AA_mAyQe9GEAAHjsgMqgakAD-Yb054.jpg',
              ),
            );
            // ZnovOverLay.show(context: context, view: Text('data'));
          },
          child: Text('show OverLay'),
        ),
      ),
    );
  }
}
