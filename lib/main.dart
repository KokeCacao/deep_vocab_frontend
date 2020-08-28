import 'dart:io';

import 'package:deep_vocab/screens/explore_screen.dart';
import 'package:deep_vocab/screen_templates/learning_screen.dart';
import 'package:deep_vocab/screens/stats_screen.dart';
import 'package:deep_vocab/screen_templates/navigation_screen.dart';
import 'package:deep_vocab/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
//            home: TabsScreen(),
      initialRoute: NavigationScreen.routeName,
      routes: {
        /***
         * align with _pages variable in tabs_screen
         * default pageIndex is 0
         */
        NavigationScreen.routeName: (context) => NavigationScreen(),
        LearningScreen.routeName: (context) => NavigationScreen(pageIndex: 0),
        ExploreScreen.routeName: (context) => NavigationScreen(pageIndex: 1),
        StatsScreen.routeName: (context) => NavigationScreen(pageIndex: 2),
        UserScreen.routeName: (context) => NavigationScreen(pageIndex: 3),
      },
      onUnknownRoute: (_) {
        Stream.periodic(period)
        throw Exception("UnknownRoute");
      },
    );
  }
}
