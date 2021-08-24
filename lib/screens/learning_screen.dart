import 'package:f_logs/f_logs.dart';

import '../controllers/vocab_state_controller.dart';
import '../view_models/vocab_list_view_model.dart';
import '../view_models/http_sync_view_model.dart';
import '../widgets/learning_screen/learning_navbar.dart';
import '../widgets/learning_screen/vocab_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LearningScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LearningScreenState();
  }
}

class _LearningScreenState extends State<LearningScreen>
    with SingleTickerProviderStateMixin {

  int _index = 0;

  Widget _buildList() {
    switch (_index) {
      case 0:
        return VocabList.task(context);
      case 1:
        return VocabList.memorized(context);
      case 2:
        return VocabList.list(context);
      default:
        throw Exception("There is no $_index-th tab in GNav");
    }
  }

  @override
  void initState() {
    super.initState();

    // force user to enter task list if there is task
    int badgeNumber = Provider.of<HttpSyncViewModel>(context, listen: false)
        .navigationLearningBadgeCount;
    if (badgeNumber > 0) _index = 0;
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
                _index = index;
                Provider.of<VocabStateController>(context, listen: false)
                    .clear();
                setState(() {});
              },
              selectedIndex: _index,
              // TODO: more customize, see https://github.com/Fliggy-Mobile/fsearch/blob/master/README_CN.md
              // TODO: add controller
              // TODO: 提示显示记忆力最低的单词?
              // TODO: finish initializing a proper controller
              // controller: FSearchController(),
            ),
            _index == 2
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Barron3500"),
                        ElevatedButton(
                          onPressed: () async {
                            bool success =
                                await Provider.of<VocabListViewModel>(context,
                                        listen: false)
                                    .downloadVocab();
                            if (success) FLog.info(text: "[LearningScreen] update vocab list Success!");
                            else FLog.warning(text: "[LearningScreen] update vocab list Failed!");
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
