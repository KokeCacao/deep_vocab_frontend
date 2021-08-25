import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:deep_vocab/models/version_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'constants.dart';
import 'dialog_manager.dart';
import 'http_widget.dart';

class Util {
  static String enumToString(o) => o.toString().split('.').last;

  static T? enumFromString<T>(Iterable<T> values, String value) {
    return values
        .firstWhereOrNull((type) => type.toString().split('.').last == value);
  }

  static void checkForUpdate(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    Map<String, dynamic>? map = await HttpWidget.graphQLQuery(
        context: context,
        queryString: Constants.UPDATE_QUERY,
        operation: Constants.UPDATE_QUERY_OPERATION,
        queryName: Constants.UPDATE_QUERY_NAME,
        onDuplicate: () => null,
        onFail: (exception, map) => null,
        variables: {
          "version": packageInfo.version,
          "buildNumber": packageInfo.buildNumber,
        });
    if (map == null) return;

    VersionModel versionModel = VersionModel.fromJson(map);

    if (!versionModel.shouldUpdate!) {
      DialogManager.choice(
          context,
          "There is an Update!",
          "The current version is v${packageInfo.version} build: ${packageInfo.buildNumber}.\n You can update to v${versionModel.latestVersion!} build: ${versionModel.latestBuildNumber!}.",
          () {},
          () {});
    } else {
      if (versionModel.breaking!) {
        DialogManager.choice(
            context,
            "Breaking Change!",
            "You must update the app otherwise it will break.\nThe current version is v${packageInfo.version} build: ${packageInfo.buildNumber}.\n You can update to v${versionModel.latestVersion!} build: ${versionModel.latestBuildNumber!}.",
            () {},
            () {});
      } else {
        DialogManager.choice(
            context,
            "You are participating the Alpha Test of Deep Vocab",
            "Thank you so much for testing it.\n The current version is v${packageInfo.version} build: ${packageInfo.buildNumber}.\n This is the latest version.",
            () {},
            () {});
      }
    }
  }
}
