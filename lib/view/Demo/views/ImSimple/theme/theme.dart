import 'package:flutter/material.dart';

class ImTheme {
  final Brightness brightness;
  final Color refreshBgColor;
  final Color refreshTextColor;
  final Color sessionNicknameColor;
  final Color sessionTextColor;
  final Color sessionTimeStrColor;
  final Color imBarrierColor;
  final Color imHeaderColor;
  final TextStyle imTitleTextStyle;
  final Color imNicknameColor;
  final Color imBodyColor;
  final Color imFooterColor;
  final EdgeInsetsGeometry imFooterPadding;
  final double imInputFontSize;
  final Color imInputBgColor;
  final Color imInputTextColor;
  final double imInputBorderWidth;
  final Color imInputBorderColor;
  final Gradient imSendGradient;
  final Color imSendTextColor;
  final Color imSendDisableBgColor;
  final Color imOtherTextMsgBgColor;
  final Color imOtherTextColor;
  final Color imSelfTextMsgBgColor;
  final Color imSelfTextColor;
  final bool showFollowBtn;
  final bool showSessionAvatar;
  final bool removeImAppBarPaddingTop;
  final bool showMoreIcon;

  ImTheme({
    this.brightness = Brightness.light,
    this.refreshBgColor = Colors.transparent,
    this.refreshTextColor = const Color.fromRGBO(172, 173, 183, 1),
    this.sessionNicknameColor = const Color.fromRGBO(36, 36, 36, 1),
    this.sessionTextColor = const Color.fromRGBO(172, 173, 183, 1),
    this.sessionTimeStrColor = const Color.fromRGBO(172, 173, 183, 1),
    this.imBarrierColor = Colors.white,
    this.imHeaderColor = Colors.white,
    this.imTitleTextStyle = const TextStyle(
        fontSize: 18,
        color: Color.fromRGBO(36, 36, 37, 1),
        fontWeight: FontWeight.w700),
    this.imNicknameColor = const Color.fromRGBO(36, 36, 37, 1),
    this.imBodyColor = const Color.fromRGBO(246, 247, 250, 1),
    this.imFooterColor = Colors.white,
    this.imFooterPadding =
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.imInputFontSize = 32,
    this.imInputBgColor = Colors.white,
    this.imInputTextColor = const Color.fromRGBO(36, 36, 37, 1),
    this.imInputBorderWidth = .5,
    this.imInputBorderColor = const Color.fromRGBO(233, 234, 240, 1),
    this.imSendGradient = const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color.fromRGBO(255, 107, 45, 1),
          Color.fromRGBO(252, 140, 50, 1),
        ]),
    this.imSendTextColor = Colors.white,
    this.imSendDisableBgColor = const Color.fromRGBO(255, 255, 255, .5),
    this.imOtherTextMsgBgColor = Colors.white,
    this.imOtherTextColor = const Color.fromRGBO(36, 36, 37, 1),
    this.imSelfTextMsgBgColor = const Color.fromRGBO(254, 118, 46, 1),
    this.imSelfTextColor = Colors.white,
    this.showFollowBtn = true,
    this.showSessionAvatar = true,
    this.removeImAppBarPaddingTop = false,
    this.showMoreIcon = true,
  });
}
