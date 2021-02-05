import 'package:deep_vocab/models/vocab_model.dart';
import 'package:deep_vocab/widgets/learning_screen/dismissible_vocab_row.dart';
import 'package:deep_vocab/widgets/learning_screen/learning_selection_bar.dart';
import 'package:deep_vocab/widgets/learning_screen/vocab_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VocabListWithHeader extends StatefulWidget {
  bool random;

  final bool refreshable;
  final void Function(RefreshController controller) onRefresh;
  final void Function(RefreshController controller) onTwoLevel;
  final List<VocabModel> list;

  VocabListWithHeader({Key key, this.random = false, this.refreshable, this.onRefresh, this.onTwoLevel, this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VocabListWithHeaderState();
  }
}

class VocabListWithHeaderState extends State<VocabListWithHeader> {
  @override
  Widget build(BuildContext context) {

    List<VocabModel> randomList = widget.list.sublist(0); // shallow copy
    if (widget.random) randomList.shuffle();

    return Expanded(
      child: Column(
        children: [
          LearningSelectionBar(
            random: widget.random,
            onChanged: (bool value) {
              widget.random = !widget.random;
              setState(() {});
            },
          ),
          VocabList(
            refreshable: true,
            itemCount: randomList.length,
            onRefresh: widget.onRefresh,
            onTwoLevel: widget.onTwoLevel,
            itemBuilder: (context, i) => DismissibleVocabRow(
              vocab: randomList[i],
            ),
          )
        ],
      ),
    );
  }
}
