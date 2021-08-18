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
            case '/learning_screen':
              return NavigationScreen(pageIndex: 0);
            case '/explore_screen':
              return NavigationScreen(pageIndex: 1);
            case '/stats_screen':
              return NavigationScreen(pageIndex: 2);
            case '/user_screen':
              return NavigationScreen(pageIndex: 3);
            case '/login_screen':
              return LoginScreen();
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
