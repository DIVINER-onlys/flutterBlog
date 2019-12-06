import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class System extends StatelessWidget {
  final String text;

  System(this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(195, 196, 201, 1),
              fontSize: ScreenUtil().setSp(24))),
    );
  }
}
