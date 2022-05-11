import '/screens/debug_screen.dart';
import '/screens/navigation_screen.dart';
import '/screens/login_screen.dart';

import 'package:flutter/cupertino.dart';

class RouteTable extends Object {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String? route = settings.name;
    Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;

    return CupertinoPageRoute(
      builder: (context) {
        switch (route) {
          case '/':
            return NavigationScreen();
          case '/login_screen':
            if (arguments != null) {
              assert(arguments.containsKey("index"));
              assert(arguments.containsKey("state"));
              return LoginScreen(state: arguments["state"], index: arguments["index"]);
            }
            return LoginScreen();
          case '/debug_screen':
            return DebugScreen();
          default:
            throw UnimplementedError(
                "[Debug] No route widget detected for route $route");
        }
      },
      // title: null,
      // fullscreenDialog: null,
      // maintainState: null,
      // settings: null
    );
  }
}
