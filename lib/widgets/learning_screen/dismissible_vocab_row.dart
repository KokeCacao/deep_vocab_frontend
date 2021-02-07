import 'package:deep_vocab/controllers/vocab_state_controller.dart';
import 'package:deep_vocab/models/sub_models/mark_color_model.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:deep_vocab/utils/hive_box.dart';
import 'package:deep_vocab/view_models/vocab_list_view_model.dart';
import 'package:deep_vocab/widgets/learning_screen/vocab_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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

  const DismissibleVocabRow({Key key, @required this.vocab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiDismissible(
      child: VocabRow(
        vocabId: vocab.vocabId,
        vocab: vocab.vocab,
        translation: vocab.mainTranslation,
        bookMarked: vocab.bookMarked,
        cross: Provider.of<VocabStateController>(context, listen: false).crossedVocabIdContains(vocab.vocabId),
        hide: !Provider.of<VocabStateController>(context, listen: false).unhideVocabIdContains(vocab.vocabId),
        checkBox: Provider.of<VocabStateController>(context, listen: true).selectedVocabIdContains(vocab.vocabId), // listen to selectAll, inverseSelect
      ),
      builder: (Widget child, MultiDismissibleStatus status) {
        if (status == MultiDismissibleStatus.ON_IDLE) return child;
        VocabRow vocabRow = child;
        bool replaceLast = vocabRow.cross;
        List<MarkColorModel> markColors = vocab.markColors ?? [];

        ColorModel color;
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
        Provider.of<VocabListViewModel>(context, listen: false)
            .addMarkColor(vocabId: vocab.vocabId, originals: markColors, color: color, replaceLast: replaceLast)
            .then((exception) {
          if (exception == null) {
            Provider.of<VocabStateController>(context, listen: false).crossedVocabIdAdd(vocab.vocabId);
          } else {
            print("[DismissibleVocabRow] ${exception.message}");
            Provider.of<VocabStateController>(context, listen: false).crossedVocabIdRemove(vocab.vocabId);
          }
        });
        return vocabRow.copyWith(
          cross: !vocabRow.cross,
          // hide: vocabRow.hide,
          // checkBox: !vocabRow.checkBox,
        );
      },
    );
  }
}
