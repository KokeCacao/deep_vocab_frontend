import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/models/hive_models/settings_model.dart';
import 'package:deep_vocab/models/hive_models/user_model.dart';
import 'package:deep_vocab/utils/hive_box.dart';
import 'package:deep_vocab/utils/route_table.dart';
import 'package:deep_vocab/screens/navigation_screen.dart';
import 'package:deep_vocab/view_models/auth_view_model.dart';
import 'package:deep_vocab/view_models/settings_view_model.dart';
import 'package:deep_vocab/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

/*
  learn more about shortcuts: https://medium.com/flutter-community/flutter-ide-shortcuts-for-faster-development-2ef45c51085b
 */
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<HiveBox> init() async {
    HiveBox hiveBox = HiveBox();
    await hiveBox.init(); // because can't await constructor

    // TODO: don't know how it works, but it is showed here https://www.bilibili.com/video/BV1qE411i7Pw
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark));
    }

    // extra wait
    await Future.delayed(Duration(seconds: 0));
    return Future.value(hiveBox);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( // future builder here to separate pages
        future: init(), // init has to run before MultiProvider because Hive.openBox is async
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            print("[Init] initializing");
            return MaterialApp(
              home: Scaffold(
                body: Center(child: AutoSizeText("Deep Vocab")),
              ),
            );
          }
          HiveBox hiveBox = snapshot.data;
          return MultiProvider(
            providers: [
              Provider<HiveBox>.value(value: hiveBox),
              ChangeNotifierProvider<AuthViewModel>(
                create: (ctx) =>
                    AuthViewModel(box: HiveBox.getBox(HiveBox.SINGLETON_BOX)),
                lazy: false, // initiate AuthViewModel when start
              ),
              ChangeNotifierProvider<UserViewModel>(
                create: (ctx) =>
                    UserViewModel(box: HiveBox.getBox(HiveBox.SINGLETON_BOX)),
                lazy: true, // UserViewModel should initialize after AuthViewModel
              ),
              ChangeNotifierProvider<SettingsViewModel>(
                create: (ctx) => SettingsViewModel(),
              ),
            ],
            child: MaterialApp(
              title: "Deep Vocab",
              debugShowCheckedModeBanner: false, // disable debug banner
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
            ),
          );
        });
  }

  @override
  void dispose() {
    Hive.close(); // tmp for testing
    super.dispose();
  }
}
