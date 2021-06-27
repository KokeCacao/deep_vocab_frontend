import '../controllers/vocab_state_controller.dart';
import '../view_models/vocab_list_view_model.dart';
import '../widgets/learning_screen/learning_navbar.dart';
import '../widgets/learning_screen/vocab_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'package:provider/provider.dart';

class LearningScreen extends StatefulWidget {
  int _index = 2;

  @override
  State<StatefulWidget> createState() {
    return _LearningScreenState();
  }
}

class _LearningScreenState extends State<LearningScreen> with SingleTickerProviderStateMixin {
  Widget _buildList() {
    switch (widget._index) {
      case 0:
        return VocabList.task(context);
      case 1:
        return VocabList.memorized(context);
      case 2:
        return VocabList.list(context);
      default:
        throw Exception("There is no ${widget._index}-th tab in GNav");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            LearningNavbar(
              onTabChange: (index) {
                widget._index = index;
                Provider.of<VocabStateController>(context, listen: false).clear();
                setState(() {});
              },
              selectedIndex: widget._index,
              // TODO: more customize, see https://github.com/Fliggy-Mobile/fsearch/blob/master/README_CN.md
              // TODO: add controller
              // TODO: 提示显示记忆力最低的单词?
              // TODO: finish initializing a proper controller
              controller: FSearchController(),
            ),
            widget._index == 2
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Barron3500"),
                        RaisedButton(
                          onPressed: () async {
                            bool success = await Provider.of<VocabListViewModel>(context, listen: false).downloadVocab();
                            print("[LearningScreen] update vocab list ${success ? "Success!" : "Failed."}");
                          },
                          child: Text("Download"),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            _buildList(),
          ],
        ));
  }
}
