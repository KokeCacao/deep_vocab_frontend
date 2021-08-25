import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogManager {
  static Future<bool> choice(BuildContext context, String title, String content,
      void Function() confirm, void Function() cancel,
      {String confirmText = "Confirm", String cancelText = "Cancel"}) async {
    bool b = await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  confirm();
                },
                child: Text(confirmText),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  cancel();
                },
                child: Text(cancelText),
              ),
            ],
          );
        });
    return b;
  }

  static Future<void> alert(BuildContext context, void Function() callback,
      String title, String content) async {
    await showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          // TODO: add some animation here
          return AlertDialog(title: Text(title), content: Text(content));
        });
    callback();
  }
}
