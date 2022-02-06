import '../../utils/theme_data_wrapper.dart';

import '/controllers/vocab_state_controller.dart';
import '/models/vocab_list_model.dart';
import '/view_models/vocab_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionPanel extends StatelessWidget {
  final int itemCount;

  const SelectionPanel({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VocabStateController vocabStateController =
        Provider.of<VocabStateController>(context, listen: true);
    int selectedCount =
        vocabStateController.getSelectedVocabIdLength(itemCount);
    if (selectedCount == 0) return SizedBox.shrink();
    return Container(
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomRight,
      height: 40,
      decoration: BoxDecoration(
          color: Provider.of<ThemeDataWrapper>(context, listen: false).tabtab,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Align(
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                "$selectedCount|$itemCount",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: Provider.of<ThemeDataWrapper>(context, listen: false).tab,
              height: double.infinity,
              child: GestureDetector(
                onTap: () => selectedCount == itemCount
                    ? vocabStateController.inverseSelect()
                    : vocabStateController.allSelect(),
                child: selectedCount == itemCount
                    ? Text(
                        "反选",
                        textAlign: TextAlign.center,
                      )
                    : Text("全选", textAlign: TextAlign.center,),
              ),
            )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: Provider.of<ThemeDataWrapper>(context, listen: false).background,
              height: double.infinity,
              child: GestureDetector(
                onTap: () async {
                  VocabListModel vocabListModel =
                      await Provider.of<VocabListViewModel>(context,
                              listen: false)
                          .getFromDatabase(listId: 0);
                  Set<String?> selectedIds = vocabStateController
                      .getSelectedVocabId(vocabListModel.vocabs!
                          .map((e) => e.vocabId)
                          .cast<String>()
                          .toSet());
                  // TODO: combine them into a single query, you can do that with graphql
                  for (String? selectedId in selectedIds)
                    await Provider.of<VocabListViewModel>(context,
                            listen: false)
                        .editUserVocab(vocabId: selectedId, addedMark: true);
                  vocabStateController.noneSelect();
                },
                child: Text(
                  "加入计划",
                  textAlign: TextAlign.center,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
