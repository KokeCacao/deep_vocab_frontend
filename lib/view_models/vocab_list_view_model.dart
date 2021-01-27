import 'package:deep_vocab/models/sqlite_models/app_database.dart';
import 'package:deep_vocab/models/sqlite_models/vocab_sqlite_dao.dart';
import 'package:deep_vocab/models/sub_models/mark_color_model.dart';
import 'package:deep_vocab/models/vocab_list_model.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:deep_vocab/utils/file_manager.dart';
import 'package:deep_vocab/utils/hive_box.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:deep_vocab/utils/util.dart';
import 'package:deep_vocab/view_models/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common/src/exception.dart' show SqfliteDatabaseException; // for SqfliteDatabaseException

class VocabListViewModel {
  /// storage
  final BuildContext context;
  final VocabSqliteDao _dao;
  final String _tempFileName = "VocabListViewModel.txt";

  /// store value

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  VocabListViewModel({@required this.context}) : _dao = VocabSqliteDao(Provider.of<AppDatabase>(context, listen: false));

  /// getters

  /// interface
  Future<void> downloadVocab({void Function(int count, int total) onReceiveProgress}) async {
    String path = await HttpWidget.downloadFile(from: _tempFileName, to: _tempFileName, onReceiveProgress: onReceiveProgress);
    print("[VocabListViewModel] downloaded to path ${path}");
    VocabListModel vocabListModel = VocabListModel.fromJson(await FileManager.filePathToJson(path));

    // store vocab list header to HiveBox
    HiveBox.put(HiveBox.VOCAB_LIST_HEADER_BOX, vocabListModel.header.listId, vocabListModel.header);
    print("[VocabListViewModel] store to HiveBox success");

    // store vocabs to Moor
    for (VocabModel vocab in vocabListModel.vocabs) {
      VocabSqliteTableDataWithUserVocabSqliteTableData vocabSqliteTableDataWithUserVocabSqliteTableData = vocab.toCombinedSqlite();
      VocabSqliteTableData vocabSqliteTableData = vocabSqliteTableDataWithUserVocabSqliteTableData.vocabSqliteTableData;
      UserVocabSqliteTableData userVocabSqliteTableData = vocabSqliteTableDataWithUserVocabSqliteTableData.userVocabSqliteTableData;

      // must insertUserVocab before insertVocab
      try {
        await _dao.insertUserVocab(userVocabSqliteTableData);
        await _dao.insertVocab(vocabSqliteTableData);
      } on SqfliteDatabaseException catch (e) {
        print("[VocabListViewModel] Warning: ${e.message}");
      }
    }
    print("[VocabListViewModel] store to Moor success");

    await FileManager.deteleFile(path);
    print("[VocabListViewModel] delete file success");
    return Future.value();
  }

