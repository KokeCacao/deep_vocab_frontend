import 'package:auto_size_text/auto_size_text.dart';
import '../../utils/theme_data_wrapper.dart';
import '../vocab_dialog/triangle_shape.dart';
import '/controllers/vocab_state_controller.dart';
import '/screens/vocab_dialog.dart';
import '/widgets/separator.dart';
import '/widgets/vocab_dialog/bookmark_shape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VocabRow extends StatefulWidget {
  bool hide;
  bool cross;
  bool checkBox;

  final void Function(bool value)? onSelect;
  final void Function(bool value)? onHide;
  final String vocabId;
  final String? vocab;
  final String? translation;
  final bool? bookMarked;
  final bool? triangle;

  VocabRow(
      {this.hide = true,
      this.cross = false,
      this.checkBox = false,
      this.onSelect,
      this.onHide,
      required this.vocabId,
      required this.vocab,
      required this.translation,
      this.bookMarked = false,
      this.triangle = false});

  @override
  State<StatefulWidget> createState() {
    return VocabRowState();
  }

  VocabRow copyWith(
      {bool? hide,
      bool? cross,
      bool? checkBox,
      void Function(bool value)? onSelect,
      String? vocab,
      String? translation,
      bool? bookMarked,
      bool? triangle}) {
    return VocabRow(
      vocabId: this.vocabId,
      vocab: this.vocab,
      translation: this.translation,
      hide: hide ?? this.hide,
      cross: cross ?? this.cross,
      checkBox: checkBox ?? this.checkBox,
      onSelect: onSelect ?? this.onSelect,
      bookMarked: bookMarked ?? this.bookMarked,
      triangle: triangle ?? this.triangle,
    );
  }
}

class VocabRowState extends State<VocabRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Provider.of<ThemeDataWrapper>(context, listen: false).background,
        border: Border(
            bottom: BorderSide(
          width: 1,
        )),
      ),
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          DragTarget(onWillAccept: (dynamic _) {
            widget.checkBox = !widget.checkBox;
            if (widget.checkBox)
              Provider.of<VocabStateController>(context, listen: false)
                  .selectedVocabIdAdd(widget.vocabId);
            else
              Provider.of<VocabStateController>(context, listen: false)
                  .selectedVocabIdRemove(widget.vocabId);

            if (widget.onSelect != null) widget.onSelect!(widget.checkBox);
            setState(() {});
            return false;
          }, builder: (ctx, candidateData, rejectedData) {
            return Draggable(
                axis: Axis.vertical,
                feedback: SizedBox
                    .shrink(), // See: https://stackoverflow.com/questions/53455358/how-to-present-an-empty-view-in-flutter
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Checkbox(
                        value: widget.checkBox,
                        onChanged: (bool) {
                          widget.checkBox = bool!;
                          if (widget.checkBox)
                            Provider.of<VocabStateController>(context,
                                    listen: false)
                                .selectedVocabIdAdd(widget.vocabId);
                          else
                            Provider.of<VocabStateController>(context,
                                    listen: false)
                                .selectedVocabIdRemove(widget.vocabId);

                          if (widget.onSelect != null)
                            widget.onSelect!(widget.checkBox);
                          setState(() {});
                        },
                        activeColor: Provider.of<ThemeDataWrapper>(context, listen: false).textColor,
                        checkColor: Provider.of<ThemeDataWrapper>(context, listen: false).tab,
                        focusColor: Provider.of<ThemeDataWrapper>(context, listen: false).tabtab,
                        hoverColor: Provider.of<ThemeDataWrapper>(context, listen: false).tabtab,
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
                  onTap: () => VocabDialog.showVocabDialog(
                      vocabId: widget.vocabId,
                      vocab: widget.vocab,
                      context: context),
                  child: AutoSizeText(widget.vocab!,
                      minFontSize: 12,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: TextStyle(
                          decoration: widget.cross
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: widget.cross
                              ? Provider.of<ThemeDataWrapper>(context,
                                      listen: false)
                                  .fadeTextColor
                              : Provider.of<ThemeDataWrapper>(context,
                                      listen: false)
                                  .textColor)),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    widget.hide = !widget.hide;
                    if (widget.hide)
                      Provider.of<VocabStateController>(context, listen: false)
                          .unhideVocabIdRemove(widget.vocabId);
                    else
                      Provider.of<VocabStateController>(context, listen: false)
                          .unhideVocabIdAdd(widget.vocabId);

                    if (widget.onHide != null) widget.onHide!(widget.hide);
                    setState(() {});
                  },
                  child: IndexedStack(
                    alignment: AlignmentDirectional.center,
                    index: widget.hide ? 1 : 0,
                    children: [
                      AutoSizeText(
                        widget.translation!,
                        minFontSize: 12,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: TextStyle(
                            decoration: widget.cross
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: widget.cross
                                ? Provider.of<ThemeDataWrapper>(context,
                                        listen: false)
                                    .fadeTextColor
                                : Provider.of<ThemeDataWrapper>(context,
                                        listen: false)
                                    .textColor),
                      ),
                      Padding(
                        // black cover of the word
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 4),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Provider.of<ThemeDataWrapper>(context, listen: false).tab,
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
                    backgroundColor: Provider.of<ThemeDataWrapper>(context, listen: false).blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Provider.of<ThemeDataWrapper>(context, listen: false).blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Provider.of<ThemeDataWrapper>(context, listen: false).blue,
                  ),
                ),
                Separator(
                  axis: Axis.vertical,
                  color: Colors.transparent,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: BookmarkShape(
                        height: 15, // half of vocab row
                        width: 8,
                        borderRadius: 0,
                        color: widget.bookMarked!
                            ? Provider.of<ThemeDataWrapper>(context, listen: false).red
                            : Colors.transparent,
                        borderColor: widget.bookMarked!
                            ? Colors.black12
                            : Colors.transparent,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: TriangleShape(
                        height: 12, // half of vocab row
                        width: 8,
                        borderRadius: 0,
                        color: widget.triangle!
                            ? Provider.of<ThemeDataWrapper>(context, listen: false).blue
                            : Colors.transparent,
                        borderColor: widget.triangle!
                            ? Colors.black12
                            : Colors.transparent,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
