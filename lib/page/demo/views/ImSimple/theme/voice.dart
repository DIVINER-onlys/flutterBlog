import 'package:flutter/material.dart';
import './theme.dart';


ImTheme voiceImTheme = ImTheme(
    brightness: Brightness.dark,
    refreshBgColor: Colors.transparent,
    refreshTextColor: Color.fromRGBO(172, 173, 183, 1),
    sessionNicknameColor: Colors.white,
    sessionTextColor: Color.fromRGBO(255, 255, 255, .4),
    sessionTimeStrColor: Color.fromRGBO(255, 255, 255, .3),
    imBarrierColor: Color.fromRGBO(0, 0, 0, .01),
    imHeaderColor: Colors.transparent,
    imTitleTextStyle: TextStyle(fontSize: 14, color: Colors.white),
    imBodyColor: Color.fromRGBO(22, 17, 56, .85),
    imFooterColor: Color.fromRGBO(30, 25, 62, 1),
    imFooterPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    imInputFontSize: 26,
    imInputBorderWidth: 0,
    imInputBorderColor: Colors.transparent,
    imInputBgColor: Colors.white.withOpacity(0.06),
    imInputTextColor: Colors.white,
    imSendTextColor: Colors.white,
    imSendGradient: null,
    imSendDisableBgColor: null,
    imOtherTextColor: Colors.white,
    imSelfTextColor: Color.fromRGBO(255, 113, 54, 1),
    imSelfTextMsgBgColor: Color.fromRGBO(254, 118, 46, .2),
    imOtherTextMsgBgColor: Colors.white.withOpacity(.1),
    showFollowBtn: true,
    showSessionAvatar: false,
    removeImAppBarPaddingTop: true,
    showMoreIcon: false);
