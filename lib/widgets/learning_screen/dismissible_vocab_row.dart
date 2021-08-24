import 'package:f_logs/f_logs.dart';

import '/controllers/vocab_state_controller.dart';
import '/models/sub_models/mark_color_model.dart';
import '/models/vocab_model.dart';
import '/view_models/vocab_list_view_model.dart';
import './vocab_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:graphql/client.dart';

import 'multi_dismissible.dart';

class DismissibleVocabRow extends StatelessWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return DismissibleVocabRowState();
//   }
//
// }
//
// class DismissibleVocabRowState extends State<DismissibleVocabRow> {
  final VocabModel vocab;

  const DismissibleVocabRow({Key? key, required this.vocab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VocabStateController vocabStateController =
        Provider.of<VocabStateController>(context, listen: true);
    return MultiDismissible(
      child: VocabRow(
        vocabId: vocab.vocabId,
        vocab: vocab.vocab,
        translation: vocab.mainTranslation,
        bookMarked: vocab.bookMarked,
        cross: vocabStateController.crossedVocabIdContains(vocab.vocabId),
        hide: !vocabStateController.unhideVocabIdContains(vocab.vocabId),
        checkBox: vocabStateController.selectedVocabIdContains(
            vocab.vocabId), // listen to selectAll, inverseSelect
        triangle: vocab.addedMark,
      ),
      builder: (Widget child, MultiDismissibleStatus status) {
        if (status == MultiDismissibleStatus.ON_IDLE) return child;
        VocabRow vocabRow = child as VocabRow;
        bool replaceLast = vocabRow.cross;
        List<MarkColorModel?> markColors = vocab.markColors ?? [];

        ColorModel? color;
        switch (status) {
          case MultiDismissibleStatus.ON_IDLE:
            return child;
          case MultiDismissibleStatus.ON_LEFT_EDGE:
            color = ColorModel.black;
            break;
          case MultiDismissibleStatus.ON_MIDDLE_LEFT:
            color = ColorModel.red;
            break;
          case MultiDismissibleStatus.ON_MIDDLE_RIGHT:
            color = ColorModel.yellow;
            break;
          case MultiDismissibleStatus.ON_RIGHT_EDGE:
            color = ColorModel.green;
            break;
        }

        // automatically add to remember plan if not added
        if (!vocab.addedMark)
          Provider.of<VocabListViewModel>(context, listen: false)
              .editUserVocab(vocabId: vocab.vocabId, addedMark: true)
              .then((NetworkException? exception) {
            if (exception == null)
              // add markColor
              Provider.of<VocabListViewModel>(context, listen: false)
                  .addMarkColor(
                      vocabId: vocab.vocabId,
                      originals: markColors,
                      color: color,
                      replaceLast: replaceLast)
                  .then((NetworkException? exception) {
                if (exception == null) {
                  Provider.of<VocabStateController>(context, listen: false)
                      .crossedVocabIdAdd(vocab.vocabId);
                } else {
                  FLog.warning(text: "[DismissibleVocabRow] ${exception.message}");
                  Provider.of<VocabStateController>(context, listen: false)
                      .crossedVocabIdRemove(vocab.vocabId);
                }
              });
          });
        else {
          // add markColor
          Provider.of<VocabListViewModel>(context, listen: false)
              .addMarkColor(
                  vocabId: vocab.vocabId,
                  originals: markColors,
                  color: color,
                  replaceLast: replaceLast)
              .then((NetworkException? exception) {
            if (exception == null) {
              Provider.of<VocabStateController>(context, listen: false)
                  .crossedVocabIdAdd(vocab.vocabId);
            } else {
              FLog.warning(text: "[DismissibleVocabRow] ${exception.message}");
              Provider.of<VocabStateController>(context, listen: false)
                  .crossedVocabIdRemove(vocab.vocabId);
            }
          });
        }

        return vocabRow.copyWith(
            // cross: !vocabRow.cross,
            // hide: vocabRow.hide,
            // checkBox: !vocabRow.checkBox,
            );
      },
    );
  }
}
