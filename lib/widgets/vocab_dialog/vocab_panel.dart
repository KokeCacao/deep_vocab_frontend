import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/models/sub_models/mark_color_model.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:deep_vocab/view_models/vocab_list_view_model.dart';
import 'package:deep_vocab/widgets/separator.dart';
import 'package:deep_vocab/widgets/stateful_icon_button.dart';
import 'package:deep_vocab/widgets/vocab_dialog/bookmark_button.dart';
import 'package:deep_vocab/widgets/vocab_dialog/comment.dart';
import 'package:deep_vocab/widgets/vocab_dialog/vocab_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VocabPanel extends StatelessWidget {
  final VocabModel vocabModel;
  final PanelController panelController;

  const VocabPanel({Key key, @required this.vocabModel, @required this.panelController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderRadius = 10;
    BorderRadius border = BorderRadius.vertical(top: Radius.circular(borderRadius));

    return SlidingUpPanel(
      color: Colors.white70,
      backdropEnabled: true,
      backdropOpacity: 0.4,
      defaultPanelState: PanelState.CLOSED, // first closed to show animation
      minHeight: 0, // open by dialog
      controller: panelController,
      onPanelClosed: () {
        Navigator.of(context).pop();
      }, // close dialog
      maxHeight: MediaQuery.of(context).size.height * 0.8,
      borderRadius: border,
      // margin: EdgeInsets.symmetric(horizontal: 5),
      panelBuilder: (ScrollController scrollController) {
        panelController.open(); // hack to show opening animation
        return Material(
          type: MaterialType.transparency,
          child: ListView(
            controller: scrollController,
            children: [
              ClipRRect(
                borderRadius: border, // same as above
                child: Flex(
                  direction: Axis.horizontal,
                  children: vocabModel.markColors == null
                      ? []
                      : [
                          for (MarkColorModel markColor in vocabModel.markColors)
                            Expanded(
                              child: Container(
                                height: borderRadius,
                                color: markColor.color.color,
                              ),
                            )
                        ],
                ),
              ),
              Stack(
                children: [
                  TwoStateButton(
                      value: vocabModel.pinMark,
                      onPressed: (bool value) => Provider.of<VocabListViewModel>(context, listen: false).editUserVocab(vocabId: vocabModel.vocabId, pinMark: value)
                      ,
                      trueIcon: Icon(
                        Icons.push_pin,
                        color: Colors.blueGrey,
                      ),
                      falseIcon: Icon(
                        Icons.push_pin_outlined,
                        color: Colors.black54,
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: BookmarkButton(
                      number: vocabModel.nthWord,
                      bookmarked: vocabModel.bookMarked,
                      onChangeBookmarked: (bool value) => Provider.of<VocabListViewModel>(context, listen: false).editUserVocab(vocabId: vocabModel.vocabId, bookMarked: value)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          vocabModel.vocab,
                          maxFontSize: 64,
                          minFontSize: 42,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              // work with the Expanded below
                              child: SizedBox(),
                            ),
                            AutoSizeText(
                              vocabModel.mainTranslation,
                              maxFontSize: 32,
                              minFontSize: 16,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Align(
                                // so that its on the right side of centered widget
                                alignment: Alignment.centerLeft,
                                child: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.all(10),
                color: Colors.white60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 4,
                      children: [
                        // TODO: List.generate(data.currentPerson.tags.length, (index) => toBadge(data.currentPerson.tags.elementAt(index)))
                        for (String translation in vocabModel.otherTranslation)
                          VocabBadge(
                            text: translation,
                            color: Colors.blueGrey[700],
                          ),
                        Icon(
                          Icons.add_box,
                          color: Colors.blueGrey[700],
                        )
                      ],
                    ),
                    Separator(
                      color: Colors.transparent,
                    ),
                    Text("英译: ${vocabModel.englishTranslation}"),
                    Text("例句: ${vocabModel.exampleSentences[0]}")
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(10),
                color: Colors.white60,
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "联想空间",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Separator(
                            color: Colors.transparent,
                          ),
                          Text(vocabModel.memTips),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "混淆单词",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Separator(
                            color: Colors.transparent,
                          ),
                          for (String confusing in vocabModel.confusingWords) Text(confusing),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(10),
                color: Colors.white60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "吐槽空间",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Separator(
                      color: Colors.transparent,
                    ),
                    ListView.builder(
                      // TODO: buggy. Will rebuild each time scroll, see: https://github.com/flutter/flutter/issues/26072
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Comment(
                          uuid: "UUID",
                          userName: "Koke_Cacao",
                          dateTime: "2020/01/12 01:04:40",
                          message: "Hello World!",
                          likes: 233,
                          isLike: false,
                          avatarUrl: "http://via.placeholder.com/350x150",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
