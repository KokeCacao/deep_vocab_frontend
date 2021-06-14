import '../sqlite_models/app_database.dart';
import 'package:moor/moor.dart';

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


  Future upsertAllVocab(List<Insertable<VocabSqliteTableData>> vocabSqliteTableData) =>
      batch((batch) => batch.insertAllOnConflictUpdate(vocabSqliteTable, vocabSqliteTableData));
  Future insertAllVocab(List<Insertable<VocabSqliteTableData>> vocabSqliteTableData) =>
      batch((batch) => batch.insertAll(vocabSqliteTable, vocabSqliteTableData));
  Future upsertVocab(Insertable<VocabSqliteTableData> vocabSqliteTableData) =>
      into(vocabSqliteTable).insert(vocabSqliteTableData, onConflict: DoUpdate((_) => vocabSqliteTableData));
  Future insertVocab(Insertable<VocabSqliteTableData> vocabSqliteTableData) => into(vocabSqliteTable).insert(vocabSqliteTableData);
  Future deleteVocabWith(Insertable<VocabSqliteTableData> vocabSqliteTableData) => update(vocabSqliteTable).replace(vocabSqliteTableData);
  Future deleteVocab(Insertable<VocabSqliteTableData> vocabSqliteTableData) => delete(vocabSqliteTable).delete(vocabSqliteTableData);

  /// TO GET USER VOCAB DATA ///
  // TODO: use insertAllOnConflictUpdate instead of insert
  Future upsertAllUserVocab(List<Insertable<UserVocabSqliteTableData>> userVocabSqliteTableData) =>
      batch((batch) => batch.insertAllOnConflictUpdate(userVocabSqliteTable, userVocabSqliteTableData));
  Future insertAllUserVocab(List<Insertable<UserVocabSqliteTableData>> userVocabSqliteTableData) =>
      batch((batch) => batch.insertAll(userVocabSqliteTable, userVocabSqliteTableData));
  Future upsertUserVocab(Insertable<UserVocabSqliteTableData> userVocabSqliteTableData) =>
      into(userVocabSqliteTable).insert(userVocabSqliteTableData, onConflict: DoUpdate((_) => userVocabSqliteTableData));
  Future insertUserVocab(Insertable<UserVocabSqliteTableData> userVocabSqliteTableData) => into(userVocabSqliteTable).insert(userVocabSqliteTableData);
  Future deleteUserVocabWith(Insertable<UserVocabSqliteTableData> userVocabSqliteTableData) => update(userVocabSqliteTable).replace(userVocabSqliteTableData);
  Future deleteUserVocab(Insertable<UserVocabSqliteTableData> userVocabSqliteTableData) => delete(userVocabSqliteTable).delete(userVocabSqliteTableData);

  /// TO GET BOTH ///
  /// get VocabData + UserDefinedData through future
  Future<VocabSqliteTableDataWithUserVocabSqliteTableData> getVocabsWithUserById({required String vocabId}) async {
    TypedResult row = await (select(vocabSqliteTable)..where((tbl) => tbl.vocabId.equals(vocabId))).join([
      leftOuterJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId)),
    ]).getSingle();
    return Future.value(VocabSqliteTableDataWithUserVocabSqliteTableData(
        vocabSqliteTableData: row.readTable(vocabSqliteTable), userVocabSqliteTableData: row.readTable(userVocabSqliteTable)));
  }

  Future<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> getVocabsWithUserWhere(
      {required Expression<bool?> Function($VocabSqliteTableTable tbl) filter}) async {
    List<TypedResult> row = await (select(vocabSqliteTable)..where(filter)).join([
      leftOuterJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId)),
    ]).get();
    return Future.value(row
        .map((e) => VocabSqliteTableDataWithUserVocabSqliteTableData(
            vocabSqliteTableData: e.readTable(vocabSqliteTable), userVocabSqliteTableData: e.readTable(userVocabSqliteTable)))
        .toList());
  }

  Future<VocabSqliteTableDataWithUserVocabSqliteTableData> getMarkedVocabsWithUserById(
      {required String vocabId}) async {
    TypedResult row = await (select(vocabSqliteTable)..where((tbl) => tbl.vocabId.equals(vocabId)))
        .join([innerJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId))]).getSingle();
    return Future.value(VocabSqliteTableDataWithUserVocabSqliteTableData(
        vocabSqliteTableData: row.readTable(vocabSqliteTable), userVocabSqliteTableData: row.readTable(userVocabSqliteTable)));
  }

  Future<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> getMarkedVocabsWithUserWhere(
      {required Expression<bool?> Function($VocabSqliteTableTable tbl) leftFilter,
      required Expression<bool?> Function($UserVocabSqliteTableTable tbl) rightFilter}) async {
    List<TypedResult> rows = await (select(vocabSqliteTable)..where(leftFilter))
        .join([innerJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId) & rightFilter(userVocabSqliteTable))]).get();
    return Future.value(rows
        .map((e) => VocabSqliteTableDataWithUserVocabSqliteTableData(
            vocabSqliteTableData: e.readTable(vocabSqliteTable), userVocabSqliteTableData: e.readTable(userVocabSqliteTable)))
        .toList());
  }

  /// get VocabData + UserDefinedData through stream
  Stream<VocabSqliteTableDataWithUserVocabSqliteTableData> watchVocabsWithUserById({required String vocabId}) =>
      (select(vocabSqliteTable)..where((tbl) => tbl.vocabId.equals(vocabId)))
          .join([leftOuterJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId))])
          .watchSingle()
          .map((row) => VocabSqliteTableDataWithUserVocabSqliteTableData(
              vocabSqliteTableData: row.readTable(vocabSqliteTable), userVocabSqliteTableData: row.readTable(userVocabSqliteTable)));

  /// select all of [VocabSqliteTable] table that matches the expression [filter], where [UserVocabSqliteTable] might be null
  Stream<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> watchVocabsWithUserWhere(
          {required Expression<bool?> Function($VocabSqliteTableTable tbl) filter}) =>
      (select(vocabSqliteTable)..where(filter))
          .join([leftOuterJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId))])
          .watch()
          .map((rows) => rows
              .map((e) => VocabSqliteTableDataWithUserVocabSqliteTableData(
                  vocabSqliteTableData: e.readTable(vocabSqliteTable), userVocabSqliteTableData: e.readTable(userVocabSqliteTable)))
              .toList());

  Stream<VocabSqliteTableDataWithUserVocabSqliteTableData> watchMarkedVocabsWithUserById(
      {required String vocabId}) =>
      (select(vocabSqliteTable)..where((tbl) => tbl.vocabId.equals(vocabId)))
          .join([innerJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId))])
          .watchSingle()
          .map((row) => VocabSqliteTableDataWithUserVocabSqliteTableData(
          vocabSqliteTableData: row.readTable(vocabSqliteTable), userVocabSqliteTableData: row.readTable(userVocabSqliteTable)));

  /// select some of [VocabSqliteTable] table that matches [leftFilter] that has a non-null [UserVocabSqliteTable] that matches [rightFilter]
  Stream<List<VocabSqliteTableDataWithUserVocabSqliteTableData>> watchMarkedVocabsWithUserWhere(
      {required Expression<bool?> Function($VocabSqliteTableTable tbl) leftFilter,
        required Expression<bool?> Function($UserVocabSqliteTableTable tbl) rightFilter}) =>
      (select(vocabSqliteTable)..where(leftFilter))
          .join([innerJoin(userVocabSqliteTable, userVocabSqliteTable.vocabId.equalsExp(vocabSqliteTable.vocabId) & rightFilter(userVocabSqliteTable))])
          .watch()
          .map((rows) => rows
          .map((e) => VocabSqliteTableDataWithUserVocabSqliteTableData(
          vocabSqliteTableData: e.readTable(vocabSqliteTable), userVocabSqliteTableData: e.readTable(userVocabSqliteTable)))
          .toList());
}

/// class for VocabData + UserDefinedData
class VocabSqliteTableDataWithUserVocabSqliteTableData {
  final VocabSqliteTableData vocabSqliteTableData;
  final UserVocabSqliteTableData userVocabSqliteTableData;

  VocabSqliteTableDataWithUserVocabSqliteTableData({required this.vocabSqliteTableData, required this.userVocabSqliteTableData});
}
