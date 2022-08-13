import 'package:async/async.dart';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/vocab_list_model.dart';
import '../../models/vocab_model.dart';
import '../../screens/vocab_dialog.dart';
import '../../view_models/vocab_list_view_model.dart';

/// SearchBarController
class SearchBarController {
  final BuildContext context;
  late _SearchBarListState _state;
  late GlobalKey indexedStackKey;

  CancelableOperation? _cancellableOperation;
  List<VocabModel>? _wordList;

  SearchBarController({required this.context});

  // WARNING: make sure _wordList not null before calling this function
  Future<List<VocabModel>> computeSearchResult(String searchWord) async {
    if (searchWord.isEmpty) return [];
    // WARNING: _cancellableOperation?.cancel() does not cancel this computation
    //          rather it stops _state.setState(() {});
    return _wordList!.where((w) => w.vocab.startsWith(searchWord)).toList();
  }

  Future<void> updateSearchBarList(String searchWord) async {
    _cancellableOperation?.cancel();
    _cancellableOperation = CancelableOperation.fromFuture(
        computeSearchResult(searchWord), onCancel: () {
      print('Search Operation Cancelled');
    });
    List<VocabModel> results = await _cancellableOperation!.value;

    _state._results = results;
    if (_state.widget.beforeUpdate != null)
      _state.widget.beforeUpdate!(_state._results);
    _state.setState(() {});
    if (_state.widget.onUpdate != null)
      _state.widget.onUpdate!(_state._results);
    return Future.value();
  }
}

/// SearchBarHead
class SearchBarHead extends StatefulWidget {
  SearchBarController controller;
  SearchBarHead({required this.controller});

  @override
  State<StatefulWidget> createState() {
    return SearchBarHeadState();
  }

  Future<void> loadVocabsFromDatabase(context) async {
    if (controller._wordList != null) return Future.value();
    VocabListViewModel vocabListViewModel =
        Provider.of<VocabListViewModel>(context, listen: false);
    VocabListModel vocabListModel =
        await vocabListViewModel.getFromDatabase(listId: 0);
    List<VocabModel> vocabModels = vocabListModel.vocabs!;
    controller._wordList = vocabModels;
    FLog.info(text: "[SearchBar] loadVocabsFromDatabase() called");
    if (vocabModels.length == 0)
      FLog.warning(
          text: "[SearchBar] You have not downloaded any vocabs."
              "Therefore you cannot search for them");
    return Future.value();
  }

  void unloadVocabsFromMemory(context) {
    FLog.info(text: "[SearchBar] unloadVocabsFromMemory() called");
    controller._wordList = null;
  }

  Future<void> suggest(BuildContext context, String s) async {
    await loadVocabsFromDatabase(context);
    await controller.updateSearchBarList(s);
    return Future.value();
  }
}

class SearchBarHeadState extends State<SearchBarHead> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, decorationThickness: 0),
        onTap: () async {
          await widget.loadVocabsFromDatabase(context);
        },
        onSubmitted: (s) async {
          widget.controller._cancellableOperation?.cancel();
          // don't cancel it, let it finish
          await widget.loadVocabsFromDatabase(context);
          List<VocabModel> vocabModels =
              await widget.controller.computeSearchResult(s);
          widget.controller._wordList = vocabModels;

          if (widget.controller._state.widget.beforeUpdate != null)
            widget.controller._state.widget
                .beforeUpdate!(widget.controller._state._results);
          widget.controller._state.setState(() {});
          if (widget.controller._state.widget.onUpdate != null)
            widget.controller._state.widget
                .onUpdate!(widget.controller._state._results);

          widget.unloadVocabsFromMemory(context);
        },
        onChanged: (s) async {
          await widget.suggest(context, s);
        },
        cursorColor: Colors.grey,
      ),
    );
  }
}

/// SearchBarList
class SearchBarList extends StatefulWidget {
  SearchBarController controller;
  void Function(List<VocabModel> vocabModels)? beforeUpdate;
  void Function(List<VocabModel> vocabModels)? onUpdate;

  SearchBarList({required this.controller, this.beforeUpdate, this.onUpdate});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarListState();
  }
}

class _SearchBarListState extends State<SearchBarList> {
  List<VocabModel> _results = [];

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller._state = this;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: _results.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => SearchBarListItem(
        word: _results[index].vocab,
        color: index % 2 == 0 ? Colors.grey[200] : Colors.grey[300],
        callbackPressed: () => VocabDialog.showVocabDialog(
            vocabId: _results[index].vocabId,
            vocab: _results[index].vocab,
            context: context),
      ),
    );
  }
}

class SearchBarListItem extends StatelessWidget {
  const SearchBarListItem(
      {Key? key,
      required this.word,
      required this.callbackPressed,
      required this.color})
      : super(key: key);

  final Color? color;
  final String word;
  final void Function() callbackPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: color, //index % 2 == 0? Colors.grey[200]:Colors.grey[300],
      child: TextButton(
        onPressed: callbackPressed,
        child: Row(children: <Widget>[
          Expanded(
              child: Text(
            " > $word",
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
            ),
          ))
        ]),
      ),
    );
  }
}
