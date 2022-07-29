import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deep_vocab/utils/util.dart';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';

class VocabNotification {
  static void initializeNotification() {
    // init Notification
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/res_icon_353x353',
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Notifications',
              channelDescription: 'Deep Vocab Notification',
              defaultColor: Colors.teal,
              importance: NotificationImportance.High,
              channelShowBadge: true,
              ledColor: Colors.white)
        ],
        debug: false);

    // register Notification event, this seem to cause '[]' was called on null
    // when it is inside FutureBuilder. This is because we can't listen twice in one application
    // refer to https://github.com/rafaelsetragni/awesome_notifications/issues/198
    /// refer to https://pub.dev/packages/awesome_notifications#flutter-streams
    /// and https://github.com/rafaelsetragni/awesome_notifications/issues/242#issuecomment-891831987
    /// to see all stream related to user actions
    try {
      AwesomeNotifications()
          .actionStream
          .listen((ReceivedAction receivedNotification) async {
        if (receivedNotification.channelKey == 'basic_channel') {
          if (receivedNotification.buttonKeyPressed == '') {
            FLog.info(
                text:
                    "User clicked the notification without clicking the button");
            return;
          }
          // On Android, only maximum of 3 buttons can be displayed
          // More buttons need custom layout
          // TODO: costom layout for Android support
          // https://github.com/rafaelsetragni/awesome_notifications/issues/455
          FLog.info(
              text:
                  "Pressed ${receivedNotification.buttonKeyPressed} for vocab ${receivedNotification.title}");
          AwesomeNotifications().getGlobalBadgeCounter().then((value) =>
              AwesomeNotifications()
                  .setGlobalBadgeCounter(value - 1 > 0 ? value - 1 : 0));
        }
      });
    } catch (e) {
      FLog.error(
          text:
              "You are likly trying to listen to event stream twice. It is normal for hot-reload.");
    }
  }

  static Future<void> decomposeNotification() async {
    AwesomeNotifications().actionSink.close(); // close action stream
    await AwesomeNotifications()
        .dispose(); // un-listen events to prevent double listen when hot reload
    return Future.value(null);
  }

  /// Android	App in Foreground	App in Background	App Terminated (Killed)
  /// Default	keeps the app in foreground	brings the app to foreground	brings the app to foreground
  /// InputField	keeps the app in foreground	brings the app to foreground	brings the app to foreground
  /// DisabledAction	keeps the app in foreground	keeps the app in background	keeps the app terminated
  /// KeepOnTop	keeps the app in foreground	keeps the app in background	keeps the app terminated
  // TODO: vocab.vocabId.hashCode may not be 100% safe, as the hashcode may collide for different string
  static void createNotification(String vocab, int id) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          icon: 'resource://drawable/res_icon_353x353',
          id: id, // if you want every notification to be unique, use Util.intUUID()
          channelKey: 'basic_channel',
          title: vocab,
          body: '(Long Press to Memorize)',
          wakeUpScreen: true,
          autoDismissible: false,
          progress: 50,
          category: NotificationCategory.Reminder,
        ),
        actionButtons: [
          NotificationActionButton(
              key: '0', label: "完全遗忘", buttonType: ActionButtonType.KeepOnTop),
          NotificationActionButton(
              key: '1', label: "不知其意", buttonType: ActionButtonType.KeepOnTop),
          NotificationActionButton(
              key: '2', label: "记忆混淆", buttonType: ActionButtonType.KeepOnTop),
          NotificationActionButton(
              key: '3', label: "记忆正确", buttonType: ActionButtonType.KeepOnTop),
        ]);
  }
}
