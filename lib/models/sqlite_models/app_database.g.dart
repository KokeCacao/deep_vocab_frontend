// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class VocabSqliteTableData extends DataClass
    implements Insertable<VocabSqliteTableData> {
  final String vocabId;
  final DateTime edition;
  final List<int> listIds;
  final String vocab;
  final VocabType? type;
  final String? mainTranslation;
  final List<String>? otherTranslation;
  final String? mainSound;
  final List<String>? otherSound;
  final String? englishTranslation;
  final List<CommentModel?>? comments;
  final List<String>? confusingWords;
  final String? memTips;
  final List<String>? exampleSentences;
  final String? userVocabSqliteTableVocabId;
  VocabSqliteTableData(
      {required this.vocabId,
      required this.edition,
      required this.listIds,
      required this.vocab,
      this.type,
      this.mainTranslation,
      this.otherTranslation,
      this.mainSound,
      this.otherSound,
      this.englishTranslation,
      this.comments,
      this.confusingWords,
      this.memTips,
      this.exampleSentences,
      this.userVocabSqliteTableVocabId});
  factory VocabSqliteTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VocabSqliteTableData(
      vocabId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vocab_id'])!,
      edition: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}edition'])!,
      listIds: $VocabSqliteTableTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}list_ids']))!,
      vocab: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vocab'])!,
      type: $VocabSqliteTableTable.$converter1.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      mainTranslation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}main_translation']),
      otherTranslation: $VocabSqliteTableTable.$converter2.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}other_translation'])),
      mainSound: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}main_sound']),
      otherSound: $VocabSqliteTableTable.$converter3.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}other_sound'])),
      englishTranslation: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}english_translation']),
      comments: $VocabSqliteTableTable.$converter4.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}comments'])),
      confusingWords: $VocabSqliteTableTable.$converter5.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}confusing_words'])),
      memTips: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mem_tips']),
      exampleSentences: $VocabSqliteTableTable.$converter6.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}example_sentences'])),
      userVocabSqliteTableVocabId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}user_vocab_sqlite_table_vocab_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vocab_id'] = Variable<String>(vocabId);
    map['edition'] = Variable<DateTime>(edition);
    {
      final converter = $VocabSqliteTableTable.$converter0;
      map['list_ids'] = Variable<String>(converter.mapToSql(listIds)!);
    }
    map['vocab'] = Variable<String>(vocab);
    if (!nullToAbsent || type != null) {
      final converter = $VocabSqliteTableTable.$converter1;
      map['type'] = Variable<int?>(converter.mapToSql(type));
    }
    if (!nullToAbsent || mainTranslation != null) {
      map['main_translation'] = Variable<String?>(mainTranslation);
    }
    if (!nullToAbsent || otherTranslation != null) {
      final converter = $VocabSqliteTableTable.$converter2;
      map['other_translation'] =
          Variable<String?>(converter.mapToSql(otherTranslation));
    }
    if (!nullToAbsent || mainSound != null) {
      map['main_sound'] = Variable<String?>(mainSound);
    }
    if (!nullToAbsent || otherSound != null) {
      final converter = $VocabSqliteTableTable.$converter3;
      map['other_sound'] = Variable<String?>(converter.mapToSql(otherSound));
    }
    if (!nullToAbsent || englishTranslation != null) {
      map['english_translation'] = Variable<String?>(englishTranslation);
    }
    if (!nullToAbsent || comments != null) {
      final converter = $VocabSqliteTableTable.$converter4;
      map['comments'] = Variable<String?>(converter.mapToSql(comments));
    }
    if (!nullToAbsent || confusingWords != null) {
      final converter = $VocabSqliteTableTable.$converter5;
      map['confusing_words'] =
          Variable<String?>(converter.mapToSql(confusingWords));
    }
    if (!nullToAbsent || memTips != null) {
      map['mem_tips'] = Variable<String?>(memTips);
    }
    if (!nullToAbsent || exampleSentences != null) {
      final converter = $VocabSqliteTableTable.$converter6;
      map['example_sentences'] =
          Variable<String?>(converter.mapToSql(exampleSentences));
    }
    if (!nullToAbsent || userVocabSqliteTableVocabId != null) {
      map['user_vocab_sqlite_table_vocab_id'] =
          Variable<String?>(userVocabSqliteTableVocabId);
    }
    return map;
  }

  VocabSqliteTableCompanion toCompanion(bool nullToAbsent) {
    return VocabSqliteTableCompanion(
      vocabId: Value(vocabId),
      edition: Value(edition),
      listIds: Value(listIds),
      vocab: Value(vocab),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      mainTranslation: mainTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(mainTranslation),
      otherTranslation: otherTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(otherTranslation),
      mainSound: mainSound == null && nullToAbsent
          ? const Value.absent()
          : Value(mainSound),
      otherSound: otherSound == null && nullToAbsent
          ? const Value.absent()
          : Value(otherSound),
      englishTranslation: englishTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(englishTranslation),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      confusingWords: confusingWords == null && nullToAbsent
          ? const Value.absent()
          : Value(confusingWords),
      memTips: memTips == null && nullToAbsent
          ? const Value.absent()
          : Value(memTips),
      exampleSentences: exampleSentences == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleSentences),
      userVocabSqliteTableVocabId:
          userVocabSqliteTableVocabId == null && nullToAbsent
              ? const Value.absent()
              : Value(userVocabSqliteTableVocabId),
    );
  }

  factory VocabSqliteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VocabSqliteTableData(
      vocabId: serializer.fromJson<String>(json['vocabId']),
      edition: serializer.fromJson<DateTime>(json['edition']),
      listIds: serializer.fromJson<List<int>>(json['listIds']),
      vocab: serializer.fromJson<String>(json['vocab']),
      type: serializer.fromJson<VocabType?>(json['type']),
      mainTranslation: serializer.fromJson<String?>(json['mainTranslation']),
      otherTranslation:
          serializer.fromJson<List<String>?>(json['otherTranslation']),
      mainSound: serializer.fromJson<String?>(json['mainSound']),
      otherSound: serializer.fromJson<List<String>?>(json['otherSound']),
      englishTranslation:
          serializer.fromJson<String?>(json['englishTranslation']),
      comments: serializer.fromJson<List<CommentModel?>?>(json['comments']),
      confusingWords:
          serializer.fromJson<List<String>?>(json['confusingWords']),
      memTips: serializer.fromJson<String?>(json['memTips']),
      exampleSentences:
          serializer.fromJson<List<String>?>(json['exampleSentences']),
      userVocabSqliteTableVocabId:
          serializer.fromJson<String?>(json['userVocabSqliteTableVocabId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vocabId': serializer.toJson<String>(vocabId),
      'edition': serializer.toJson<DateTime>(edition),
      'listIds': serializer.toJson<List<int>>(listIds),
      'vocab': serializer.toJson<String>(vocab),
      'type': serializer.toJson<VocabType?>(type),
      'mainTranslation': serializer.toJson<String?>(mainTranslation),
      'otherTranslation': serializer.toJson<List<String>?>(otherTranslation),
      'mainSound': serializer.toJson<String?>(mainSound),
      'otherSound': serializer.toJson<List<String>?>(otherSound),
      'englishTranslation': serializer.toJson<String?>(englishTranslation),
      'comments': serializer.toJson<List<CommentModel?>?>(comments),
      'confusingWords': serializer.toJson<List<String>?>(confusingWords),
      'memTips': serializer.toJson<String?>(memTips),
      'exampleSentences': serializer.toJson<List<String>?>(exampleSentences),
      'userVocabSqliteTableVocabId':
          serializer.toJson<String?>(userVocabSqliteTableVocabId),
    };
  }

  VocabSqliteTableData copyWith(
          {String? vocabId,
          DateTime? edition,
          List<int>? listIds,
          String? vocab,
          VocabType? type,
          String? mainTranslation,
          List<String>? otherTranslation,
          String? mainSound,
          List<String>? otherSound,
          String? englishTranslation,
          List<CommentModel?>? comments,
          List<String>? confusingWords,
          String? memTips,
          List<String>? exampleSentences,
          String? userVocabSqliteTableVocabId}) =>
      VocabSqliteTableData(
        vocabId: vocabId ?? this.vocabId,
        edition: edition ?? this.edition,
        listIds: listIds ?? this.listIds,
        vocab: vocab ?? this.vocab,
        type: type ?? this.type,
        mainTranslation: mainTranslation ?? this.mainTranslation,
        otherTranslation: otherTranslation ?? this.otherTranslation,
        mainSound: mainSound ?? this.mainSound,
        otherSound: otherSound ?? this.otherSound,
        englishTranslation: englishTranslation ?? this.englishTranslation,
        comments: comments ?? this.comments,
        confusingWords: confusingWords ?? this.confusingWords,
        memTips: memTips ?? this.memTips,
        exampleSentences: exampleSentences ?? this.exampleSentences,
        userVocabSqliteTableVocabId:
            userVocabSqliteTableVocabId ?? this.userVocabSqliteTableVocabId,
      );
  @override
  String toString() {
    return (StringBuffer('VocabSqliteTableData(')
          ..write('vocabId: $vocabId, ')
          ..write('edition: $edition, ')
          ..write('listIds: $listIds, ')
          ..write('vocab: $vocab, ')
          ..write('type: $type, ')
          ..write('mainTranslation: $mainTranslation, ')
          ..write('otherTranslation: $otherTranslation, ')
          ..write('mainSound: $mainSound, ')
          ..write('otherSound: $otherSound, ')
          ..write('englishTranslation: $englishTranslation, ')
          ..write('comments: $comments, ')
          ..write('confusingWords: $confusingWords, ')
          ..write('memTips: $memTips, ')
          ..write('exampleSentences: $exampleSentences, ')
          ..write('userVocabSqliteTableVocabId: $userVocabSqliteTableVocabId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      vocabId.hashCode,
      $mrjc(
          edition.hashCode,
          $mrjc(
              listIds.hashCode,
              $mrjc(
                  vocab.hashCode,
                  $mrjc(
                      type.hashCode,
                      $mrjc(
                          mainTranslation.hashCode,
                          $mrjc(
                              otherTranslation.hashCode,
                              $mrjc(
                                  mainSound.hashCode,
                                  $mrjc(
                                      otherSound.hashCode,
                                      $mrjc(
                                          englishTranslation.hashCode,
                                          $mrjc(
                                              comments.hashCode,
                                              $mrjc(
                                                  confusingWords.hashCode,
                                                  $mrjc(
                                                      memTips.hashCode,
                                                      $mrjc(
                                                          exampleSentences
                                                              .hashCode,
                                                          userVocabSqliteTableVocabId
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabSqliteTableData &&
          other.vocabId == this.vocabId &&
          other.edition == this.edition &&
          other.listIds == this.listIds &&
          other.vocab == this.vocab &&
          other.type == this.type &&
          other.mainTranslation == this.mainTranslation &&
          other.otherTranslation == this.otherTranslation &&
          other.mainSound == this.mainSound &&
          other.otherSound == this.otherSound &&
          other.englishTranslation == this.englishTranslation &&
          other.comments == this.comments &&
          other.confusingWords == this.confusingWords &&
          other.memTips == this.memTips &&
          other.exampleSentences == this.exampleSentences &&
          other.userVocabSqliteTableVocabId ==
              this.userVocabSqliteTableVocabId);
}

class VocabSqliteTableCompanion extends UpdateCompanion<VocabSqliteTableData> {
  final Value<String> vocabId;
  final Value<DateTime> edition;
  final Value<List<int>> listIds;
  final Value<String> vocab;
  final Value<VocabType?> type;
  final Value<String?> mainTranslation;
  final Value<List<String>?> otherTranslation;
  final Value<String?> mainSound;
  final Value<List<String>?> otherSound;
  final Value<String?> englishTranslation;
  final Value<List<CommentModel?>?> comments;
  final Value<List<String>?> confusingWords;
  final Value<String?> memTips;
  final Value<List<String>?> exampleSentences;
  final Value<String?> userVocabSqliteTableVocabId;
  const VocabSqliteTableCompanion({
    this.vocabId = const Value.absent(),
    this.edition = const Value.absent(),
    this.listIds = const Value.absent(),
    this.vocab = const Value.absent(),
    this.type = const Value.absent(),
    this.mainTranslation = const Value.absent(),
    this.otherTranslation = const Value.absent(),
    this.mainSound = const Value.absent(),
    this.otherSound = const Value.absent(),
    this.englishTranslation = const Value.absent(),
    this.comments = const Value.absent(),
    this.confusingWords = const Value.absent(),
    this.memTips = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.userVocabSqliteTableVocabId = const Value.absent(),
  });
  VocabSqliteTableCompanion.insert({
    required String vocabId,
    required DateTime edition,
    required List<int> listIds,
    required String vocab,
    this.type = const Value.absent(),
    this.mainTranslation = const Value.absent(),
    this.otherTranslation = const Value.absent(),
    this.mainSound = const Value.absent(),
    this.otherSound = const Value.absent(),
    this.englishTranslation = const Value.absent(),
    this.comments = const Value.absent(),
    this.confusingWords = const Value.absent(),
    this.memTips = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.userVocabSqliteTableVocabId = const Value.absent(),
  })  : vocabId = Value(vocabId),
        edition = Value(edition),
        listIds = Value(listIds),
        vocab = Value(vocab);
  static Insertable<VocabSqliteTableData> custom({
    Expression<String>? vocabId,
    Expression<DateTime>? edition,
    Expression<List<int>>? listIds,
    Expression<String>? vocab,
    Expression<VocabType?>? type,
    Expression<String?>? mainTranslation,
    Expression<List<String>?>? otherTranslation,
    Expression<String?>? mainSound,
    Expression<List<String>?>? otherSound,
    Expression<String?>? englishTranslation,
    Expression<List<CommentModel?>?>? comments,
    Expression<List<String>?>? confusingWords,
    Expression<String?>? memTips,
    Expression<List<String>?>? exampleSentences,
    Expression<String?>? userVocabSqliteTableVocabId,
  }) {
    return RawValuesInsertable({
      if (vocabId != null) 'vocab_id': vocabId,
      if (edition != null) 'edition': edition,
      if (listIds != null) 'list_ids': listIds,
      if (vocab != null) 'vocab': vocab,
      if (type != null) 'type': type,
      if (mainTranslation != null) 'main_translation': mainTranslation,
      if (otherTranslation != null) 'other_translation': otherTranslation,
      if (mainSound != null) 'main_sound': mainSound,
      if (otherSound != null) 'other_sound': otherSound,
      if (englishTranslation != null) 'english_translation': englishTranslation,
      if (comments != null) 'comments': comments,
      if (confusingWords != null) 'confusing_words': confusingWords,
      if (memTips != null) 'mem_tips': memTips,
      if (exampleSentences != null) 'example_sentences': exampleSentences,
      if (userVocabSqliteTableVocabId != null)
        'user_vocab_sqlite_table_vocab_id': userVocabSqliteTableVocabId,
    });
  }

  VocabSqliteTableCompanion copyWith(
      {Value<String>? vocabId,
      Value<DateTime>? edition,
      Value<List<int>>? listIds,
      Value<String>? vocab,
      Value<VocabType?>? type,
      Value<String?>? mainTranslation,
      Value<List<String>?>? otherTranslation,
      Value<String?>? mainSound,
      Value<List<String>?>? otherSound,
      Value<String?>? englishTranslation,
      Value<List<CommentModel?>?>? comments,
      Value<List<String>?>? confusingWords,
      Value<String?>? memTips,
      Value<List<String>?>? exampleSentences,
      Value<String?>? userVocabSqliteTableVocabId}) {
    return VocabSqliteTableCompanion(
      vocabId: vocabId ?? this.vocabId,
      edition: edition ?? this.edition,
      listIds: listIds ?? this.listIds,
      vocab: vocab ?? this.vocab,
      type: type ?? this.type,
      mainTranslation: mainTranslation ?? this.mainTranslation,
      otherTranslation: otherTranslation ?? this.otherTranslation,
      mainSound: mainSound ?? this.mainSound,
      otherSound: otherSound ?? this.otherSound,
      englishTranslation: englishTranslation ?? this.englishTranslation,
      comments: comments ?? this.comments,
      confusingWords: confusingWords ?? this.confusingWords,
      memTips: memTips ?? this.memTips,
      exampleSentences: exampleSentences ?? this.exampleSentences,
      userVocabSqliteTableVocabId:
          userVocabSqliteTableVocabId ?? this.userVocabSqliteTableVocabId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vocabId.present) {
      map['vocab_id'] = Variable<String>(vocabId.value);
    }
    if (edition.present) {
      map['edition'] = Variable<DateTime>(edition.value);
    }
    if (listIds.present) {
      final converter = $VocabSqliteTableTable.$converter0;
      map['list_ids'] = Variable<String>(converter.mapToSql(listIds.value)!);
    }
    if (vocab.present) {
      map['vocab'] = Variable<String>(vocab.value);
    }
    if (type.present) {
      final converter = $VocabSqliteTableTable.$converter1;
      map['type'] = Variable<int?>(converter.mapToSql(type.value));
    }
    if (mainTranslation.present) {
      map['main_translation'] = Variable<String?>(mainTranslation.value);
    }
    if (otherTranslation.present) {
      final converter = $VocabSqliteTableTable.$converter2;
      map['other_translation'] =
          Variable<String?>(converter.mapToSql(otherTranslation.value));
    }
    if (mainSound.present) {
      map['main_sound'] = Variable<String?>(mainSound.value);
    }
    if (otherSound.present) {
      final converter = $VocabSqliteTableTable.$converter3;
      map['other_sound'] =
          Variable<String?>(converter.mapToSql(otherSound.value));
    }
    if (englishTranslation.present) {
      map['english_translation'] = Variable<String?>(englishTranslation.value);
    }
    if (comments.present) {
      final converter = $VocabSqliteTableTable.$converter4;
      map['comments'] = Variable<String?>(converter.mapToSql(comments.value));
    }
    if (confusingWords.present) {
      final converter = $VocabSqliteTableTable.$converter5;
      map['confusing_words'] =
          Variable<String?>(converter.mapToSql(confusingWords.value));
    }
    if (memTips.present) {
      map['mem_tips'] = Variable<String?>(memTips.value);
    }
    if (exampleSentences.present) {
      final converter = $VocabSqliteTableTable.$converter6;
      map['example_sentences'] =
          Variable<String?>(converter.mapToSql(exampleSentences.value));
    }
    if (userVocabSqliteTableVocabId.present) {
      map['user_vocab_sqlite_table_vocab_id'] =
          Variable<String?>(userVocabSqliteTableVocabId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabSqliteTableCompanion(')
          ..write('vocabId: $vocabId, ')
          ..write('edition: $edition, ')
          ..write('listIds: $listIds, ')
          ..write('vocab: $vocab, ')
          ..write('type: $type, ')
          ..write('mainTranslation: $mainTranslation, ')
          ..write('otherTranslation: $otherTranslation, ')
          ..write('mainSound: $mainSound, ')
          ..write('otherSound: $otherSound, ')
          ..write('englishTranslation: $englishTranslation, ')
          ..write('comments: $comments, ')
          ..write('confusingWords: $confusingWords, ')
          ..write('memTips: $memTips, ')
          ..write('exampleSentences: $exampleSentences, ')
          ..write('userVocabSqliteTableVocabId: $userVocabSqliteTableVocabId')
          ..write(')'))
        .toString();
  }
}

class $VocabSqliteTableTable extends VocabSqliteTable
    with TableInfo<$VocabSqliteTableTable, VocabSqliteTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $VocabSqliteTableTable(this._db, [this._alias]);
  final VerificationMeta _vocabIdMeta = const VerificationMeta('vocabId');
  late final GeneratedColumn<String?> vocabId = GeneratedColumn<String?>(
      'vocab_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _editionMeta = const VerificationMeta('edition');
  late final GeneratedColumn<DateTime?> edition = GeneratedColumn<DateTime?>(
      'edition', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _listIdsMeta = const VerificationMeta('listIds');
  late final GeneratedColumnWithTypeConverter<List<int>, String?> listIds =
      GeneratedColumn<String?>('list_ids', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<List<int>>($VocabSqliteTableTable.$converter0);
  final VerificationMeta _vocabMeta = const VerificationMeta('vocab');
  late final GeneratedColumn<String?> vocab = GeneratedColumn<String?>(
      'vocab', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<VocabType?, int?> type =
      GeneratedColumn<int?>('type', aliasedName, true,
              typeName: 'INTEGER', requiredDuringInsert: false)
          .withConverter<VocabType?>($VocabSqliteTableTable.$converter1);
  final VerificationMeta _mainTranslationMeta =
      const VerificationMeta('mainTranslation');
  late final GeneratedColumn<String?> mainTranslation =
      GeneratedColumn<String?>('main_translation', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _otherTranslationMeta =
      const VerificationMeta('otherTranslation');
  late final GeneratedColumnWithTypeConverter<List<String>, String?>
      otherTranslation = GeneratedColumn<String?>(
              'other_translation', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<List<String>>($VocabSqliteTableTable.$converter2);
  final VerificationMeta _mainSoundMeta = const VerificationMeta('mainSound');
  late final GeneratedColumn<String?> mainSound = GeneratedColumn<String?>(
      'main_sound', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _otherSoundMeta = const VerificationMeta('otherSound');
  late final GeneratedColumnWithTypeConverter<List<String>, String?>
      otherSound = GeneratedColumn<String?>('other_sound', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<List<String>>($VocabSqliteTableTable.$converter3);
  final VerificationMeta _englishTranslationMeta =
      const VerificationMeta('englishTranslation');
  late final GeneratedColumn<String?> englishTranslation =
      GeneratedColumn<String?>('english_translation', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _commentsMeta = const VerificationMeta('comments');
  late final GeneratedColumnWithTypeConverter<List<CommentModel?>, String?>
      comments = GeneratedColumn<String?>('comments', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<List<CommentModel?>>(
              $VocabSqliteTableTable.$converter4);
  final VerificationMeta _confusingWordsMeta =
      const VerificationMeta('confusingWords');
  late final GeneratedColumnWithTypeConverter<List<String>, String?>
      confusingWords = GeneratedColumn<String?>(
              'confusing_words', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<List<String>>($VocabSqliteTableTable.$converter5);
  final VerificationMeta _memTipsMeta = const VerificationMeta('memTips');
  late final GeneratedColumn<String?> memTips = GeneratedColumn<String?>(
      'mem_tips', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _exampleSentencesMeta =
      const VerificationMeta('exampleSentences');
  late final GeneratedColumnWithTypeConverter<List<String>, String?>
      exampleSentences = GeneratedColumn<String?>(
              'example_sentences', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<List<String>>($VocabSqliteTableTable.$converter6);
  final VerificationMeta _userVocabSqliteTableVocabIdMeta =
      const VerificationMeta('userVocabSqliteTableVocabId');
  late final GeneratedColumn<String?> userVocabSqliteTableVocabId =
      GeneratedColumn<String?>(
          'user_vocab_sqlite_table_vocab_id', aliasedName, true,
          typeName: 'TEXT',
          requiredDuringInsert: false,
          $customConstraints:
              'NULL REFERENCES user_vocab_sqlite_table(vocab_id)');
  @override
  List<GeneratedColumn> get $columns => [
        vocabId,
        edition,
        listIds,
        vocab,
        type,
        mainTranslation,
        otherTranslation,
        mainSound,
        otherSound,
        englishTranslation,
        comments,
        confusingWords,
        memTips,
        exampleSentences,
        userVocabSqliteTableVocabId
      ];
  @override
  String get aliasedName => _alias ?? 'vocab_sqlite_table';
  @override
  String get actualTableName => 'vocab_sqlite_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<VocabSqliteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vocab_id')) {
      context.handle(_vocabIdMeta,
          vocabId.isAcceptableOrUnknown(data['vocab_id']!, _vocabIdMeta));
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    if (data.containsKey('edition')) {
      context.handle(_editionMeta,
          edition.isAcceptableOrUnknown(data['edition']!, _editionMeta));
    } else if (isInserting) {
      context.missing(_editionMeta);
    }
    context.handle(_listIdsMeta, const VerificationResult.success());
    if (data.containsKey('vocab')) {
      context.handle(
          _vocabMeta, vocab.isAcceptableOrUnknown(data['vocab']!, _vocabMeta));
    } else if (isInserting) {
      context.missing(_vocabMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('main_translation')) {
      context.handle(
          _mainTranslationMeta,
          mainTranslation.isAcceptableOrUnknown(
              data['main_translation']!, _mainTranslationMeta));
    }
    context.handle(_otherTranslationMeta, const VerificationResult.success());
    if (data.containsKey('main_sound')) {
      context.handle(_mainSoundMeta,
          mainSound.isAcceptableOrUnknown(data['main_sound']!, _mainSoundMeta));
    }
    context.handle(_otherSoundMeta, const VerificationResult.success());
    if (data.containsKey('english_translation')) {
      context.handle(
          _englishTranslationMeta,
          englishTranslation.isAcceptableOrUnknown(
              data['english_translation']!, _englishTranslationMeta));
    }
    context.handle(_commentsMeta, const VerificationResult.success());
    context.handle(_confusingWordsMeta, const VerificationResult.success());
    if (data.containsKey('mem_tips')) {
      context.handle(_memTipsMeta,
          memTips.isAcceptableOrUnknown(data['mem_tips']!, _memTipsMeta));
    }
    context.handle(_exampleSentencesMeta, const VerificationResult.success());
    if (data.containsKey('user_vocab_sqlite_table_vocab_id')) {
      context.handle(
          _userVocabSqliteTableVocabIdMeta,
          userVocabSqliteTableVocabId.isAcceptableOrUnknown(
              data['user_vocab_sqlite_table_vocab_id']!,
              _userVocabSqliteTableVocabIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vocabId};
  @override
  VocabSqliteTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VocabSqliteTableData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VocabSqliteTableTable createAlias(String alias) {
    return $VocabSqliteTableTable(_db, alias);
  }

  static TypeConverter<List<int>, String> $converter0 =
      const IntegerListConverter();
  static TypeConverter<VocabType?, int> $converter1 =
      const EnumIndexConverter<VocabType>(VocabType.values);
  static TypeConverter<List<String>, String> $converter2 =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converter3 =
      const StringListConverter();
  static TypeConverter<List<CommentModel?>, String> $converter4 =
      const CommentModelListConverter();
  static TypeConverter<List<String>, String> $converter5 =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converter6 =
      const StringListConverter();
}

class UserVocabSqliteTableData extends DataClass
    implements Insertable<UserVocabSqliteTableData> {
  final String vocabId;
  final int nthWord;
  final int nthAppear;
  final List<MarkColorModel?>? markColors;
  final String? editedMeaning;
  final bool bookMarked;
  final bool questionMark;
  final bool starMark;
  final bool pinMark;
  final bool addedMark;
  final bool? pushedMark;
  UserVocabSqliteTableData(
      {required this.vocabId,
      required this.nthWord,
      required this.nthAppear,
      this.markColors,
      this.editedMeaning,
      required this.bookMarked,
      required this.questionMark,
      required this.starMark,
      required this.pinMark,
      required this.addedMark,
      this.pushedMark});
  factory UserVocabSqliteTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserVocabSqliteTableData(
      vocabId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vocab_id'])!,
      nthWord: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nth_word'])!,
      nthAppear: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nth_appear'])!,
      markColors: $UserVocabSqliteTableTable.$converter0.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}mark_colors'])),
      editedMeaning: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}edited_meaning']),
      bookMarked: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}book_marked'])!,
      questionMark: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}question_mark'])!,
      starMark: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}star_mark'])!,
      pinMark: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pin_mark'])!,
      addedMark: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}added_mark'])!,
      pushedMark: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pushed_mark']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vocab_id'] = Variable<String>(vocabId);
    map['nth_word'] = Variable<int>(nthWord);
    map['nth_appear'] = Variable<int>(nthAppear);
    if (!nullToAbsent || markColors != null) {
      final converter = $UserVocabSqliteTableTable.$converter0;
      map['mark_colors'] = Variable<String?>(converter.mapToSql(markColors));
    }
    if (!nullToAbsent || editedMeaning != null) {
      map['edited_meaning'] = Variable<String?>(editedMeaning);
    }
    map['book_marked'] = Variable<bool>(bookMarked);
    map['question_mark'] = Variable<bool>(questionMark);
    map['star_mark'] = Variable<bool>(starMark);
    map['pin_mark'] = Variable<bool>(pinMark);
    map['added_mark'] = Variable<bool>(addedMark);
    if (!nullToAbsent || pushedMark != null) {
      map['pushed_mark'] = Variable<bool?>(pushedMark);
    }
    return map;
  }

  UserVocabSqliteTableCompanion toCompanion(bool nullToAbsent) {
    return UserVocabSqliteTableCompanion(
      vocabId: Value(vocabId),
      nthWord: Value(nthWord),
      nthAppear: Value(nthAppear),
      markColors: markColors == null && nullToAbsent
          ? const Value.absent()
          : Value(markColors),
      editedMeaning: editedMeaning == null && nullToAbsent
          ? const Value.absent()
          : Value(editedMeaning),
      bookMarked: Value(bookMarked),
      questionMark: Value(questionMark),
      starMark: Value(starMark),
      pinMark: Value(pinMark),
      addedMark: Value(addedMark),
      pushedMark: pushedMark == null && nullToAbsent
          ? const Value.absent()
          : Value(pushedMark),
    );
  }

  factory UserVocabSqliteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserVocabSqliteTableData(
      vocabId: serializer.fromJson<String>(json['vocabId']),
      nthWord: serializer.fromJson<int>(json['nthWord']),
      nthAppear: serializer.fromJson<int>(json['nthAppear']),
      markColors:
          serializer.fromJson<List<MarkColorModel?>?>(json['markColors']),
      editedMeaning: serializer.fromJson<String?>(json['editedMeaning']),
      bookMarked: serializer.fromJson<bool>(json['bookMarked']),
      questionMark: serializer.fromJson<bool>(json['questionMark']),
      starMark: serializer.fromJson<bool>(json['starMark']),
      pinMark: serializer.fromJson<bool>(json['pinMark']),
      addedMark: serializer.fromJson<bool>(json['addedMark']),
      pushedMark: serializer.fromJson<bool?>(json['pushedMark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vocabId': serializer.toJson<String>(vocabId),
      'nthWord': serializer.toJson<int>(nthWord),
      'nthAppear': serializer.toJson<int>(nthAppear),
      'markColors': serializer.toJson<List<MarkColorModel?>?>(markColors),
      'editedMeaning': serializer.toJson<String?>(editedMeaning),
      'bookMarked': serializer.toJson<bool>(bookMarked),
      'questionMark': serializer.toJson<bool>(questionMark),
      'starMark': serializer.toJson<bool>(starMark),
      'pinMark': serializer.toJson<bool>(pinMark),
      'addedMark': serializer.toJson<bool>(addedMark),
      'pushedMark': serializer.toJson<bool?>(pushedMark),
    };
  }

  UserVocabSqliteTableData copyWith(
          {String? vocabId,
          int? nthWord,
          int? nthAppear,
          List<MarkColorModel?>? markColors,
          String? editedMeaning,
          bool? bookMarked,
          bool? questionMark,
          bool? starMark,
          bool? pinMark,
          bool? addedMark,
          bool? pushedMark}) =>
      UserVocabSqliteTableData(
        vocabId: vocabId ?? this.vocabId,
        nthWord: nthWord ?? this.nthWord,
        nthAppear: nthAppear ?? this.nthAppear,
        markColors: markColors ?? this.markColors,
        editedMeaning: editedMeaning ?? this.editedMeaning,
        bookMarked: bookMarked ?? this.bookMarked,
        questionMark: questionMark ?? this.questionMark,
        starMark: starMark ?? this.starMark,
        pinMark: pinMark ?? this.pinMark,
        addedMark: addedMark ?? this.addedMark,
        pushedMark: pushedMark ?? this.pushedMark,
      );
  @override
  String toString() {
    return (StringBuffer('UserVocabSqliteTableData(')
          ..write('vocabId: $vocabId, ')
          ..write('nthWord: $nthWord, ')
          ..write('nthAppear: $nthAppear, ')
          ..write('markColors: $markColors, ')
          ..write('editedMeaning: $editedMeaning, ')
          ..write('bookMarked: $bookMarked, ')
          ..write('questionMark: $questionMark, ')
          ..write('starMark: $starMark, ')
          ..write('pinMark: $pinMark, ')
          ..write('addedMark: $addedMark, ')
          ..write('pushedMark: $pushedMark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      vocabId.hashCode,
      $mrjc(
          nthWord.hashCode,
          $mrjc(
              nthAppear.hashCode,
              $mrjc(
                  markColors.hashCode,
                  $mrjc(
                      editedMeaning.hashCode,
                      $mrjc(
                          bookMarked.hashCode,
                          $mrjc(
                              questionMark.hashCode,
                              $mrjc(
                                  starMark.hashCode,
                                  $mrjc(
                                      pinMark.hashCode,
                                      $mrjc(addedMark.hashCode,
                                          pushedMark.hashCode)))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserVocabSqliteTableData &&
          other.vocabId == this.vocabId &&
          other.nthWord == this.nthWord &&
          other.nthAppear == this.nthAppear &&
          other.markColors == this.markColors &&
          other.editedMeaning == this.editedMeaning &&
          other.bookMarked == this.bookMarked &&
          other.questionMark == this.questionMark &&
          other.starMark == this.starMark &&
          other.pinMark == this.pinMark &&
          other.addedMark == this.addedMark &&
          other.pushedMark == this.pushedMark);
}

class UserVocabSqliteTableCompanion
    extends UpdateCompanion<UserVocabSqliteTableData> {
  final Value<String> vocabId;
  final Value<int> nthWord;
  final Value<int> nthAppear;
  final Value<List<MarkColorModel?>?> markColors;
  final Value<String?> editedMeaning;
  final Value<bool> bookMarked;
  final Value<bool> questionMark;
  final Value<bool> starMark;
  final Value<bool> pinMark;
  final Value<bool> addedMark;
  final Value<bool?> pushedMark;
  const UserVocabSqliteTableCompanion({
    this.vocabId = const Value.absent(),
    this.nthWord = const Value.absent(),
    this.nthAppear = const Value.absent(),
    this.markColors = const Value.absent(),
    this.editedMeaning = const Value.absent(),
    this.bookMarked = const Value.absent(),
    this.questionMark = const Value.absent(),
    this.starMark = const Value.absent(),
    this.pinMark = const Value.absent(),
    this.addedMark = const Value.absent(),
    this.pushedMark = const Value.absent(),
  });
  UserVocabSqliteTableCompanion.insert({
    required String vocabId,
    this.nthWord = const Value.absent(),
    this.nthAppear = const Value.absent(),
    this.markColors = const Value.absent(),
    this.editedMeaning = const Value.absent(),
    this.bookMarked = const Value.absent(),
    this.questionMark = const Value.absent(),
    this.starMark = const Value.absent(),
    this.pinMark = const Value.absent(),
    this.addedMark = const Value.absent(),
    this.pushedMark = const Value.absent(),
  }) : vocabId = Value(vocabId);
  static Insertable<UserVocabSqliteTableData> custom({
    Expression<String>? vocabId,
    Expression<int>? nthWord,
    Expression<int>? nthAppear,
    Expression<List<MarkColorModel?>?>? markColors,
    Expression<String?>? editedMeaning,
    Expression<bool>? bookMarked,
    Expression<bool>? questionMark,
    Expression<bool>? starMark,
    Expression<bool>? pinMark,
    Expression<bool>? addedMark,
    Expression<bool?>? pushedMark,
  }) {
    return RawValuesInsertable({
      if (vocabId != null) 'vocab_id': vocabId,
      if (nthWord != null) 'nth_word': nthWord,
      if (nthAppear != null) 'nth_appear': nthAppear,
      if (markColors != null) 'mark_colors': markColors,
      if (editedMeaning != null) 'edited_meaning': editedMeaning,
      if (bookMarked != null) 'book_marked': bookMarked,
      if (questionMark != null) 'question_mark': questionMark,
      if (starMark != null) 'star_mark': starMark,
      if (pinMark != null) 'pin_mark': pinMark,
      if (addedMark != null) 'added_mark': addedMark,
      if (pushedMark != null) 'pushed_mark': pushedMark,
    });
  }

  UserVocabSqliteTableCompanion copyWith(
      {Value<String>? vocabId,
      Value<int>? nthWord,
      Value<int>? nthAppear,
      Value<List<MarkColorModel?>?>? markColors,
      Value<String?>? editedMeaning,
      Value<bool>? bookMarked,
      Value<bool>? questionMark,
      Value<bool>? starMark,
      Value<bool>? pinMark,
      Value<bool>? addedMark,
      Value<bool?>? pushedMark}) {
    return UserVocabSqliteTableCompanion(
      vocabId: vocabId ?? this.vocabId,
      nthWord: nthWord ?? this.nthWord,
      nthAppear: nthAppear ?? this.nthAppear,
      markColors: markColors ?? this.markColors,
      editedMeaning: editedMeaning ?? this.editedMeaning,
      bookMarked: bookMarked ?? this.bookMarked,
      questionMark: questionMark ?? this.questionMark,
      starMark: starMark ?? this.starMark,
      pinMark: pinMark ?? this.pinMark,
      addedMark: addedMark ?? this.addedMark,
      pushedMark: pushedMark ?? this.pushedMark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vocabId.present) {
      map['vocab_id'] = Variable<String>(vocabId.value);
    }
    if (nthWord.present) {
      map['nth_word'] = Variable<int>(nthWord.value);
    }
    if (nthAppear.present) {
      map['nth_appear'] = Variable<int>(nthAppear.value);
    }
    if (markColors.present) {
      final converter = $UserVocabSqliteTableTable.$converter0;
      map['mark_colors'] =
          Variable<String?>(converter.mapToSql(markColors.value));
    }
    if (editedMeaning.present) {
      map['edited_meaning'] = Variable<String?>(editedMeaning.value);
    }
    if (bookMarked.present) {
      map['book_marked'] = Variable<bool>(bookMarked.value);
    }
    if (questionMark.present) {
      map['question_mark'] = Variable<bool>(questionMark.value);
    }
    if (starMark.present) {
      map['star_mark'] = Variable<bool>(starMark.value);
    }
    if (pinMark.present) {
      map['pin_mark'] = Variable<bool>(pinMark.value);
    }
    if (addedMark.present) {
      map['added_mark'] = Variable<bool>(addedMark.value);
    }
    if (pushedMark.present) {
      map['pushed_mark'] = Variable<bool?>(pushedMark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserVocabSqliteTableCompanion(')
          ..write('vocabId: $vocabId, ')
          ..write('nthWord: $nthWord, ')
          ..write('nthAppear: $nthAppear, ')
          ..write('markColors: $markColors, ')
          ..write('editedMeaning: $editedMeaning, ')
          ..write('bookMarked: $bookMarked, ')
          ..write('questionMark: $questionMark, ')
          ..write('starMark: $starMark, ')
          ..write('pinMark: $pinMark, ')
          ..write('addedMark: $addedMark, ')
          ..write('pushedMark: $pushedMark')
          ..write(')'))
        .toString();
  }
}

class $UserVocabSqliteTableTable extends UserVocabSqliteTable
    with TableInfo<$UserVocabSqliteTableTable, UserVocabSqliteTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UserVocabSqliteTableTable(this._db, [this._alias]);
  final VerificationMeta _vocabIdMeta = const VerificationMeta('vocabId');
  late final GeneratedColumn<String?> vocabId = GeneratedColumn<String?>(
      'vocab_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nthWordMeta = const VerificationMeta('nthWord');
  late final GeneratedColumn<int?> nthWord = GeneratedColumn<int?>(
      'nth_word', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  final VerificationMeta _nthAppearMeta = const VerificationMeta('nthAppear');
  late final GeneratedColumn<int?> nthAppear = GeneratedColumn<int?>(
      'nth_appear', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  final VerificationMeta _markColorsMeta = const VerificationMeta('markColors');
  late final GeneratedColumnWithTypeConverter<List<MarkColorModel?>, String?>
      markColors = GeneratedColumn<String?>('mark_colors', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<List<MarkColorModel?>>(
              $UserVocabSqliteTableTable.$converter0);
  final VerificationMeta _editedMeaningMeta =
      const VerificationMeta('editedMeaning');
  late final GeneratedColumn<String?> editedMeaning = GeneratedColumn<String?>(
      'edited_meaning', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _bookMarkedMeta = const VerificationMeta('bookMarked');
  late final GeneratedColumn<bool?> bookMarked = GeneratedColumn<bool?>(
      'book_marked', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (book_marked IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _questionMarkMeta =
      const VerificationMeta('questionMark');
  late final GeneratedColumn<bool?> questionMark = GeneratedColumn<bool?>(
      'question_mark', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (question_mark IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _starMarkMeta = const VerificationMeta('starMark');
  late final GeneratedColumn<bool?> starMark = GeneratedColumn<bool?>(
      'star_mark', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (star_mark IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _pinMarkMeta = const VerificationMeta('pinMark');
  late final GeneratedColumn<bool?> pinMark = GeneratedColumn<bool?>(
      'pin_mark', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (pin_mark IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _addedMarkMeta = const VerificationMeta('addedMark');
  late final GeneratedColumn<bool?> addedMark = GeneratedColumn<bool?>(
      'added_mark', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (added_mark IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _pushedMarkMeta = const VerificationMeta('pushedMark');
  late final GeneratedColumn<bool?> pushedMark = GeneratedColumn<bool?>(
      'pushed_mark', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (pushed_mark IN (0, 1))',
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        vocabId,
        nthWord,
        nthAppear,
        markColors,
        editedMeaning,
        bookMarked,
        questionMark,
        starMark,
        pinMark,
        addedMark,
        pushedMark
      ];
  @override
  String get aliasedName => _alias ?? 'user_vocab_sqlite_table';
  @override
  String get actualTableName => 'user_vocab_sqlite_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserVocabSqliteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vocab_id')) {
      context.handle(_vocabIdMeta,
          vocabId.isAcceptableOrUnknown(data['vocab_id']!, _vocabIdMeta));
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    if (data.containsKey('nth_word')) {
      context.handle(_nthWordMeta,
          nthWord.isAcceptableOrUnknown(data['nth_word']!, _nthWordMeta));
    }
    if (data.containsKey('nth_appear')) {
      context.handle(_nthAppearMeta,
          nthAppear.isAcceptableOrUnknown(data['nth_appear']!, _nthAppearMeta));
    }
    context.handle(_markColorsMeta, const VerificationResult.success());
    if (data.containsKey('edited_meaning')) {
      context.handle(
          _editedMeaningMeta,
          editedMeaning.isAcceptableOrUnknown(
              data['edited_meaning']!, _editedMeaningMeta));
    }
    if (data.containsKey('book_marked')) {
      context.handle(
          _bookMarkedMeta,
          bookMarked.isAcceptableOrUnknown(
              data['book_marked']!, _bookMarkedMeta));
    }
    if (data.containsKey('question_mark')) {
      context.handle(
          _questionMarkMeta,
          questionMark.isAcceptableOrUnknown(
              data['question_mark']!, _questionMarkMeta));
    }
    if (data.containsKey('star_mark')) {
      context.handle(_starMarkMeta,
          starMark.isAcceptableOrUnknown(data['star_mark']!, _starMarkMeta));
    }
    if (data.containsKey('pin_mark')) {
      context.handle(_pinMarkMeta,
          pinMark.isAcceptableOrUnknown(data['pin_mark']!, _pinMarkMeta));
    }
    if (data.containsKey('added_mark')) {
      context.handle(_addedMarkMeta,
          addedMark.isAcceptableOrUnknown(data['added_mark']!, _addedMarkMeta));
    }
    if (data.containsKey('pushed_mark')) {
      context.handle(
          _pushedMarkMeta,
          pushedMark.isAcceptableOrUnknown(
              data['pushed_mark']!, _pushedMarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vocabId};
  @override
  UserVocabSqliteTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return UserVocabSqliteTableData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserVocabSqliteTableTable createAlias(String alias) {
    return $UserVocabSqliteTableTable(_db, alias);
  }

  static TypeConverter<List<MarkColorModel?>, String> $converter0 =
      const MarkColorModelListConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $VocabSqliteTableTable vocabSqliteTable =
      $VocabSqliteTableTable(this);
  late final $UserVocabSqliteTableTable userVocabSqliteTable =
      $UserVocabSqliteTableTable(this);
  late final VocabSqliteDao vocabSqliteDao =
      VocabSqliteDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [vocabSqliteTable, userVocabSqliteTable];
}
