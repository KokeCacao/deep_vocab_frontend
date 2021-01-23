import 'package:deep_vocab/models/sqlite_models/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'vocab_sqlite_dao.g.dart';

@UseDao(tables: [VocabSqliteTable, UserVocabSqliteTable])
class VocabSqliteDao extends DatabaseAccessor<AppDatabase> with _$VocabSqliteDaoMixin {
  final AppDatabase db;

  VocabSqliteDao(this.db) : super(db);

  /// TO GET VOCAB DATA ///
  /// get VocabData through future
  Future<List<VocabSqliteTableData>> getAllVocabs() => select(vocabSqliteTable).get();

  /// get VocabData through stream
  Stream<List<VocabSqliteTableData>> watchAllVocabs() => select(vocabSqliteTable).watch();
  Future insertVocab(Insertable<VocabSqliteTableData> vocabSqliteTableData) => into(vocabSqliteTable).insert(vocabSqliteTableData);
  Future updateVocab(Insertable<VocabSqliteTableData> vocabSqliteTableData) => update(vocabSqliteTable).replace(vocabSqliteTableData);
  Future deleteVocab(Insertable<VocabSqliteTableData> vocabSqliteTableData) => delete(vocabSqliteTable).delete(vocabSqliteTableData);

  /// TO GET USER VOCAB DATA ///
  Future insertUserVocab(Insertable<UserVocabSqliteTableData> userVocabSqliteTableData) => into(userVocabSqliteTable).insert(userVocabSqliteTableData);
  Future updateUserVocab(Insertable<UserVocabSqliteTableData> userVocabSqliteTableData) => update(userVocabSqliteTable).replace(userVocabSqliteTableData);
  Future deleteUserVocab(Insertable<UserVocabSqliteTableData> userVocabSqliteTableData) => delete(userVocabSqliteTable).delete(userVocabSqliteTableData);

  /// TO GET BOTH ///
  /// get VocabData + UserDefinedData through future
  Future<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> getAllVocabsWithUser() async {
    List<TypedResult> row = await select(vocabSqliteTable).join([
      leftOuterJoin(userVocabSqliteTable, userVocabSqliteTable.id.equalsExp(vocabSqliteTable.id)),
    ]).get();
    return Future.value(row
        .map((e) => VocabSqliteTableDataWithUserVocabSqliteTableData(
            vocabSqliteTableData: e.readTable(vocabSqliteTable), userVocabSqliteTableData: e.readTable(userVocabSqliteTable)))
        .toList());
  }

  /// get VocabData + UserDefinedData through stream
  Stream<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> watchAllVocabsWithUser() =>
      select(vocabSqliteTable).join([leftOuterJoin(userVocabSqliteTable, userVocabSqliteTable.id.equalsExp(vocabSqliteTable.id))]).watch().map((rows) => rows
          .map((e) => VocabSqliteTableDataWithUserVocabSqliteTableData(
              vocabSqliteTableData: e.readTable(vocabSqliteTable), userVocabSqliteTableData: e.readTable(userVocabSqliteTable)))
          .toList());
}

/// class for VocabData + UserDefinedData
class VocabSqliteTableDataWithUserVocabSqliteTableData {
  final VocabSqliteTableData vocabSqliteTableData;
  final UserVocabSqliteTableData userVocabSqliteTableData;

  VocabSqliteTableDataWithUserVocabSqliteTableData({@required this.vocabSqliteTableData, @required this.userVocabSqliteTableData});
}
