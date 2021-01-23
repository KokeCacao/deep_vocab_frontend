import 'package:deep_vocab/widgets/learning_screen/vocab_row.dart';
import 'package:flutter/cupertino.dart';

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
  final index;

  const DismissibleVocabRow({Key key, @required this.index}) : super(key: key);

  Widget _itemBuilder(Widget child, MultiDismissibleStatus status) {
    if (status == MultiDismissibleStatus.ON_IDLE) return child;
    VocabRow vocabRow = child;
    return vocabRow.copyWith(
      cross: !vocabRow.cross,
      hide: vocabRow.hide,
      checkBox: vocabRow.checkBox,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiDismissible(
      child: VocabRow(
        vocab: "grandiloquent",
        translation: "辞藻浮夸的; 夸大",
      ), // TODO
      builder: _itemBuilder,
    );
  }
}
