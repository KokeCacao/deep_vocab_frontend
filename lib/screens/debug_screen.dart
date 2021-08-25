import 'dart:io';

import 'package:deep_vocab/utils/file_manager.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:deep_vocab/utils/snack_bar_manager.dart';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sembast/sembast.dart';

class DebugScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DebugScreenState();
  }
}

class _DebugScreenState extends State<DebugScreen> {
  Future<NetworkException?> upload(File file) async {
    Map<String, dynamic>? map = await HttpWidget.graphQLUploadMutation(
      context: context,
      file: file,
      onSuccess: (Map<String, dynamic>? response) => response,
      onFail: (String exception) =>
          <String, dynamic>{"errorMessage": exception},
    );

    FileManager.deteleFile(file.path);

    if (map == null)
      return Future.value(
          NetworkException(message: "duplicated request", uri: null));
    if (map.containsKey("errorMessage"))
      return Future.value(
          NetworkException(message: map["errorMessage"], uri: null));

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            child: Icon(Icons.arrow_back_ios),
            padding: EdgeInsets.zero,
            onPressed: Navigator.of(context).maybePop,
          ),
          middle: Text("Logs"),
          trailing: IconButton(
              onPressed: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                showAboutDialog(
                    context: context,
                    applicationName: packageInfo.appName,
                    applicationVersion:
                        "v${packageInfo.version} (build: ${packageInfo.buildNumber})",
                    applicationLegalese:
                        "Build Signature: ${packageInfo.buildSignature}");
              },
              icon: Icon(Icons.info)),
          backgroundColor: Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.transparent)),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                    child: FutureBuilder(
                        future: FLog.getAllLogs(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return SizedBox.shrink();
                          List<Log> logs = snapshot.data;
                          List<String> strings = logs.map((e) {
                            String s =
                                "[${e.logLevel}] (${e.timestamp}) ${e.className}/${e.methodName} ${e.text}";
                            if (e.logLevel == LogLevel.FATAL ||
                                e.logLevel == LogLevel.FATAL)
                              s = s + " ${e.stacktrace}";
                            return s;
                          }).toList();

                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: strings.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Text(strings[i]);
                            },
                          );
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          File f = await FLog.exportLogs();
                          NetworkException? e = await upload(f);
                          if (e == null)
                            SnackBarManager.showSnackBar(
                                context, "Upload Success!");
                          else
                            SnackBarManager.showSnackBar(
                                context, "Upload Failed!");
                        },
                        icon: Icon(Icons.cloud_upload),
                        label: Text("Upload")),
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {});
                          SnackBarManager.showSnackBar(
                              context, "Refresh Success!");
                        },
                        icon: Icon(Icons.refresh),
                        label: Text("Refresh")),
                    ElevatedButton.icon(
                        onPressed: () {
                          // Delete Logs by Filter (older then 1 hour)
                          FLog.deleteAllLogsByFilter(filters: [
                            Filter.lessThan(
                                DBConstants.FIELD_TIME_IN_MILLIS,
                                DateTime.now().millisecondsSinceEpoch -
                                    1000 * 60 * 60)
                          ]);
                          setState(() {});
                          SnackBarManager.showSnackBar(
                              context, "Delete Success!");
                        },
                        onLongPress: () async {
                          await FLog.clearLogs();
                          setState(() {});
                        },
                        icon: Icon(Icons.delete_forever),
                        label: Text("Delete")),
                  ],
                ),
              ],
            )));
  }
}
