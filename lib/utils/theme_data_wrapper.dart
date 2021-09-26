import 'package:flutter/material.dart';

enum ThemeStyle {
  day,
  night,
}

class ThemeDataWrapper extends ChangeNotifier {
  /// storage
  final BuildContext context;

  ThemeStyle _theme;
  ThemeData _day = ThemeData(
      brightness: Brightness.light, // light mode or dark mode
      primarySwatch: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
        minWidth: 0,
        height: 0,
        textTheme: ButtonTextTheme.normal,
        layoutBehavior: ButtonBarLayoutBehavior.padded,
        alignedDropdown: false,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      ));
  ThemeData _night = ThemeData(
      brightness: Brightness.dark, // light mode or dark mode
      primarySwatch: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
        minWidth: 0,
        height: 0,
        textTheme: ButtonTextTheme.normal,
        layoutBehavior: ButtonBarLayoutBehavior.padded,
        alignedDropdown: false,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      ));

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  ThemeDataWrapper({required this.context}): _theme = ThemeStyle.day;

  ThemeData get themeData {
    switch (_theme) {
      case ThemeStyle.day: return _day;
      case ThemeStyle.night: return _night;
      default: return _day;
    }
  }

  void switchTheme(ThemeStyle to) {
    _theme = to;
    notifyListeners();
  }

  void nextTheme() {
    if (_theme == ThemeStyle.day) _theme = ThemeStyle.night;
    else if (_theme == ThemeStyle.night) _theme = ThemeStyle.day;
    notifyListeners();
  }
}
