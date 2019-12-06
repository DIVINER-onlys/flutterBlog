import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:flutter_blog/view/Demo/views/ImSimple/theme/theme.dart';
import 'package:flutter_blog/store/model/index.dart';
// import 'package:znovel_flutter/component/dialog/OverlayAlert.dart';
// import 'package:znovel_flutter/component/file/Yimage.dart';
// import 'package:znovel_flutter/component/toast/Toast.dart';
// import 'package:znovel_flutter/config/prod.dart';
// import 'package:znovel_flutter/helper/yyservice/index.dart';
// import 'package:znovel_flutter/store/index.dart';
// import 'package:znovel_flutter/store/model/ReportModel.dart';
// import 'package:znovel_flutter/store/model/index.dart';
import 'package:flutter_blog/store/object/IMItemObject.dart'
    show IMItemObject, IMItemType, MsgStatus;
import './System.dart';
// import 'package:znovel_flutter/view/IM/theme/theme.dart';
// import 'package:znovel_flutter/view/IM/utils/ReportUtil.dart';
// import 'package:znovel_flutter/view/Personal/Information/information.dart'
//     show Information;
// import 'package:znovel_flutter/router/index.dart' show Router;

class TextMsg extends StatelessWidget {
  final id;
  final int uid;
  final MsgStatus status;
  final String avatar;
  final String text;
  final String timeStr;
  final GlobalKey rootKey;
  ImTheme theme;
  LayerLink longPressMenulayerLink = LayerLink();

  TextMsg(
      {@required this.id,
      @required this.uid,
      @required this.avatar,
      @required this.text,
      @required this.status,
      this.theme,
      this.timeStr,
      this.rootKey}) {
    theme = theme ?? ImTheme();
  }

  statusWidget(context) {
    switch (status) {
      case MsgStatus.pending:
        return _MsgLoading();
      case MsgStatus.failed:
        return GestureDetector(
          child: Image.asset('assets/im/status_fail.png'),
          onTap: () {
            // Provider.of<IMModel>(context).resend(id);
          },
        );
      case MsgStatus.blocked:
        return GestureDetector(
          child: Image.asset('assets/im/status_fail.png'),
          onTap: () {
            // Provider.of<IMModel>(context).resend(id);
          },
        );
      case MsgStatus.success:
        return Container();
    }
  }

