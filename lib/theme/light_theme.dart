import 'package:flutter/material.dart';
Color myColor = Colors.blue.shade50;
ThemeData lightTheme = ThemeData(
  // brightness: Brightness.light,

  appBarTheme:  AppBarTheme(
    backgroundColor:  Colors.grey[200],
  ),
  colorScheme:   ColorScheme.dark(
      background: Colors.white,
      primary:Colors.blue.shade500,
      secondary: Colors.black,
      tertiary: Colors.blueGrey,
  ),
  primaryColor: Colors.red.shade500,
  hintColor: Colors.blue.shade50,

);
