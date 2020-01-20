import 'package:flutter/material.dart';
import 'theme_color.dart' show AppThemeColorConfig;

class AppTheme {
  static ThemeData _themeData = ThemeData(
    primarySwatch: AppThemeColorConfig.appPrimarySwatch,
    primaryColor: AppThemeColorConfig.mainColor,
    bottomAppBarTheme: BottomAppBarTheme(),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  static get themeData => _themeData;
}
