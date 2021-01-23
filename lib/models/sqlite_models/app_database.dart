import 'package:deep_vocab/models/sub_models/comment_model.dart';
import 'package:deep_vocab/models/sub_models/mark_color_model.dart';
import 'package:deep_vocab/models/sqlite_models/global_value_serializer.dart';
import 'package:deep_vocab/models/sqlite_models/primitive_list_converter.dart';
import 'package:deep_vocab/models/sqlite_models/vocab_sqlite_dao.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

@UseMoor(tables: [VocabSqliteTable, UserVocabSqliteTable], daos: [VocabSqliteDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  @override
  // TODO: implement migration
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (Migrator m, int from, int to) {},
        beforeOpen: (OpeningDetails details) async {
          // initiate custom serialize (between Map<String, dynamic> and String) for generated code to work
          // see: https://github.com/simolus3/moor/issues/515
          // then see: https://github.com/simolus3/moor/issues/395
          moorRuntimeOptions.defaultSerializer = GlobalValueSerializer();

          await customStatement('PRAGMA foreign_keys = ON');
          return Future.value();
        },
      );
}

class VocabSqliteTable extends Table {
  TextColumn get id => text()();
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get edition => integer()();
  IntColumn get listId => integer()(); // TODO: link
  TextColumn get vocab => text()();
  IntColumn get type => intEnum<VocabType>().nullable()();
  TextColumn get mainTranslation => text().nullable()();
  TextColumn get otherTranslation => text().nullable().map(const StringListConverter())();
  TextColumn get mainSound => text().nullable()();
  TextColumn get otherSound => text().nullable().map(const StringListConverter())();
  TextColumn get englishTranslation => text().nullable()();
  TextColumn get comments => text().nullable().map(const CommentModelListConverter())();
  TextColumn get confusingWordId => text().nullable().map(const StringListConverter())();
  TextColumn get memTips => text().nullable()();
  TextColumn get exampleSentences => text().nullable().map(const StringListConverter())();

  // foreign key constraint
  TextColumn get userVocabSqliteTableId => text().nullable().customConstraint("NULL REFERENCES user_vocab_sqlite_table(id)")();
}

class UserVocabSqliteTable extends Table {
  TextColumn get id => text()();
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get nthWord => integer().withDefault(Constant(0))();
  IntColumn get nthAppear => integer().withDefault(Constant(0))();
  TextColumn get markColors => text().map(const MarkColorModelListConverter()).nullable()();
  TextColumn get editedMeaning => text().nullable()();
  BoolColumn get bookMarked => boolean().withDefault(Constant(false))();
  BoolColumn get questionMark => boolean().withDefault(Constant(false))();
  BoolColumn get starMark => boolean().withDefault(Constant(false))();
  BoolColumn get expoMark => boolean().withDefault(Constant(false))();
}
