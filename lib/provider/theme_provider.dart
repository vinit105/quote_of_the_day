import 'package:flutter/material.dart';
import 'package:quote_of_the_day/theme/dark_theme.dart';
import 'package:quote_of_the_day/theme/light_theme.dart';
class ThemeProvider with ChangeNotifier {
  static ThemeData _themeData = lightTheme;
  static ThemeData getTheme(){
    return _themeData;
  }

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if(_themeData == lightTheme){
      _themeData = dartTheme;
      notifyListeners();
    }
    else {
      _themeData = lightTheme;
      notifyListeners();
    }
  }


}