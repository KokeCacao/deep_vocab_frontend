import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VocabRow extends StatefulWidget {
  VocabRow({this.hide = false, this.cross = false, this.checkBox = false});
  bool hide;
  bool cross;
  bool checkBox;

  @override
  State<StatefulWidget> createState() {
    return VocabRowState();
  }
}

class VocabRowState extends State<VocabRow> {
  void switchHide() {
    widget.hide = !widget.hide;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future _showVocabDialog() {
      return showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(8.0))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AutoSizeText(
                      "grandiloquent",
                      maxFontSize: 64,
                      minFontSize: 32,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              height: 50,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              height: 50,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              height: 50,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              height: 50,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
          width: 1,
        )),
      ),
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          // GestureDetector(
          //   behavior: HitTestBehavior.opaque,
          //   onVerticalDragUpdate: (_) { // must have: so that one event can move between boxes
          //     // block behavior of [ListView]
          //     if (widget.checkBox != true || widget.cross != true) {
          //       print("gesture detected!");
          //       widget.checkBox = true;
          //       widget.cross = true;
          //       setState(() {});
          //     }
          //   },
          //   child:
          DragTarget(onWillAccept: (_) {
            widget.checkBox = !widget.checkBox;
            setState(() {});
            return false;
          }, builder: (ctx, candidateData, rejectedData) {
            return Draggable(
                axis: Axis.vertical,
                feedback: Container(),
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Checkbox(
                        value: widget.checkBox,
                        onChanged: (bool) {
                          widget.checkBox = bool;
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ));
          }),
          // ),
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: _showVocabDialog,
                  child: AutoSizeText("grandiloquent",
                      minFontSize: 12,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: TextStyle(
                          decoration: widget.cross
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: switchHide,
                  child: IndexedStack(
                    alignment: AlignmentDirectional.center,
                    index: widget.hide ? 1 : 0,
                    children: [
                      AutoSizeText(
                        "辞藻浮夸的; 夸大",
                        minFontSize: 12,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 4),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
          IntrinsicWidth(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.blueGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.blueGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.blueGrey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  height: double.infinity,
                  width: 10,
                  color: Colors.black38,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
