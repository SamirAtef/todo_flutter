import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color green = Color(0xFF61E757);
  static const Color red = Color(0xFFEC4B4B);
  static final lightTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScaffoldBackground,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(
          size: 36,
        ),
        unselectedIconTheme: IconThemeData(
          size: 36,
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: lightPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
      ));
}
