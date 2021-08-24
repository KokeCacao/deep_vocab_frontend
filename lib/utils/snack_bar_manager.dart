import 'package:f_logs/f_logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarManager {

  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);
    scaffoldMessengerState.clearSnackBars();
    scaffoldMessengerState.showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1),
    ));
    FLog.info(text: "[SnackBarManager] $text");
  }

  static SnackBar showPersistentSnackBar(BuildContext context, String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);
    scaffoldMessengerState.clearSnackBars();
    scaffoldMessengerState.showSnackBar(snackBar);
    FLog.info(text: "[SnackBarManager] $text");
    return snackBar;
  }

  static void hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

}