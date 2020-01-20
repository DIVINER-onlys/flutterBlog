import 'package:flutter/material.dart';

import 'package:flutter_blog/component/canvas/CircleProgressBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CanvasDemo extends StatelessWidget {
  GlobalKey<CircleProgressBarState> comboProgressKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CanvasDemo'),
      ),
      body: Center(
        child: CircleProgressBar(
          ScreenUtil().setWidth(110),
          comboProgressKey: comboProgressKey,
          backgroundColor: Colors.red[900],
          foreColor: Colors.yellow[600],
          duration: 5 * 1000,
        ),
      ),
    );
  }
}
