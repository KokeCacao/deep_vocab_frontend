import '/models/vocab_model.dart';
import '/view_models/vocab_list_view_model.dart';
import '/widgets/learning_screen/no_transition_dialog.dart';
import '/widgets/vocab_dialog/vocab_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VocabDialog {
  static Future showVocabDialog({required String vocabId, required String? vocab, required BuildContext context}) {
    // PanelController must be initialized here for future builder
    PanelController panelController = PanelController();
    return showNoTransitionDialog(
        context: context,
        builder: (context) {
          return StreamBuilder(
            stream: Provider.of<VocabListViewModel>(context, listen: false).watchFromDatabaseById(vocabId: vocabId),
            builder: (ctx, snapshot) {
              if (snapshot.data == null)
                return VocabPanel(
                  panelController: panelController,
                  // TODO: get VocabModel from id
                  vocabModel: VocabModel(
                    vocabId: "null",
                    edition: DateTime.now(),
                    listIds: [0],
                    vocab: "null",
                    type: VocabType.adj,
                    mainTranslation: "null",
                    otherTranslation: [],
                    mainSound: "sound",
                    otherSound: [],
                    englishTranslation: "none",
                    comments: [],
                    confusingWords: [],
                    memTips: "top",
                    exampleSentences: ["eg"],
                  ),
                );
              else {
                VocabModel? vocab = snapshot.data as VocabModel?;
                return VocabPanel(panelController: panelController,vocabModel: vocab);
              }
            },
          );
        });
  }
}
