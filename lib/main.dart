import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:graphql/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:f_logs/f_logs.dart' hide AppDatabase, Constants;
import 'package:showcaseview/showcaseview.dart';

import './models/vocab_model.dart';
import './utils/vocab_notification.dart';
import 'widgets/init_callback.dart';
import './controllers/vocab_state_controller.dart';
import './models/sqlite_models/app_database.dart';
import './utils/theme_data_wrapper.dart';
import './utils/hive_box.dart';
import './utils/route_table.dart';
import './screens/navigation_screen.dart';
import './view_models/auth_view_model.dart';
import './view_models/settings_view_model.dart';
import './view_models/user_view_model.dart';
import './view_models/vocab_list_view_model.dart';

import 'view_models/http_sync_view_model.dart';

// [Android-only] This "Headless Task" is run when the Android app
// is terminated with enableHeadless: true
// this is not used in the current version
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    FLog.warning(text: "[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  FLog.info(text: "[BackgroundFetch] Headless event received.");
  // Do your work here...
  BackgroundFetch.finish(taskId);
  return;
}

// learn more about shortcuts: https://medium.com/flutter-community/flutter-ide-shortcuts-for-faster-development-2ef45c51085b
void main() {
  runApp(MyApp());

  // part of setup for [flutter_background_fetch] package
  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initPlatformState(BuildContext context) async {
    // Configure BackgroundFetch.
    BackgroundFetchConfig backgroundFetchConfig = BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE);

    int status = await BackgroundFetch.configure(backgroundFetchConfig,
        (String taskId) async {
      FLog.info(text: "[BackgroundFetch] Event received: $taskId");

      NetworkException? exception;
      try {
        VocabListViewModel? vocabListViewModel =
            Provider.of<VocabListViewModel>(context, listen: false);
        exception = await vocabListViewModel.refreshVocab(context);
      } catch (e) {
        FLog.error(
            text: "VocabListViewModel not found."
                "This is likely a bug caused by hot reload."
                "If the but persists in production, we have a problem.");
        BackgroundFetch.finish(taskId);
        return;
      }

      if (exception == null) {
        FLog.info(text: "[BackgroundFetch] Refresh Vocab Success");

        List<VocabModel>? vocabs =
            (await Provider.of<VocabListViewModel>(context, listen: false)
                    .getFromDatabase(pushedMark: true))
                .vocabs;
        if (vocabs != null && vocabs.length != 0) {
          VocabModel vocab = vocabs[0];
          VocabNotification.createNotification(
              "${vocab.vocab}", vocab.vocabId.hashCode);
        }
      } else
        FLog.warning(text: "[BackgroundFetch] Refresh Vocab Failed");

      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
      return;
    }, (String taskId) async {
      FLog.warning(text: "[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      // This task has exceeded its allowed running-time.
      // You must stop what you're doing and immediately .finish(taskId)
      BackgroundFetch.finish(taskId);
      return;
    });

    FLog.info(text: "[BackgroundFetch] configure success: $status");

    // Config Permission
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.notification.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else if (await Permission.notification.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.photos.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else if (await Permission.photos.isPermanentlyDenied) {
      openAppSettings();
    }

    // Config Notification Permission
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // TODO: You must show some friendly dialog box before call it
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Future<Map<String, dynamic>> init() async {
    // init HiveBox
    HiveBox hiveBox = HiveBox();
    await hiveBox.init(); // because can't await constructor

    // init AppDatabase
    AppDatabase appDatabase = AppDatabase();

    // TODO: don't know how it works, but it is showed here https://www.bilibili.com/video/BV1qE411i7Pw
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark));
    }

    VocabNotification.initializeNotification();

    // extra wait
    await Future.delayed(Duration(seconds: 0));
    return Future.value({"HiveBox": hiveBox, "AppDatabase": appDatabase});
  }

  @override
  Widget build(BuildContext context) {
    MaterialApp emptyApp = MaterialApp(
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

    return FutureBuilder(
        // future builder here to separate pages
        future:
            init(), // init has to run before MultiProvider because Hive.openBox is async
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            FLog.info(text: "[Init] initializing");
            return emptyApp;
          }
          // getting initialized data
          Map<String, dynamic>? data = snapshot.data;
          if (data == null) {
            FLog.error(
                text:
                    "snapshot.data is null. This is likely a bug caused by hot reload.");
            return emptyApp;
          }
          AppDatabase appDatabase = data["AppDatabase"];

          return MultiProvider(
            providers: [
              Provider<AppDatabase>.value(value: appDatabase),
              ChangeNotifierProvider<AuthViewModel>(
                create: (ctx) => AuthViewModel(context: ctx),
                lazy: false,
              ),
              ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
                create: (ctx) => UserViewModel(
                    context: ctx, connectionStatus: ConnectionState.waiting),
                update: (ctx, authViewModel, oldUserViewModel) => UserViewModel(
                    context: ctx, connectionStatus: ConnectionState.done),
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
              ),
              ChangeNotifierProvider<ThemeDataWrapper>(
                  create: (ctx) => ThemeDataWrapper(context: ctx))
            ],
            builder: (context, child) {
              return Consumer<ThemeDataWrapper>(
                builder: (BuildContext context, ThemeDataWrapper wrapper,
                    Widget? child) {
                  return InitCallback(
                      callBack:
                          initPlatformState, // schedule initPlatformState after build complete
                      temporary: emptyApp,
                      child: ShowCaseWidget(
                        builder: Builder(
                          builder: (context) => MaterialApp(
                            title: "Deep Vocab",
                            debugShowCheckedModeBanner:
                                false, // disable debug banner
                            theme: wrapper.themeData,
                            home:
                                child, // so that NavigationScreen() don't get rebuild after changing theme data
                            onGenerateRoute: RouteTable.onGenerateRoute,
                            onUnknownRoute: (_) {
                              throw Exception("UnknownRoute");
                            },
                          ),
                        ),
                        onComplete: (i, showcaseKey) {
                          HiveBox.put(
                              HiveBox.SHOWCASE_BOX, showcaseKey.toString(), true);
                          return;
                        },
                      ));
                },
                child:
                    NavigationScreen(), // This way NavigationScreen() class won't rebuild so change dark mode will preserve state
              );
            },
          );
        });
  }

  @override
  void dispose() async {
    Hive.close(); // tmp for testing
    await VocabNotification.decomposeNotification();
    super.dispose();
  }
}
