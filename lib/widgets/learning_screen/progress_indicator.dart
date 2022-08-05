import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../utils/showcase_manager.dart';
import '../../widgets/showcase_wrapper.dart';

class CircularProgressBar extends StatefulWidget {
  Future<bool> Function(
          {required void Function(int count, int total) onReceiveProgress})
      progressTask;
  int count = 0;
  int total = 0;
  final String? label;

  CircularProgressBar({required this.progressTask, this.label});

  @override
  State<StatefulWidget> createState() {
    return CircularProgressBarState();
  }
}

class CircularProgressBarState extends State<CircularProgressBar> {

  @override
  void initState() {
    super.initState();
    if (widget.total == 0) // means [Download] button will show
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ShowCaseWidget.of(context).startShowCase([ShowcaseManager.downloadShowcaseKey]);
    });
  }

  @override
  Widget build(BuildContext context) {
    void onReceiveProgress(int count, int total) {
      widget.count = count;
      widget.total = total;
      setState(() {});
    }

    if (widget.total != 0)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.count != 0)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: widget.count / widget.total,
                  // semanticsLabel: widget.label,
                  // semanticsValue: "${widget.count} / ${widget.total}",
                ),
                Text("${widget.count}/${widget.total}"),
              ],
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("The server is preparing your data, please wait..."),
              ],
            )
        ],
      );
    else
      return ShowcaseWrapper(
        showcaseKey: ShowcaseManager.downloadShowcaseKey,
        description: "You can download your first vocab list here",
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () async {
              widget.total = 1;
              setState(() {});
              bool success = await widget.progressTask(
                  onReceiveProgress: onReceiveProgress);
              if (success)
                FLog.info(text: "[LearningScreen] update vocab list Success!");
              else
                FLog.warning(
                    text: "[LearningScreen] update vocab list Failed!");
            },
            child: Text("Download"),
          ),
        ),
      );
  }
}
