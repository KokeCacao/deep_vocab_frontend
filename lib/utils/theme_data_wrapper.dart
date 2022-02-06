import 'package:flutter/material.dart';

enum ThemeStyle {
  day,
  night,
}

class ThemeDataWrapper extends ChangeNotifier {
  /// storage
  final BuildContext context;

  static const MaterialColor daySwatch = MaterialColor(
    0xFF474D85,
    <int, Color>{
      50: Color(0xFFFDF9F4),
      100: Color(0xFFF7EAE1),
      200: Color(0xFFD0DDEA),
      300: Color(0xFF9DBBD8),
      400: Color(0xFF9DBBD8),
      500: Color(0xFF9DBBD8),
      600: Color(0xFF5E65A5),
      700: Color(0xFF474D85),
      800: Color(0xFF393C5C),
      900: Color(0xFF272739),
    },
  );

  static const MaterialColor nightSwatch = MaterialColor(
    0xFF9DBBD8, // text color stuff
    <int, Color>{
      50: Color(0xFF272739),
      100: Color(0xFF393C5C),
      200: Color(0xFF474D85),
      300: Color(0xFF5E65A5),
      400: Color(0xFF9DBBD8),
      500: Color(0xFF9DBBD8),
      600: Color(0xFF9DBBD8),
      700: Color(0xFFD0DDEA),
      800: Color(0xFFF7EAE1),
      900: Color(0xFFFDF9F4),
    },
  );

  ThemeStyle _theme;
  ThemeData _day = ThemeData(
    brightness: Brightness.light, // light mode or dark mode
    primarySwatch: createMaterialColor(daySwatch),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
      minWidth: 0,
      height: 0,
      textTheme: ButtonTextTheme.normal,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      alignedDropdown: false,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
    ),
    scaffoldBackgroundColor: daySwatch[50],
  );
  ThemeData _night = ThemeData(
    brightness: Brightness.dark, // light mode or dark mode
    primarySwatch: createMaterialColor(nightSwatch),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
      minWidth: 0,
      height: 0,
      textTheme: ButtonTextTheme.normal,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      alignedDropdown: false,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
    ),
    scaffoldBackgroundColor: nightSwatch[50],
  );

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  ThemeDataWrapper({required this.context}) : _theme = ThemeStyle.day;

  ThemeData get themeData {
    switch (_theme) {
      case ThemeStyle.day:
        return _day;
      case ThemeStyle.night:
        return _night;
      default:
        return _day;
    }
  }

  Color get boldFont {
    return daySwatch[600]!;
  }

  Color get lightFont {
    return daySwatch[400]!;
  }

  Color get darkPanel {
    return daySwatch[300]!;
  }

  Color get lightPanel {
    return daySwatch[200]!;
  }

  Color get background {
    return (_theme == ThemeStyle.day ? daySwatch[50] : nightSwatch[50])!;
  }

  Color get tab {
    return (_theme == ThemeStyle.day ? daySwatch[100] : nightSwatch[100])!;
  }

  Color get tabtab {
    return (_theme == ThemeStyle.day ? daySwatch[200] : nightSwatch[200])!;
  }

  Color get blackContrast {
    return (_theme == ThemeStyle.day ? Colors.black12 : Colors.white12);
  }

  Color get highlightTextColor {
    return (_theme == ThemeStyle.day ? daySwatch[500] : nightSwatch[500])!;
  }

  Color get textColor {
    return (_theme == ThemeStyle.day ? daySwatch[600] : nightSwatch[600])!;
  }

  Color get fadeTextColor {
    return (_theme == ThemeStyle.day ? daySwatch[400] : nightSwatch[400])!;
  }

  Color get red {
    return Colors.red;
  }

  Color get green {
    return Colors.green;
  }

  Color get yellow {
    return Colors.yellow;
  }

  Color get blue {
    return Colors.blue;
  }

  Color get black {
    return Colors.black;
  }

  Color get white {
    return Colors.white;
  }

  void switchTheme(ThemeStyle to) {
    _theme = to;
    notifyListeners();
  }

  void nextTheme() {
    if (_theme == ThemeStyle.day)
      _theme = ThemeStyle.night;
    else if (_theme == ThemeStyle.night) _theme = ThemeStyle.day;
    notifyListeners();
  }

  /// Credit: https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
