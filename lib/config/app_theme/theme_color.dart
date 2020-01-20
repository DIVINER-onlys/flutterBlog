import 'package:flutter/material.dart';

class AppThemeColorConfig {
  static int mainColorValue = 0xFFF44336;
  static Color mainColor = Color(0xFFFF5746); // 主色

  static Map<int, Color> appMapColor = {
    50: Color.fromRGBO(255, 92, 66, .1),
    100: Color.fromRGBO(255, 92, 66, .2),
    200: Color.fromRGBO(255, 92, 66, .3),
    300: Color.fromRGBO(255, 92, 66, .4),
    400: Color.fromRGBO(255, 92, 66, .5),
    500: Color.fromRGBO(255, 92, 66, .6),
    600: Color.fromRGBO(255, 92, 66, .7),
    700: Color.fromRGBO(255, 92, 66, .8),
    800: Color.fromRGBO(255, 92, 66, .9),
    900: Color.fromRGBO(255, 92, 66, 1),
  };

  //
  static Color red = Color(0xFFF44336);
  static Color white = Colors.white;
  static Color pink = Color(0xFFE91E63);
  static Color purple = Color(0xFF9C27B0);
  static Color deepPurple = Color(0xFF673AB7);
  static Color indigo = Color(0xFF3F51B5);

  //

  static Color blue = Color(0xFF2196F3);
  static Color lightBlue = Color(0xFF03A9F4);
  static Color cyan = Color(0xFF00BCD4);
  static Color teal = Color(0xFF009688);
  static Color green = Color(0xFF4CAF50);

  //
  static Color lightGreen = Color(0xFF8BC34A);
  static Color lime = Color(0xFFCDDC39);
  static Color yellow = Color(0xFFFFEB3B);
  static Color amber = Color(0xFFFFC107);
  static Color orange = Color(0xFFFF9800);

  //
  static Color deepOrange = Color(0xFFFF5722);
  static Color brown = Color(0xFF795548);
  static Color grey = Color(0xFF9E9E9E);
  static Color blueGrey = Color(0xFF607D8B);
  static Color black = Color(0xFF222222);

  static MaterialColor appPrimarySwatch = MaterialColor(
    AppThemeColorConfig.mainColorValue,
    AppThemeColorConfig.appMapColor,
  );
}
