import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/page/Demo/views/ImSimple/theme/theme.dart';

import 'package:flutter_blog/store/store.dart';
import 'package:flutter_blog/store/object/IMItemObject.dart';
import 'package:flutter_blog/store/object/IMItemObject.dart'
    show IMItemType, MsgStatus, IMItemObject;

class IMInputWidget extends StatefulWidget {
  ImTheme theme;
  List<Map> charList;

  IMInputWidget({this.theme, @required this.charList});

  @override
  State<IMInputWidget> createState() =>
      _IMInputState(theme: theme ?? ImTheme());
}

class _IMInputState extends State<IMInputWidget> with TickerProviderStateMixin {
  ImTheme theme;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double _opacity = 1;
  AnimationController _opacityController;
  Animation _opacityAnimation;
  bool _sendDisabled = true;
  bool _isEnterSend = false;

  _IMInputState({@required this.theme});

  @override
  void initState() {
    _textEditingController.addListener(_textEditingListener);
    _focusNode.addListener(_focusListener);
    _opacityController =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_opacityController);
    _opacityAnimation.addListener(() {
      setState(() {
        _opacity = _opacityAnimation.value;
      });
    });
    _opacityAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _opacityController.reset();
        setState(() {
          _opacity = 1;
        });
      }
    });
    super.initState();
  }

  @override
  dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  _textEditingListener() {
    setState(() {
      _sendDisabled = _textEditingController.text == '';
    });
  }

  _focusListener() {
    if (_focusNode.hasFocus && !_isEnterSend) {
      _opacityController.forward();
      // _im.scrollToBottom();
    }
  }

  Future<bool> sendMessage(text) async {
    IMSimpleModel imSimpleModel = Store.value<IMSimpleModel>(context);
    imSimpleModel.pushIMItemList(IMItemObject(
            id: '12345678',
            uid: 12345678,
            text: text,
            // time: time,
            type: IMItemType.speak,
            status: MsgStatus.success,
            avatar: widget.charList[imSimpleModel.sendIndex]['avatar'],
            nickname: widget.charList[imSimpleModel.sendIndex]['nickname']));
    // bool isSendSuccess = await ZnovelNativePlugin.sendConversation(
    //   text: text,
    //   uid: _im.currentSession.sessionId,
    //   nickName: Store.value<UserModel>().userInfo.displayName,
    //   avatar: Store.value<UserModel>().userInfo.avatarUrl,
    // );
    // print('发送消息：$isSendSuccess}');
    // return isSendSuccess;
  }

  @override
  Widget build(BuildContext context) {
    print('IMInputWidget build');
    // TODO: implement build
    return Opacity(
      opacity: _opacity,
      child: Container(
        color: theme.imFooterColor,
        padding: theme.imFooterPadding,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: theme.imInputBgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: theme.imInputBorderColor,
                            width: theme.imInputBorderWidth)),
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      onSubmitted: (text) async {
                        FocusScope.of(context).requestFocus(_focusNode);
                        _isEnterSend = true;
                        if (_sendDisabled) return;
                        if (text.length > 500) {
                          // Toast.show('发送失败，字数超过500');
                          return;
                        }
                        _textEditingController.text = '';
                        bool isSendSuccess = await sendMessage(text);
                      },
                      focusNode: _focusNode,
                      keyboardAppearance: theme.brightness,
                      controller: _textEditingController,
                      minLines: 1,
                      maxLines: 3,
                      autofocus: false,
                      style: TextStyle(
                        color: theme.imInputTextColor,
                        fontSize: ScreenUtil().setSp(32),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setWidth(16),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setWidth(16)),
                        hintText: '说点什么吧..',
                        hintStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(theme.imInputFontSize),
                          color: Color.fromRGBO(148, 148, 153, 1),
                        ),
                        border: InputBorder.none,
                      ),
                    ))),
            SizedBox(width: ScreenUtil().setWidth(20)),
            GestureDetector(
                onTap: () async {
                  // if (NetworkErrorCheck.isNetworkError) {
                  //   Toast.show('网络错误，请稍后再试');
                  //   return;
                  // }
                  if (_sendDisabled) return;
                  _isEnterSend = false;
                  String text = _textEditingController.text;
                  if (text.length > 500) {
                    // Toast.show('发送失败，字数超过500');
                    return;
                  }
                  _textEditingController.text = '';
                  bool isSendSuccess = await sendMessage(text);
                },
                child: Container(
                  width: ScreenUtil().setWidth(132),
                  height: ScreenUtil().setWidth(76),
                  decoration: BoxDecoration(
                      color: _sendDisabled ? theme.imSendDisableBgColor : null,
                      gradient: theme.imSendGradient,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text('发送',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(28),
                            fontWeight: FontWeight.w500)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
