import '../controllers/vocab_state_controller.dart';
import '../models/hive_models/vocab_header_model.dart';
import '../models/sqlite_models/app_database.dart';
import '../models/sqlite_models/vocab_sqlite_dao.dart';
import '../models/sub_models/mark_color_model.dart';
import '../models/vocab_list_model.dart';
import '../models/vocab_model.dart';
import '../utils/file_manager.dart';
import '../utils/hive_box.dart';
import '../utils/http_widget.dart';
import '../utils/util.dart';
import './auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common/src/exception.dart' show SqfliteDatabaseException; // for SqfliteDatabaseException

class VocabListViewModel {
  /// storage
  final BuildContext context;
  final VocabSqliteDao _dao;
  final String _tempFileName = "VocabListViewModel.txt";

  /// store value

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  VocabListViewModel({required this.context}) : _dao = VocabSqliteDao(Provider.of<AppDatabase>(context, listen: false));

  /// getters

  /// interface

  /// Download and store vocabs
  /// 1. Download [user_vocab_db] and [vocab_db] from server (comes in 1 file)
  /// 2. Transform json to [VocabListModel]
  /// 3. Store [vocabListModel.header] into Hive's [VOCAB_LIST_HEADER_BOX]
  /// 4. For each [VocabModel] in [VocabListModel], convert to [VocabSqliteTableDataWithUserVocabSqliteTableData]
  /// which contain [UserVocabSqliteTableData] and [VocabSqliteTableData]
  /// 5. Save them to [UserVocabSqliteTable] and [VocabSqliteTable]
  Future<bool> downloadVocab({void Function(int count, int total)? onReceiveProgress}) async {
    String? path =
        await HttpWidget.secureDownloadFile(context: context, listId: 0, from: _tempFileName, to: _tempFileName, onReceiveProgress: onReceiveProgress);
    // String path = await HttpWidget.downloadFile(from: _tempFileName, to: _tempFileName, onReceiveProgress: onReceiveProgress);
    if (path == null) {
      print("[VocabListViewModel] error downloading file, user not logged in?"); // TODO: direct user to log in first
      return Future.value(false);
    }
    print("[VocabListViewModel] downloaded to path ${path}");
    VocabListModel vocabListModel = VocabListModel.fromJson(await FileManager.filePathToJson(path));

    // store vocab list header to HiveBox
    HiveBox.put(HiveBox.VOCAB_LIST_HEADER_BOX, vocabListModel.header!.listId, vocabListModel.header);
    print("[VocabListViewModel] store to HiveBox success");

    // store vocabs to Moor
    var list = vocabListModel.vocabs!.map((e) => e.toCombinedSqlite());
    try {
      await _dao.upsertAllUserVocab(list.map((e) => e.userVocabSqliteTableData).toList());
      await _dao.upsertAllVocab(list.map((e) => e.vocabSqliteTableData).toList());
    } on SqfliteDatabaseException catch (e) {
      print("[VocabListViewModel] Warning: ${e.message}");
    }
    print("[VocabListViewModel] store to Moor success");

    await FileManager.deteleFile(path);
    print("[VocabListViewModel] delete file success");
    return Future.value(true);
  }

  /// Get [VocabModel] by [vocabId] from combined [VocabSqliteTable] and [UserVocabSqliteTable]
  Future<VocabModel> getFromDatabaseById({required String vocabId}) async {
    return Future.value(VocabModel.fromCombinedSqlite(await _dao.getMarkedVocabsWithUserById(vocabId: vocabId)));
  }

  /// Get [VocabListModel] = ([VocabModel]s and [VocabHeaderModel]) by predicates (if not null)
  /// from Hive's [VOCAB_LIST_HEADER_BOX]
  /// and from combined [VocabSqliteTable] and [UserVocabSqliteTable]
  Future<VocabListModel> getFromDatabase({int? listId, String? vocabId, bool? memorized, bool? pushedMark}) async {
    if (vocabId != null)
      return Future.value(VocabListModel(
          header: HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null),
          vocabs: [VocabModel.fromCombinedSqlite(await _dao.getMarkedVocabsWithUserById(vocabId: vocabId))]));

