import '/screens/debug_screen.dart';
import '/screens/navigation_screen.dart';
import '/screens/login_screen.dart';

import 'package:flutter/cupertino.dart';

class RouteTable extends Object {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String? route = settings.name;
    // Object? arguments = settings.arguments;

    return CupertinoPageRoute(
      builder: (context) {
        switch (route) {
          case '/':
            return NavigationScreen();
          case '/login_screen':
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
