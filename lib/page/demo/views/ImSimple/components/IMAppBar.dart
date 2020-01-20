import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:flutter_blog/page/Demo/views/ImSimple/theme/theme.dart';
import 'package:flutter_blog/store/model/index.dart';

AppBar IMAppBar(BuildContext context, List<Map> charList, {ImTheme theme}) {
  theme = theme ?? ImTheme();

  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    brightness: theme.brightness,
    actions: <Widget>[
      Consumer<IMSimpleModel>(
        builder: (context, im, child) {
          return FlatButton(
            child: Text('切换'),
            onPressed: () {
              im.changeSendIndex();
            },
          );
        },
      ),
    ],
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        theme.showSessionAvatar
            ? GestureDetector(
                onTap: () {
                  print('调起个人资料页');
                },
                child: Container(
                  width: ScreenUtil().setWidth(52),
                  height: ScreenUtil().setWidth(52),
                  child: Consumer<IMSimpleModel>(
                    builder: (context, im, child) {
                      return charList[im.sendIndex]['avatar'] != ''
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                charList[im.sendIndex]['avatar'],
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
              )
            : Container(),
        SizedBox(width: ScreenUtil().setWidth(16)),
        GestureDetector(
            onTap: () {
              // Router.push(Information(
              //   isOwner: false,
              //   selectedUid: currentSessionId,
              // ));
            },
            child: Container(
              constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(200)),
              child: Consumer<IMSimpleModel>(builder: (context, im, child) {
                return Text(
                  charList[im.sendIndex]['nickname'] == ''
                      ? '袜子'
                      : charList[im.sendIndex]['nickname'],
                  style: theme.imTitleTextStyle,
                  overflow: TextOverflow.ellipsis,
                );
              }),
            )),
        SizedBox(width: ScreenUtil().setWidth(16)),
      ],
    ),
    backgroundColor: theme.imHeaderColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Color.fromRGBO(104, 100, 115, 1)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}