    VocabHeaderModel? vocabHeaderModel = HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null);

    Expression<bool?> Function($VocabSqliteTableTable tbl) leftFilter = (tbl) =>
        (listId == null || vocabHeaderModel == null ? Variable<bool>(true) : tbl.vocabId.isIn(vocabHeaderModel.vocabIds!)) &
        (vocabId == null ? Variable<bool>(true) : tbl.vocabId.equals(vocabId));

    List<VocabSqliteTableDataWithUserVocabSqliteTableData> list;
    if (memorized == null && pushedMark == null)
      list = await _dao.getVocabsWithUserWhere(filter: leftFilter);
    else {
      Expression<bool?> Function($UserVocabSqliteTableTable tbl) rightFilter = (tbl) =>
          (memorized == null ? Variable<bool>(true) : (memorized ? isNotNull(tbl.markColors) : isNull(tbl.markColors))) &
          (pushedMark == null ? Variable<bool>(true) : tbl.pushedMark.equals(pushedMark));
      list = await _dao.getMarkedVocabsWithUserWhere(leftFilter: leftFilter, rightFilter: rightFilter);
    }

    return Future.value(VocabListModel(
        header: HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null), vocabs: list.map((e) => VocabModel.fromCombinedSqlite(e)).toList()));
  }

  Stream<VocabModel> watchFromDatabaseById({required String vocabId}) {
    return _dao.watchMarkedVocabsWithUserById(vocabId: vocabId).map((stream) => VocabModel.fromCombinedSqlite(stream));
  }

  /// Get [VocabListModel] = ([VocabModel]s and [VocabHeaderModel]) by predicates (if not null)
  /// from Hive's [VOCAB_LIST_HEADER_BOX]
  /// and from combined [VocabSqliteTable] and [UserVocabSqliteTable]
  Stream<VocabListModel> watchFromDatabase({int? listId, String? vocabId, bool? memorized, bool? pushedMark}) {
    if (vocabId != null)
      return _dao.watchMarkedVocabsWithUserById(vocabId: vocabId).map((stream) =>
          VocabListModel(header: HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null), vocabs: [VocabModel.fromCombinedSqlite(stream)]));

    VocabHeaderModel? vocabHeaderModel = HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null);

    // See: https://github.com/simolus3/moor/issues/1015
    Expression<bool?> Function($VocabSqliteTableTable tbl) leftFilter = (tbl) =>
        (listId == null || vocabHeaderModel == null ? Variable<bool>(true) : tbl.vocabId.isIn(vocabHeaderModel.vocabIds!)) &
        (vocabId == null ? Variable<bool>(true) : tbl.vocabId.equals(vocabId));

    Stream<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> stream;
    if (memorized == null && pushedMark == null)
      stream = _dao.watchVocabsWithUserWhere(filter: leftFilter);
    else {
      Expression<bool?> Function($UserVocabSqliteTableTable tbl) rightFilter = (tbl) =>
          (memorized == null ? Variable<bool>(true) : (memorized ? isNotNull(tbl.markColors) : isNull(tbl.markColors))) &
          (pushedMark == null ? Variable<bool>(true) : tbl.pushedMark.equals(pushedMark));
      stream = _dao.watchMarkedVocabsWithUserWhere(leftFilter: leftFilter, rightFilter: rightFilter);
    }

    return stream.map((stream) => VocabListModel(
        header: HiveBox.get(HiveBox.VOCAB_LIST_HEADER_BOX, listId, defaultValue: null), vocabs: stream.map((e) => VocabModel.fromCombinedSqlite(e)).toList()));
  }

  /// Tell server to insert [color] for [vocabId]
  /// if success, update [UserVocabTable] with modified [originals]
  /// [replaceLast] specify whether to add one [MarkColor] or change the last [MarkColor]
  Future<NetworkException?> addMarkColor({required String vocabId, List<MarkColorModel?>? originals, ColorModel? color, bool replaceLast = false}) async {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    Map<String, dynamic>? map = await HttpWidget.graphQLMutation(
      context: context,
      data: """
      mutation {
          markColor(uuid: "${authViewModel.uuid}", accessToken: "${authViewModel.accessToken}", vocabId: "${vocabId}", index: ${replaceLast ? originals!.length - 1 : originals!.length}, color: ${Util.enumToString(color)}, time: "${DateTime.now().toIso8601String()}") {
              index
              color
              time
          }
      }
      """,
      queryName: "markColor",
      onSuccess: (Map<String, dynamic>? response) => response,
      onFail: (String exception) => <String, dynamic>{"errorMessage": exception},
    );
    if (map == null) return Future.value(NetworkException(message: "duplicated request", uri: null));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"], uri: null));
    if (replaceLast) originals = originals..removeLast();
    await updateUserVocab(vocabId: vocabId, markColors: originals..add(MarkColorModel(color: color, time: DateTime.now())));
    return Future.value();
  }

  /// Update all local vocabs in [VocabStateController] based on server feedback
  Future<NetworkException?> refreshVocab(BuildContext context) async {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    Map<String, dynamic>? map = await HttpWidget.graphQLMutation(
      context: context,
      data: """
      mutation {
          refreshVocab(uuid: "${authViewModel.uuid}", accessToken: "${authViewModel.accessToken}", clientVocabRefreshTime: "${DateTime.now().toIso8601String()}") {
              vocabs {
                  vocabId
              }
          }
      }
      """,
      queryName: "refreshVocab",
      onSuccess: (Map<String, dynamic>? response) => response,
      onFail: (String exception) => <String, dynamic>{"errorMessage": exception},
    );
    if (map == null) return Future.value(NetworkException(message: "duplicated request", uri: null));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"], uri: null));

    List<Map<String, dynamic>> vocabList = map["vocabs"].cast<Map<String, dynamic>>();
    List<String> vocabIds = vocabList.map((e) => e["vocabId"]).cast<String>().toList();

    VocabStateController vocabStateController = Provider.of<VocabStateController>(context, listen: false);
    // set back all pushMarked=true to pushMarked=false, and non-crossMark
    VocabListModel vocabListModel = await getFromDatabase(pushedMark: true);
    for (String vocabId in vocabListModel.vocabs!.map((e) => e.vocabId).cast<String>()) {
      updateUserVocab(vocabId: vocabId, pushedMark: false);
      vocabStateController.crossedVocabIdRemove(vocabId);
    }

    // only set given pushMark to true, and non-crossMark
    for (String vocabId in vocabIds) {
      updateUserVocab(vocabId: vocabId, pushedMark: true);
      vocabStateController.crossedVocabIdRemove(vocabId);
      vocabStateController.unhideVocabIdRemove(vocabId);
    }
    return Future.value();
  }

  /// Update server's [user_vocab_db] for one [vocabId]
  Future<NetworkException?> editUserVocab(
      {String? vocabId, String? editedMeaning, bool? bookMarked, bool? questionMark, bool? starMark, bool? pinMark, bool? addedMark}) async {
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

    Map<String, dynamic>? map = await HttpWidget.graphQLMutation(
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
      onSuccess: (Map<String, dynamic>? response) => response,
      onFail: (String exception) => <String, dynamic>{"errorMessage": exception},
    );
    if (map == null) return Future.value(NetworkException(message: "duplicated request", uri: null));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"], uri: null));
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

  /// Upsert to [UserVocabTable] by [vocabId]
  /// Null arguments means no change
  Future<dynamic> updateUserVocab({
    String? vocabId,
    int? nthWord,
    int? nthAppear,
    List<MarkColorModel?>? markColors,
    String? editedMeaning,
    bool? bookMarked,
    bool? questionMark,
    bool? starMark,
    bool? pinMark,
    bool? addedMark,
    bool? pushedMark,
  }) {
    return _dao.upsertUserVocab(UserVocabSqliteTableCompanion(
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
      pushedMark: ValueOrAbsent(pushedMark)(),
    ));
  }
}
