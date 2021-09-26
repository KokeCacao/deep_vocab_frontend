import 'package:f_logs/f_logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    void onReceiveProgress(int count, int total) {
      widget.count = count;
      widget.total = total;
      setState(() {});
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.total != 0)
          CircularProgressIndicator(
            value: widget.count / widget.total,
            // semanticsLabel: widget.label,
            // semanticsValue: "${widget.count} / ${widget.total}",
          )
        else
          ElevatedButton(
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
          )
      ],
    );
  }
}
