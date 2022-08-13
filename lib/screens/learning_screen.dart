import 'package:showcaseview/showcaseview.dart';

import '../models/vocab_model.dart';
import '../utils/showcase_manager.dart';
import '../view_models/vocab_list_view_model.dart';
import '../widgets/learning_screen/progress_indicator.dart';
import '../widgets/learning_screen/search_bar.dart';
import '../widgets/login_prompt_widget.dart';
import '../controllers/vocab_state_controller.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/http_sync_view_model.dart';
import '../widgets/learning_screen/learning_navbar.dart';
import '../widgets/learning_screen/vocab_list_with_header.dart';
import '../widgets/showcase_wrapper.dart';

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
  late List<Widget> vocabListStack;
  late SearchBarController searchBarController;

  @override
  void initState() {
    super.initState();

    searchBarController = Provider.of<SearchBarController>(context, listen: false);

    vocabListStack = [
      VocabListWithHeader.task(
        context,
        emptyWidget: Center(
          child: Text("Nothing is here (("),
        ),
      ),
      VocabListWithHeader.memorized(
        context,
        emptyWidget: Center(
          child: Text("Nothing is here (("),
        ),
      ),
      VocabListWithHeader.vocabList(
        context,
        emptyWidget: Center(
          child: CircularProgressBar(
            progressTask:
                Provider.of<VocabListViewModel>(context, listen: false)
                    .downloadVocab,
          ),
        ),
      ),
      SearchBarList(
        controller: searchBarController,
        onUpdate: (List<VocabModel> vocabModels) {
          _index = vocabModels.isEmpty ? 2 : 3;
          print("updated index to $_index");
          setState(() {});
        },
      )
    ];

    // force user to enter task list if there is task
    int badgeNumber = Provider.of<HttpSyncViewModel>(context, listen: false)
        .navigationLearningBadgeCount;
    if (badgeNumber > 0) _index = 0;

    // load showcase
    // TODO: safter switching to indexed stack, showcase not shown
    print("showcase scheduled");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      print("showcase started");
      ShowCaseWidget.of(context).startShowCase([
        ShowcaseManager.searchBarShowcaseKey,
        ShowcaseManager.vocabBarShowcaseKey,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    LearningNavbar learningNav = LearningNavbar(
      searchBar: ShowcaseWrapper(
        showcaseKey: ShowcaseManager.searchBarShowcaseKey,
        description: "Search vocab here",
        child: SearchBarHead(controller: searchBarController),
      ),
      onTabChange: (index) {
        _index = index.clamp(0, 2); // WARNING: [0, 1, 2] is valid screen
        Provider.of<VocabStateController>(context, listen: false).clear();
        setState(() {});
      },
      selectedIndex: _index.clamp(0, 2), // WARNING: [0, 1, 2] is valid screen
      // TODO: more customize, see https://github.com/Fliggy-Mobile/fsearch/blob/master/README_CN.md
      // TODO: add controller
      // TODO: 提示显示记忆力最低的单词?
      // TODO: finish initializing a proper controller
      // controller: FSearchController(),
    );

    if (Provider.of<AuthViewModel>(context, listen: false).isNotLoggedIn)
      return Column(
        children: [
          learningNav,
          Flexible(
            child: LoginPrompt(),
          )
        ],
      );

    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          learningNav,
          Expanded(
            child: IndexedStack(
              index: _index,
              children: vocabListStack,
            ),
          )
        ],
      ),
    );
  }
}
