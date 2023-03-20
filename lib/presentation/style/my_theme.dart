import 'package:flutter/material.dart';

class MyTheme {
  static final appTheme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
      textTheme: const TextTheme(
          subtitle2: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)));
}
