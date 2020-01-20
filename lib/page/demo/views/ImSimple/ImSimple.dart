import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:znovel_flutter/component/dialog/OverlayAlert.dart';
// import 'package:znovel_flutter/store/model/ReportModel.dart';
// import 'package:znovel_flutter/store/object/IMItemObject.dart';
// import 'package:znovel_flutter/store/object/IMSession.dart';
// import 'package:znovel_flutter/view//im/components/IMItem.dart';
// import 'package:znovel_flutter/view/IM/IMMore.dart';
import 'package:flutter_blog/page/Demo/views/ImSimple/theme/theme.dart';
import './components/IMInputWidget.dart' show IMInputWidget;
import './components/IMAppBar.dart' show IMAppBar;
import 'package:provider/provider.dart';
import 'package:flutter_blog/store/model/index.dart';

import 'components/IMItem.dart';
// import 'package:znovel_flutter/helper/http/index.dart' as Http;
// import 'package:flutter_blog/store/index.dart' show Store;
// import 'components/IMLoadingWidget.dart';
// import 'components/NetworkToastWidget.dart';

class IMSimpleWidget extends StatefulWidget {
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  final List<Map> charList;
  final ImTheme theme;

  @override
  State<IMSimpleWidget> createState() => _IMState();

  IMSimpleWidget({@required this.charList, this.theme});
}

class _IMState extends State<IMSimpleWidget>
    with TickerProviderStateMixin, RouteAware {
  // IMSession session;
  ImTheme theme;

  // IMModel _im = Store.value<IMModel>();
  // UserModel _user = Store.value<UserModel>();

  @override
  void initState() {
    theme = widget.theme ?? ImTheme();
    super.initState();
    _initIm();
    _setScreenKey();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    IMSimpleWidget.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPop() async {
    // await _im.clear();
    print('im did pop');
    super.didPop();
  }

  @override
  void deactivate() {
    _checkFollow();
    super.deactivate();
  }

  @override
  void dispose() {
    print('im dispose');
    IMSimpleWidget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  _initIm() async {
    // int sessionId = widget.sessionId;
    // String nickname = widget.nickname;
    // String avatar = widget.avatar;

    // if (nickname == null && avatar == null) {
    //   // List userInfoList = await _im.getUserInfoByUidList([widget.sessionId]);
    //   // nickname = userInfoList[0]['szNickName'];
    //   // avatar = userInfoList[0]['szAvatar'];
    // }
    // session = IMSession(
    //   sessionId: sessionId,
    //   avatar: avatar,
    //   nickname: nickname,
    //   status: MsgStatus.success,
    //   time: DateTime.now().millisecondsSinceEpoch,
    //   receiverUid: widget.sessionId,
    //   senderUid: _user.uid,
    // );
    // Future.delayed(Duration.zero, () {
    //   _im.setCurrentSession(session);
    //   _im.clearUnreadNum(session.sessionId);
    //   _im.loadMsg();
    //   _checkFollow();
    //   IMMoreModel.blackListCheck(session.sessionId);
    // });
  }

  // 检查是否关注关系
  Future _checkFollow() async {
    // final res = await Http.get(
    //     url:
    //         '/audio/follow/releation?szId=${_user.uid}&szFollowId=${session.sessionId}&nBizId=2001');
    // print('当前会话关注状态:${res['anyData']['nFollow']}');
    // _im.setIsCurrentSessionYouFollow(res['anyData']['nFollow'] == 1);
  }

  _setScreenKey() {
    GlobalKey rootKey = GlobalKey();
    // _im.setGlobalKey(rootKey);
    // ReportModel.setImBoundary(rootKey);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      // key: _im.globalKey,
      child: Container(
        color: theme.brightness == Brightness.light
            ? Colors.white
            : Colors.transparent,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: theme.brightness == Brightness.light ? true : false,
          child: MediaQuery.removePadding(
            context: context,
            child: Scaffold(
                appBar: PreferredSize(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(0, 0.5),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                    child: IMAppBar(context, widget.charList, theme: theme),
                  ),
                  preferredSize: Size.fromHeight(kToolbarHeight),
                ),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context)
                              .requestFocus(FocusNode()); // 收起键盘
                          // OverlayAlert.remove(); // 收起长按菜单
                        },
                        child: Consumer<IMSimpleModel>(
                          builder: (context, im, child) {
                            return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    bottom: ScreenUtil().setWidth(64)),
                                reverse: true,
                                // controller: im.controller,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(40)),
                                        child: IMItem(
                                          im.IMItemList[index],
                                          rootKey: GlobalKey(),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                itemCount: im.IMItemList.length);
                          },
                        ),
                      ),
                    ),
                    IMInputWidget(theme: theme, charList: widget.charList,)
                  ],
                ),
                backgroundColor: theme.imBodyColor),
            removeTop: theme.removeImAppBarPaddingTop,
          ),
        ),
      ),
    );
  }
}
