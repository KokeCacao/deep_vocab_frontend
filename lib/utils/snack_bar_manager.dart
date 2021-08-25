import 'package:auto_size_text/auto_size_text.dart';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarManager {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    scaffoldMessengerState.clearSnackBars();
    scaffoldMessengerState.showSnackBar(SnackBar(
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: AutoSizeText(
          text,
          overflow: TextOverflow.fade,
          maxLines: 1,
        ),
      ),
      duration: const Duration(seconds: 3),
    ));
    FLog.info(text: "[SnackBarManager] $text");
  }

  static SnackBar showPersistentSnackBar(BuildContext context, String text) {
    SnackBar snackBar = SnackBar(
      content: Row(
        children: <Widget>[CircularProgressIndicator(), Text(text)],
      ),
      duration: const Duration(days: 1),
    );
    ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    scaffoldMessengerState.clearSnackBars();
    scaffoldMessengerState.showSnackBar(snackBar);
    FLog.info(text: "[SnackBarManager] $text");
    return snackBar;
  }

  static void hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
