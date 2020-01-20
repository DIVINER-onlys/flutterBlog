import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './RotateCover.dart';
import 'package:flutter_blog/component/overlay/ZnovOverLay.dart'
    show ZnovOverLay;

class MiniRoomFloatingWidget extends StatefulWidget {
  final num channelId;
  final String title;
  final String bid;
  final String imgUrl;
  final VoidCallback onClose;

  const MiniRoomFloatingWidget({
    Key key,
    this.title,
    this.bid,
    this.onClose,
    this.channelId,
    this.imgUrl,
  }) : super(key: key);
  @override
  _MiniRoomFloatingWidgetState createState() => _MiniRoomFloatingWidgetState();
}

class _MiniRoomFloatingWidgetState extends State<MiniRoomFloatingWidget>
    with TickerProviderStateMixin {
  AnimationController controller_record;
  Animation<double> animation_record;
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);
  static const height = 70.0;

  @override
  void initState() {
    super.initState();
    print('did initState');
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });

    controller_record.forward();
  }

  @override
  void dispose() {
    print('did dispose');
    controller_record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          // NavUtil.jumpIntoRoom(channelID: widget.channelId);
          ZnovOverLay.remove();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Colors.orangeAccent,
                  Colors.orange
                  // UITheme.lOrange,
                  // UITheme.orange,
                ]),
            // color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(height / 2)),
          ),
          width: 200,
          height: height,
          child: Center(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: RotateRecord(
                      animation: _commonTween.animate(controller_record),
                      imgUrl: widget.imgUrl,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        )),
                        Text(
                          'ID:${widget.bid}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(24)),
                  //     border: Border.all(width: 0.5, color: Colors.black)),
                  child: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        ZnovOverLay.remove();
                        // Store.value<ChannelLogic>().leaveChannel();
                        // Store.value<ChannelLogic>().setMiniMode(false);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