  Future<VocabListModel> getFromDatabase({int listId, String vocabId, bool memorized}) async {
    Expression<bool> Function($VocabSqliteTableTable tbl) filter =
        (tbl) => (isNull(Variable<int>(listId)) | tbl.listId.equals(listId)) & (isNull(Variable<String>(vocabId)) | tbl.vocabId.equals(vocabId));
    List<VocabSqliteTableDataWithUserVocabSqliteTableData> list = await _dao.getVocabsWithUserWhere(filter: filter);

    return Future.value(VocabListModel(
        header: HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null), vocabs: list.map((e) => VocabModel.fromCombinedSqlite(e)).toList()));
  }

  /// This function access the database that select specific [listId] and [vocabId] and returns a stream
  /// If [listId] is not provided as an argument, the function selects all variants of [listId]
  /// If [vocabId] is not provided as an argument, the function selects all variants of [vocabId]
  Stream<VocabListModel> watchFromDatabase({int listId, String vocabId, bool memorized}) {
    // See: https://github.com/simolus3/moor/issues/1015
    Expression<bool> Function($VocabSqliteTableTable tbl) leftFilter =
        (tbl) => (isNull(Variable<int>(listId)) | tbl.listId.equals(listId)) & (isNull(Variable<String>(vocabId)) | tbl.vocabId.equals(vocabId));

    Stream<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> stream;
    if (memorized == null)
      stream = _dao.watchVocabsWithUserWhere(filter: leftFilter);
    else {
      Expression<bool> Function($UserVocabSqliteTableTable tbl) rightFilter =
          // (tbl) => tbl.markColors.dartCast<List<MarkColorModel>>().equals(<MarkColorModel>[]).not();
          (tbl) => memorized ? isNotNull(tbl.markColors) : isNull(tbl.markColors);
      stream = _dao.watchMarkedVocabsWithUserWhere(leftFilter: leftFilter, rightFilter: rightFilter);
    }

    return stream.map((stream) => VocabListModel(
        header: HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null), vocabs: stream.map((e) => VocabModel.fromCombinedSqlite(e)).toList()));
  }

  Future<NetworkException> addMarkColor({@required String vocabId, List<MarkColorModel> originals, ColorModel color, bool replaceLast = false}) async {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    Map<String, dynamic> map = await HttpWidget.graphQLMutation(
      context: context,
      data: """
      mutation {
          markColor(uuid: "${authViewModel.uuid}", accessToken: "${authViewModel.accessToken}", vocabId: "${vocabId}", index: ${replaceLast ? originals.length - 1 : originals.length}, color: ${Util.enumToString(color)}, time: "${DateTime.now().toIso8601String()}") {
              index
              color
              time
          }
      }
      """,
      queryName: "markColor",
      onSuccess: (Map<String, dynamic> response) => response,
      onFail: (String exception) => <String, dynamic>{"errorMessage": exception},
    );
    if (map == null) return Future.value(NetworkException(message: "duplicated request"));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"]));
    if (replaceLast) originals = originals..removeLast();
    await updateUserVocab(vocabId: vocabId, markColors: originals..add(MarkColorModel(color: color, time: DateTime.now())));
    return Future.value();
  }

  Future<NetworkException> editUserVocab(
      {@required String vocabId, String editedMeaning, bool bookMarked, bool questionMark, bool starMark, bool pinMark, bool addedMark}) async {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    String query = "";
    if (editedMeaning != null) query += ", editedMeaning: ${editedMeaning}";
    if (bookMarked != null) query += ", bookMarked: ${bookMarked}";
    if (questionMark != null) query += ", questionMark: ${questionMark}";
    if (starMark != null) query += ", starMark: ${starMark}";
    if (pinMark != null) query += ", pinMark: ${pinMark}";
    if (addedMark != null) query += ", addedMark: ${addedMark}";

    String result = "";
    if (editedMeaning != null) result += " editedMeaning";
    if (bookMarked != null) result += " bookMarked";
    if (questionMark != null) result += " questionMark";
    if (starMark != null) result += " starMark";
    if (pinMark != null) result += " pinMark";
    if (addedMark != null) result += " addedMark";

    Map<String, dynamic> map = await HttpWidget.graphQLMutation(
      context: context,
      data: """
      mutation {
          userVocab(uuid: "${authViewModel.uuid}", accessToken: "${authViewModel.accessToken}", vocabId: "${vocabId}"${query}) {
              vocabId
              nthWord
              nthAppear
              ${result}
          }
      }
      """,
      queryName: "userVocab",
      onSuccess: (Map<String, dynamic> response) => response,
      onFail: (String exception) => <String, dynamic>{"errorMessage": exception},
    );
    if (map == null) return Future.value(NetworkException(message: "duplicated request"));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"]));
    if (map.containsKey("editedMeaning")) editedMeaning = map["editedMeaning"];
    if (map.containsKey("bookMarked")) bookMarked = map["bookMarked"];
    if (map.containsKey("questionMark")) questionMark = map["questionMark"];
    if (map.containsKey("starMark")) starMark = map["starMark"];
    if (map.containsKey("pinMark")) pinMark = map["pinMark"];
    if (map.containsKey("addedMark")) addedMark = map["addedMark"];
    await updateUserVocab(
        vocabId: vocabId,
        nthWord: map["nthWord"],
        nthAppear: map["nthAppear"],
        editedMeaning: editedMeaning,
        bookMarked: bookMarked,
        questionMark: questionMark,
        starMark: starMark,
        pinMark: pinMark,
        addedMark: addedMark);
    return Future.value();
  }

  Future<dynamic> updateUserVocab({
    @required String vocabId,
    int nthWord,
    int nthAppear,
    List<MarkColorModel> markColors,
    String editedMeaning,
    bool bookMarked,
    bool questionMark,
    bool starMark,
    bool pinMark,
    bool addedMark,
  }) {
    return _dao.updateUserVocab(UserVocabSqliteTableCompanion(
      vocabId: ValueOrAbsent(vocabId)(),
      nthWord: ValueOrAbsent(nthWord)(),
      nthAppear: ValueOrAbsent(nthAppear)(),
      markColors: ValueOrAbsent(markColors)(),
      editedMeaning: ValueOrAbsent(editedMeaning)(),
      bookMarked: ValueOrAbsent(bookMarked)(),
      questionMark: ValueOrAbsent(questionMark)(),
      starMark: ValueOrAbsent(starMark)(),
      pinMark: ValueOrAbsent(pinMark)(),
      addedMark: ValueOrAbsent(addedMark)(),
    ));
  }
}