  // 长按菜单
  Widget longPressMenu(BuildContext context) {
    // TextStyle menuCeilStyle = TextStyle(color: Colors.white, fontSize: ScreenUtil().setWidth(26), decoration: TextDecoration.none, fontWeight: FontWeight.w400);
    // int myUid = Provider.of<UserModel>(context).uid;
    // List<Widget> menuList = [
    //   GestureDetector(
    //     onTap: () {
    //       print('复制');
    //       Clipboard.setData(ClipboardData(text: text));
    //       Toast.show('复制成功');
    //       OverlayAlert.remove();
    //     },
    //     child: Text(
    //       '复制',
    //       style: menuCeilStyle,
    //     ),
    //   ),
    //   Container(
    //       margin: EdgeInsets.only(
    //           left: ScreenUtil().setWidth(12),
    //           right: ScreenUtil().setWidth(12)),
    //       height: ScreenUtil().setWidth(24),
    //       width: ScreenUtil().setWidth(4),
    //       color: Colors.white.withOpacity(0.4)),
    //   GestureDetector(
    //     onTap: () async {
    //       print(
    //           '删除 uid:$uid msgid:$id sessionid:${Provider.of<IMModel>(context).currentSession.sessionId}');
    //       IMItemObject result =
    //           await Provider.of<IMModel>(context).deleteRemoteIMItem(id);
    //       print('删除 $result');
    //       if (result == null) {
    //         Toast.show('删除消息失败');
    //         print('删除消息失败');
    //       } else {
    //         Toast.show('删除成功');
    //       }
    //       OverlayAlert.remove();
    //     },
    //     child: Text(
    //       '删除',
    //       style: menuCeilStyle,
    //     ),
    //   ),
    // ];

    // _reporUid(int uid, List<String> uploadList) async {
    //   // RenderRepaintBoundary boundary = ReportModel.boundary;
    //   // Uint8List data = await ReportModel.screenShotWithBoundary(boundary);
    //   // String imgUrl = await ReportModel.uploadImage(data);
    //   String url = Store.value<IMModel>().currentSession.avatar;

    //   if (url == null || url.length == 0) {
    //     url = ProdConfig().avatarBoy_Girl.first;
    //   }
    //   ReportModel.reportIMMessage(uid, uploadList,url);
    // }

    // // 别人的消息可以举报
    // if (uid != myUid) {
    //   menuList.addAll([
    //     Container(
    //       margin: EdgeInsets.only(
    //           left: ScreenUtil().setWidth(12),
    //           right: ScreenUtil().setWidth(12)),
    //       height: ScreenUtil().setWidth(24),
    //       width: ScreenUtil().setWidth(4),
    //       color: Colors.white.withOpacity(0.4),
    //     ),
    //     GestureDetector(
    //       onTap: () {
    //         List<String> uploadList = [];
    //         OverlayAlert.remove();
    //         ReportUtil.showReportAlert(context,
    //             (String content, BuildContext context) async {
    //           Navigator.pop(context);
    //           uploadList.add(content);
    //           uploadList.addAll(
    //               Provider.of<IMModel>(context).getNearbyMessage(id, uid, 30));

    //           await _reporUid(uid, uploadList);

    //           // Toast.show('举报成功');
    //         });
    //       },
    //       child: Text(
    //         '举报',
    //         style: menuCeilStyle,
    //       ),
    //     )
    //   ]);
    // }

    // return Container(
    //   decoration: BoxDecoration(
    //       color: Color.fromRGBO(36, 36, 36, 1),
    //       borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
    //   padding: EdgeInsets.only(
    //       left: ScreenUtil().setWidth(16),
    //       right: ScreenUtil().setWidth(16),
    //       top: ScreenUtil().setWidth(16),
    //       bottom: ScreenUtil().setWidth(16)),
    //   child: Row(
    //     children: menuList,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    bool isSelf = Provider.of<IMSimpleModel>(context).sendIndex == 0;

    TextStyle textStyle = TextStyle(
        fontSize: ScreenUtil().setWidth(32),
        color: isSelf ? theme.imSelfTextColor : theme.imOtherTextColor);
    Color textFrameBackgroundColor =
        isSelf ? theme.imSelfTextMsgBgColor : theme.imOtherTextMsgBgColor;
    TextDirection textDirection =
        isSelf ? TextDirection.rtl : TextDirection.ltr;
    BorderRadius borderRadius = isSelf
        ? BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(20))
        : BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20));

    return Column(children: <Widget>[
      (timeStr == '' || timeStr == null)
          ? Container()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(timeStr,
                    style: TextStyle(
                        color: Color.fromRGBO(195, 196, 201, 1),
                        fontSize: ScreenUtil().setSp(24)))
              ],
            ),
      SizedBox(height: ScreenUtil().setWidth(20)),
      Row(
        textDirection: textDirection,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: ScreenUtil().setWidth(32)),
          GestureDetector(
            child: Container(
              width: ScreenUtil().setWidth(72),
              height: ScreenUtil().setWidth(72),
              child:
                  CircleAvatar(backgroundImage: NetworkImage(avatar)),
            ),
            onTap: () {
              print('调起个人资料页');
            },
          ),
          SizedBox(width: ScreenUtil().setWidth(20)),
          GestureDetector(
            onLongPress: () {
              print('click');
            },
            child: Row(
              textDirection: textDirection,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  constraints:
                      BoxConstraints(maxWidth: ScreenUtil().setWidth(472)),
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setWidth(14),
                      horizontal: ScreenUtil().setWidth(22)),
                  decoration: BoxDecoration(
                      color: textFrameBackgroundColor,
                      borderRadius: borderRadius),
                  child: CompositedTransformTarget(
                    link: longPressMenulayerLink,
                    child: GestureDetector(
                      onLongPressStart: (LongPressStartDetails details) {
                        // // 长按弹窗 复制 粘贴 举报
                        // int myUid = Provider.of<UserModel>(context).uid;
                        // RenderBox renderBox = context.findRenderObject();
                        // Offset renderBoxPosition =
                        //     renderBox.localToGlobal(Offset.zero);
                        // print(
                        //     'renderBoxPosition ${renderBoxPosition.dx} ${renderBoxPosition.dy}');

                        // print('长按内容$text');
                        // print(
                        //     '---> $details globalPosition: ${details.globalPosition.dx} , ${details.globalPosition.dy}  localPosition:${details.localPosition}');
                        // print(
                        //     '屏幕宽 ${MediaQuery.of(context).size.width} widget width ${context.size.width}');
                        // OverlayAlert.show(
                        //   context: context,
                        //   view: longPressMenu(context),
                        //   layerLink: longPressMenulayerLink,
                        // );

                      },
                      child: Text(text, style: textStyle, softWrap: true),
                    ),
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(20)),
                Container(
                  width: ScreenUtil().setWidth(36),
                  height: ScreenUtil().setWidth(36),
                  child: statusWidget(context),
                )
              ],
            ),
          )
        ],
      ),
      status == MsgStatus.blocked
          ? Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
              child: System('消息已发送，但被对方拒收了'))
          : Container()
    ]);
  }
}

class _MsgLoading extends StatefulWidget {
  @override
  _MsgLoadingState createState() => _MsgLoadingState();
}

class _MsgLoadingState extends State<_MsgLoading>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: Tween<Color>(
                begin: Color.fromRGBO(225, 225, 225, 1),
                end: Color.fromRGBO(175, 175, 175, 1))
            .animate(_controller));
  }
}
