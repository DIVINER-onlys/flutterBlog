import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ------------------------------
/// ┌─┐┬ ┬ ┬┌─┐┬ ┬
/// ├┤ │ └┬┘│ ││ │
/// └  ┴─┘┴ └─┘└─┘
/// Author       : fzl flyou
/// Date         : 2018/10/12 0012
/// ProjectName  : test1
/// Description  :
/// Version      : V1.0
/// ------------------------------

class CircleProgressBar extends StatefulWidget {
  final GlobalKey<CircleProgressBarState> comboProgressKey;
  final Color backgroundColor; // 背景颜色
  final Color foreColor; // 前景颜色
  final int duration; // 持续时间
  final double size; // 画布大小
  final double strokeWidth; // 画笔大小
  final double startNumber;
  final double maxNumber;
  final TextStyle textStyle;

  CircleProgressBar(
    this.size, {
    this.comboProgressKey,
    this.backgroundColor = Colors.grey,
    this.foreColor = Colors.blueAccent,
    this.duration = 3000,
    this.strokeWidth = 3,
    this.textStyle,
    this.startNumber = 0,
    this.maxNumber = 100,
  }) : super(key: comboProgressKey);

  @override
  State<StatefulWidget> createState() {
    return CircleProgressBarState();
  }
}

class CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  Animation<double> _doubleAnimation;
  AnimationController _animationController;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));

    curve =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _doubleAnimation =
        Tween(begin: widget.maxNumber.toDouble(), end: 0.0).animate(curve);

    _animationController.addListener(() {
      setState(() {});
    });
    onAnimationStart();
  }

  @override
  void reassemble() {
    super.reassemble();
    onAnimationStart();
  }

  onAnimationStart() {
    _animationController.reset();
    _animationController.forward(from: widget.startNumber);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var percent = (_doubleAnimation.value / widget.maxNumber * 100).round();
//    print('percent --> $percent');
    return Container(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: CircleProgressBarPainter(
              widget.backgroundColor,
              widget.foreColor,
              widget.startNumber / widget.maxNumber * 360,
              _doubleAnimation.value / widget.maxNumber * 360,
              percent * 360,
              widget.strokeWidth),
          size: Size(widget.size, widget.size),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                child: Text((percent * 30 / 100).round().toString(),
                    style: widget.textStyle == null
                        ? TextStyle(
                            color: Colors.red,
                            fontSize: ScreenUtil().setSp(30))
                        : widget.textStyle),
              ),
            ],
          )),
        ));
  }
}

class CircleProgressBarPainter extends CustomPainter {
  var _paintBckGround;
  var _paintFore;

  final _strokeWidth;
  final _backgroundColor;
  final _foreColor;
  final _startAngle;
  final _sweepAngle;
  final _endAngle;

  CircleProgressBarPainter(this._backgroundColor, this._foreColor,
      this._startAngle, this._sweepAngle, this._endAngle, this._strokeWidth) {
    _paintBckGround = Paint()
      ..color = _backgroundColor
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;

    _paintFore = Paint()
      ..color = _foreColor
      ..isAntiAlias = true
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var radius = size.width > size.height ? size.width / 2 : size.height / 2;
    Rect rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);

    print(rect);
    canvas.drawCircle(Offset(radius, radius), radius, _paintBckGround);
    canvas.drawArc(rect, _startAngle / 180 * 3.14, _sweepAngle / 180 * 3.14,
        false, _paintFore);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
//    print('shouldRepaint ? ${_sweepAngle != _endAngle}');
    return _sweepAngle != _endAngle;
  }
}
