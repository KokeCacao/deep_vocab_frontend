import 'dart:math';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:deep_vocab/models/version_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  static int intUUID() =>
      (DateTime.now().millisecondsSinceEpoch / 1000).round();

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

  /// Calculates the edit distance from src : string to tgt : string,
  /// where the cost to insert / delete / alter any character, or to change from one
  /// character to another, can be specified in argument via functions
  /// 'insertCost', 'deleteCost', and 'editCost'. As a result, such distance
  /// may not be necessarily commutative.
  ///
  /// @in [String src] the source string
  /// @in [String tgt] the target string
  /// @in [int insertCost(String c)] computes the cost to insert char c.
  /// @in [int deleteCost(String c)] computes the cost to delete char c.
  /// @in [int editCost(String s, String t)] computes the cost to edit from
  ///   char s to char t.
  ///
  /// @return the edit distance from src to tgt.
  ///
  static int genericLevenshtein(String src, String tgt,
      int Function(String) insertCost,
      int Function(String) deleteCost,
      int Function(String, String) alterCost) {

    int l1 = src.length, l2 = tgt.length;

    // initialize a 2D array for dynamic programming.
    var dp = List.generate(l1+1, (_) => List.filled(l2+1, 233));

    // initialize upper left corner.
    dp[0][0] = 0;

    // Propagates the first row and column of dynamic programming array.
    // Note that entries in the first row / column indicates the min edit
    // distance from / to an empty string.
    for(int i = 1; i <= l1; i++){
      dp[i][0] = deleteCost(src[i-1]) + dp[i-1][0];
    }
    for(int j = 1; j <= l2; j++){
      dp[0][j] = insertCost(tgt[j-1]) + dp[0][j-1];
    }

    // propagate the rest of dp array.
    for(int i = 1; i <= l1; i++){
      for(int j = 1; j <= l2; j++){
        var s = src[i-1], t = tgt[j-1];
        int insertCumulativeCost = insertCost(t) + dp[i][j-1];
        int deleteCumulativeCost = deleteCost(s) + dp[i-1][j];
        int alterCumulativeCost = alterCost(s,t) + dp[i-1][j-1];
        dp[i][j] = min(alterCumulativeCost, min(insertCumulativeCost, deleteCumulativeCost));
      }
    }

    return dp[l1][l2];
  }
}
