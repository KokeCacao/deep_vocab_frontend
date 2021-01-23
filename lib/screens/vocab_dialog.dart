import 'package:deep_vocab/models/vocab_model.dart';
import 'package:deep_vocab/widgets/learning_screen/no_transition_dialog.dart';
import 'package:deep_vocab/widgets/vocab_dialog/vocab_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VocabDialog {
  static Future showVocabDialog(
      {@required String vocab, @required BuildContext context}) {
    return showNoTransitionDialog(
        context: context,
        builder: (context) {
          return VocabPanel(
            vocabViewModel: VocabModel(
              id: "1",
              edition: 0,
              listId: 0,
              vocab: "vocab",
              type: VocabType.adj,
              mainTranslation: "mt",
              otherTranslation: [],
              mainSound: "sound",
              otherSound: [],
              englishTranslation: "none",
              comments: [],
              confusingWordId: [],
              memTips: "top",
              exampleSentences: ["eg"],
            ),
          );
        });
  }
}
