import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/view/Demo/views/ImSimple/theme/theme.dart';
import './TextMsg.dart' show TextMsg;
import './System.dart' show System;
import 'package:flutter_blog/store/object/IMItemObject.dart'
    show IMItemType, MsgStatus, IMItemObject;

class IMItem extends StatelessWidget {
  final IMItemObject data;
  final ImTheme theme;
  final GlobalKey rootKey;

  IMItem(this.data, {this.theme,this.rootKey});

  @override
  Widget build(BuildContext context) {
    switch (data.type) {
      case IMItemType.speak:
        return TextMsg(
          id: data.id,
          uid: data.uid,
          avatar: data.avatar,
          text: data.text,
          status: data.status,
          timeStr: data.timeStr,
          theme: theme,
          rootKey: rootKey,
        );
      case IMItemType.system:
        return System(data.text);
    }
  }
}
