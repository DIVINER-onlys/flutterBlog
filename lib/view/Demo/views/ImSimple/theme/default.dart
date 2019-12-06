import 'package:flutter/material.dart';
import './theme.dart';

final ImTheme defaultImTheme = ImTheme(
  brightness: Brightness.light,
  refreshBgColor: Colors.transparent,
  refreshTextColor: Color.fromRGBO(172, 173, 183, 1),
  sessionNicknameColor: Color.fromRGBO(36, 36, 36, 1),
  sessionTextColor: Color.fromRGBO(172, 173, 183, 1),
  sessionTimeStrColor: Color.fromRGBO(172, 173, 183, 1),
  imBarrierColor: Colors.white,
  imHeaderColor: Colors.white,
  imTitleTextStyle: TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(36, 36, 37, 1),
      fontWeight: FontWeight.w700),
  imNicknameColor: Color.fromRGBO(36, 36, 37, 1),
  imBodyColor: Color.fromRGBO(246, 247, 250, 1),
  imFooterColor: Colors.white,
  imFooterPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  imInputFontSize: 32,
  imInputBgColor: Colors.white,
  imInputTextColor: Color.fromRGBO(36, 36, 37, 1),
  imInputBorderWidth: .5,
  imInputBorderColor: Color.fromRGBO(233, 234, 240, 1),
  imSendGradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(255, 107, 45, 1),
        Color.fromRGBO(252, 140, 50, 1),
      ]),
  imSendTextColor: Colors.white,
  imSendDisableBgColor: Colors.white.withOpacity(.5),
  imOtherTextMsgBgColor: Colors.white,
  imOtherTextColor: Color.fromRGBO(36, 36, 37, 1),
  imSelfTextMsgBgColor: Color.fromRGBO(254, 118, 46, 1),
  imSelfTextColor: Colors.white,
  showFollowBtn: true,
  showSessionAvatar: true,
  removeImAppBarPaddingTop: false,
  showMoreIcon: true,
);
