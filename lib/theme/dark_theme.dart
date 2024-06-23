import 'package:flutter/material.dart';

ThemeData dartTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary:Colors.grey.shade200,
      secondary: Colors.white,
      tertiary: Colors.grey[800]!,
      // not
    ),
  primaryColor: Colors.white60,
  hintColor: Colors.black
);