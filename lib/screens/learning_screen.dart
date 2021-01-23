import 'package:deep_vocab/models/sub_models/comment_model.dart';
import 'package:deep_vocab/models/sub_models/mark_color_model.dart';
import 'package:deep_vocab/models/sqlite_models/app_database.dart';
import 'package:deep_vocab/models/sqlite_models/global_value_serializer.dart';
import 'package:deep_vocab/models/vocab_list_model.dart';
import 'package:deep_vocab/utils/file_manager.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:deep_vocab/widgets/learning_screen/learning_navbar.dart';
import 'package:deep_vocab/widgets/learning_screen/learning_selection_bar.dart';
import 'package:deep_vocab/widgets/learning_screen/vocab_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';

class LearningScreen extends StatefulWidget {
  bool random = false;
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
        return VocabList.task();
      case 1:
        return VocabList.memorized();
      case 2:
        return VocabList.list();
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
                setState(() {});
              },
              selectedIndex: widget._index,
              // TODO: more customize, see https://github.com/Fliggy-Mobile/fsearch/blob/master/README_CN.md
              // TODO: add controller
              // TODO: 提示显示记忆力最低的单词?
              // TODO: finish initializing a proper controller
              controller: FSearchController(),
            ),
            LearningSelectionBar(
              random: widget.random,
              onChanged: (bool value) {
                widget.random = !widget.random;
                setState(() {});
              },
            ),
            widget._index == 2
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Barron3500"),
                        RaisedButton(
                          onPressed: () async {
                            String path = await HttpWidget.downloadFile(from: "test.txt", to: "test.txt", onReceiveProgress: null);
                            Map<String, dynamic> map = await FileManager.filePathToJson(path);

                            VocabSqliteTableData data = VocabSqliteTableData(
                                id: "id",
                                edition: 0,
                                listId: 0,
                                vocab: "Vocab",
                                type: VocabType.adj,
                                mainTranslation: "mainTrans",
                                otherTranslation: ["other", "trans"],
                                mainSound: "sound",
                                otherSound: [],
                                englishTranslation: "engtrans",
                                comments: [
                                  CommentModel(
                                      userName: "user", uuid: "uuid", dateTime: DateTime.now(), message: "message", avatarUrl: "avatar", likes: 233, isLike: false)
                                ],
                                confusingWordId: ["confuse"],
                                memTips: "tip",
                                exampleSentences: [],
                                userVocabSqliteTableId: "id");

                            print(data.toJsonString(serializer: GlobalValueSerializer()));

                            UserVocabSqliteTableData user = UserVocabSqliteTableData(
                              id: "id",
                              nthWord: 1,
                              nthAppear: 0,
                              markColors: [MarkColorModel(color: ColorModel.black, time: DateTime.now())],
                              editedMeaning: "",
                              bookMarked: false,
                              questionMark: false,
                              starMark: false,
                              expoMark: false,
                            );
                            print(user.toJsonString(serializer: GlobalValueSerializer()));

                            VocabModel model = VocabModel.fromSqlite(data, user);
                            print(model.toJsonString());

                            VocabListModel list = VocabListModel(name: "listname", id: 0, edition: DateTime.now(), vocabs: [model]);
                            print(list.toJsonString());
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
