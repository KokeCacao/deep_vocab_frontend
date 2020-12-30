import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/models/settings_model.dart';
import 'package:deep_vocab/models/user_model.dart';
import 'package:deep_vocab/utils/graphql_init.dart';
import 'package:deep_vocab/utils/route_table.dart';
import 'package:deep_vocab/screen_templates/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  Future<dynamic> init() async {
    // final Directory documentDirectory = await getApplicationDocumentsDirectory();
    // Hive.init(documentDirectory.path);
    await Hive.initFlutter();

    // run flutter-generate to generate models
    // registering generated model
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(SettingsModelAdapter());

    // open box
    Box<dynamic> userBox = await Hive.openBox<UserModel>("user");
    Box<dynamic> settingsBox = await Hive.openBox<SettingsModel>("settings");

    // TODO: don't know how it works, but it is showed here https://www.bilibili.com/video/BV1qE411i7Pw
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark));
    }

    // extra wait
    Future<dynamic> future = Future.delayed(Duration(seconds: 0));
    return future;
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLInit(
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
      home: FutureBuilder(
        future: init(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Scaffold(body: Center(child: AutoSizeText("Deep Vocab")),
            );
          return NavigationScreen();
        },
      ),
      onGenerateRoute: RouteTable.onGenerateRoute,
      onUnknownRoute: (_) {
        throw Exception("UnknownRoute");
      },
    ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
