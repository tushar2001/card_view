import 'package:flutter/material.dart';

enum ThemeEnum { dark, light }

class ThemeConfig {
  static ThemeData getTheme(ThemeEnum theme) {
    switch (theme) {
      case ThemeEnum.dark:
        return ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          // textTheme: TextTheme(
          //   displayMedium: TextStyle(color: Colors.white),
          // ),
          // appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        );
      case ThemeEnum.light:
      default:
        return ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Color.fromRGBO(247, 247, 247, 1),
        );
    }
  }
}
