import 'dart:io';

import 'package:deep_vocab/utils/route_table.dart';
import 'package:deep_vocab/screens/explore_screen.dart';
import 'package:deep_vocab/screen_templates/learning_screen.dart';
import 'package:deep_vocab/screens/stats_screen.dart';
import 'package:deep_vocab/screen_templates/navigation_screen.dart';
import 'package:deep_vocab/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/*
  learn more about shortcuts: https://medium.com/flutter-community/flutter-ide-shortcuts-for-faster-development-2ef45c51085b
 */
void main() {
  runApp(MyApp());

  // TODO: don't know how it works, but it is showed here https://www.bilibili.com/video/BV1qE411i7Pw
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Vocab',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(
            minWidth: 0,
            height: 0,
            textTheme: ButtonTextTheme.normal,
            layoutBehavior: ButtonBarLayoutBehavior.padded,
            alignedDropdown: false,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          )),
      home: NavigationScreen(),
      onGenerateRoute: RouteTable.onGenerateRoute,
      onUnknownRoute: (_) {
        throw Exception("UnknownRoute");
      },
    );
  }
}
