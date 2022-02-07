import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/models/vocab_list_model.dart';
import '/view_models/auth_view_model.dart';
import '/view_models/vocab_list_view_model.dart';
import '/models/vocab_model.dart';
import './dismissible_vocab_row.dart';
import './learning_selection_bar.dart';
import './vocab_list.dart';

class VocabListWithHeader extends StatefulWidget {
  bool random;

  final bool? refreshable;
  final void Function(RefreshController controller)? onRefresh;
  final void Function(RefreshController controller)? onTwoLevel;
  final List<VocabModel>? list;
  final Widget? emptyWidget;

  VocabListWithHeader(
      {Key? key,
      this.random = false,
      this.refreshable,
      this.onRefresh,
      this.onTwoLevel,
      this.list,
      this.emptyWidget})
      : super(key: key);

  static Widget task(BuildContext context,
      {bool random = false, Widget? emptyWidget}) {
    void _onRefresh(RefreshController controller) async {
      NetworkException? exception =
          await Provider.of<VocabListViewModel>(context, listen: false)
              .refreshVocab(context);
      if (exception == null)
        controller.refreshCompleted();
      else
        controller.refreshFailed();
    }

    // TODO: buggy onTwoLevel
    return StreamBuilder(
      stream: Provider.of<VocabListViewModel>(context, listen: false)
          .watchFromDatabase(pushedMark: true),
      builder: (BuildContext context, AsyncSnapshot<VocabListModel> snapshot) {
        if (snapshot.data == null)
          return emptyWidget == null ? SizedBox.shrink() : emptyWidget;
        VocabListModel data = snapshot.data!;
        return VocabListWithHeader(
          list: data.vocabs,
          refreshable: true,
          onRefresh: _onRefresh,
          onTwoLevel: _onRefresh,
          emptyWidget: emptyWidget,
        );
      },
    );
  }

  static Widget memorized(BuildContext context,
      {bool random = false, Widget? emptyWidget}) {
    return StreamBuilder(
      stream: Provider.of<VocabListViewModel>(context, listen: false)
          .watchFromDatabase(addedMark: true),
      builder: (BuildContext context, AsyncSnapshot<VocabListModel> snapshot) {
        if (snapshot.data == null)
          return emptyWidget == null ? SizedBox.shrink() : emptyWidget;
        VocabListModel data = snapshot.data!;
        return VocabListWithHeader(
          list: data.vocabs,
          refreshable: false,
          onRefresh: null,
          onTwoLevel: null,
          emptyWidget: emptyWidget,
        );
      },
    );
  }

  static Widget vocabList(BuildContext context,
      {bool random = false, Widget? emptyWidget}) {
    return StreamBuilder(
      stream: Provider.of<VocabListViewModel>(context, listen: false)
          .watchFromDatabase(listId: 0),
      builder: (BuildContext context, AsyncSnapshot<VocabListModel> snapshot) {
        if (snapshot.data == null)
          return emptyWidget == null ? SizedBox.shrink() : emptyWidget;
        VocabListModel data = snapshot.data!;
        return VocabListWithHeader(
          list: data.vocabs,
          refreshable: false,
          onRefresh: null,
          onTwoLevel: null,
          emptyWidget: emptyWidget,
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    return VocabListWithHeaderState();
  }
}

class VocabListWithHeaderState extends State<VocabListWithHeader> {
  @override
  Widget build(BuildContext context) {
    List<VocabModel> randomList = widget.list!.sublist(0); // shallow copy
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
            emptyWidget: widget.emptyWidget,
          )
        ],
      ),
    );
  }
}
