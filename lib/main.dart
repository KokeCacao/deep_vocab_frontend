import 'dart:io';

import './controllers/vocab_state_controller.dart';
import './models/sqlite_models/app_database.dart';
import './utils/hive_box.dart';
import './utils/route_table.dart';
import './screens/navigation_screen.dart';
import './view_models/auth_view_model.dart';
import './view_models/settings_view_model.dart';
import './view_models/user_view_model.dart';
import './view_models/vocab_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'view_models/http_sync_view_model.dart';

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
  Future<Map<String, dynamic>> init() async {
    // init HiveBox
    HiveBox hiveBox = HiveBox();
    await hiveBox.init(); // because can't await constructor

    // init AppDatabase
    AppDatabase appDatabase = AppDatabase();

    // TODO: don't know how it works, but it is showed here https://www.bilibili.com/video/BV1qE411i7Pw
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    }

    // extra wait
    await Future.delayed(Duration(seconds: 0));
    return Future.value({"HiveBox": hiveBox, "AppDatabase": appDatabase});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future builder here to separate pages
        future: init(), // init has to run before MultiProvider because Hive.openBox is async
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            print("[Init] initializing");
            return MaterialApp(
              home: Scaffold(
                body: Center(
                    child: Column(
                  children: [
                    // TODO: costomization
                    PhysicalModel(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(80.0),
                      clipBehavior: Clip.antiAlias,
                      child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: 0.5,
                        valueColor: AlwaysStoppedAnimation(Colors.amber),
                      ),
                    )
                  ],
                )),
              ),
            );
          }
          // getting initialized data
          Map<String, dynamic> data = snapshot.data;
          HiveBox hiveBox = data["HiveBox"];
          AppDatabase appDatabase = data["AppDatabase"];

          return MultiProvider(
            providers: [
              // Provider<HiveBox>.value(value: hiveBox), // TODO: figure out why do I need this provider, if not, delete
              Provider<AppDatabase>.value(value: appDatabase),
              ChangeNotifierProvider<AuthViewModel>(
                create: (ctx) => AuthViewModel(context: ctx),
                lazy: false,
              ),
              ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
                create: (ctx) => UserViewModel(context: ctx, connectionStatus: ConnectionState.waiting),
                update: (ctx, authViewModel, oldUserViewModel) => UserViewModel(context: ctx, connectionStatus: ConnectionState.done),
                lazy: false,
              ),
              ChangeNotifierProvider<SettingsViewModel>(
                create: (ctx) => SettingsViewModel(context: ctx),
              ),
              Provider<VocabListViewModel>(
                create: (ctx) => VocabListViewModel(context: ctx),
              ),
              ChangeNotifierProvider<VocabStateController>(
                // to store vocab states for a vocab list
                create: (ctx) => VocabStateController(context: ctx),
              ),
              ChangeNotifierProvider<HttpSyncViewModel>(
                create: (ctx) => HttpSyncViewModel(context: ctx),
              )
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
