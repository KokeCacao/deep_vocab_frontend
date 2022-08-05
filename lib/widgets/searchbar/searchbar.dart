///
/// The main components of Deep Vocab search bar.
///
/// Note that such a search bar shall be deployed in pairs of SearchBarHead
/// and SearchBarList. This can be achieved via instantiating some object of
/// class SearchBarPair, and then calling functions getHead() & getList().
/// 

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toy/searchbar/searchbar_list_item.dart';
import 'package:toy/searchbar/searchbar_decorations.dart';

class SearchBarList extends StatefulWidget {
  const SearchBarList({required Key? key,
    required this.searchWord}) : super(key: key);

  final void Function(String? s) searchWord;

  @override
  State<StatefulWidget> createState() => _SearchBarListState();

}

class _SearchBarListState extends State<SearchBarList> {
  List<String> _foundWords = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount:_foundWords.length,
          itemBuilder: (BuildContext context, int index) =>
            SearchBarListItem(
                word: _foundWords[index],
                color: index % 2 == 0? Colors.grey[200]:Colors.grey[300],
                callbackPressed: () => widget.searchWord(_foundWords[index])
            )
        )
    );
  }

  changeState(List<String> wordsToDisplay) {
    setState((){_foundWords = wordsToDisplay;});
  }
}

class SearchBarHead extends StatelessWidget {
  SearchBarHead({Key? key, required this.listkey, }) : super(key: key);

  List<String> wordList = [];
  final GlobalKey<_SearchBarListState> listkey;

  Future<List<String>> loadAsset() async {
    final wordString =  await rootBundle.loadString('logistics/wordlist.csv');
    return wordString.split(",");
  }

  void updateWordList() {
    if (wordList.isEmpty) {
      loadAsset().then((value) {
        wordList = value;
      });
    }
  }

  void suggest(String? s) {
    List<String> searchList = (s != null && s.isNotEmpty)?
    wordList.where((w) => w.startsWith(s)).toList() : [];
    listkey.currentState!.changeState(searchList);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.blue[100],
      child: Padding(
          padding: const EdgeInsets.all(8),

          child:Row(
              children: <Widget>[

                Expanded(
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 24,
                        decorationThickness: 0
                    ),
                    decoration: SearchBarDecorations.SearchBarHeadDecoration,
                    onTap: updateWordList,
                    onChanged: suggest,
                    cursorColor: Colors.grey,
                  ),
                )
              ]
          )
      ),
    );
  }
}

class SearchBarPair {
  SearchBarPair({required this.onClickSearchWord}) {
    _head = SearchBarHead(listkey: _k);
    _list = SearchBarList(key: _k, searchWord: onClickSearchWord);
  }

  final GlobalKey<_SearchBarListState> _k = GlobalKey();
  final void Function(String?) onClickSearchWord;
  SearchBarHead? _head;
  SearchBarList? _list;

  getHead() => _head;
  getList() => _list;
}
