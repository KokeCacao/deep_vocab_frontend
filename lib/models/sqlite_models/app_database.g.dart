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
  final int listId;
  final String vocab;
  final VocabType type;
  final String mainTranslation;
  final List<String> otherTranslation;
  final String mainSound;
  final List<String> otherSound;
  final String englishTranslation;
  final List<CommentModel> comments;
  final List<String> confusingWordId;
  final String memTips;
  final List<String> exampleSentences;
  final String userVocabSqliteTableVocabId;
  VocabSqliteTableData(
      {@required this.vocabId,
      @required this.edition,
      @required this.listId,
      @required this.vocab,
      this.type,
      this.mainTranslation,
      this.otherTranslation,
      this.mainSound,
      this.otherSound,
      this.englishTranslation,
      this.comments,
      this.confusingWordId,
      this.memTips,
      this.exampleSentences,
      this.userVocabSqliteTableVocabId});
  factory VocabSqliteTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return VocabSqliteTableData(
      vocabId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}vocab_id']),
      edition: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}edition']),
      listId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}list_id']),
      vocab:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}vocab']),
      type: $VocabSqliteTableTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      mainTranslation: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}main_translation']),
      otherTranslation: $VocabSqliteTableTable.$converter1.mapToDart(
          stringType.mapFromDatabaseResponse(
              data['${effectivePrefix}other_translation'])),
      mainSound: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}main_sound']),
      otherSound: $VocabSqliteTableTable.$converter2.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}other_sound'])),
      englishTranslation: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}english_translation']),
      comments: $VocabSqliteTableTable.$converter3.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}comments'])),
      confusingWordId: $VocabSqliteTableTable.$converter4.mapToDart(
          stringType.mapFromDatabaseResponse(
              data['${effectivePrefix}confusing_word_id'])),
      memTips: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}mem_tips']),
      exampleSentences: $VocabSqliteTableTable.$converter5.mapToDart(
          stringType.mapFromDatabaseResponse(
              data['${effectivePrefix}example_sentences'])),
      userVocabSqliteTableVocabId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}user_vocab_sqlite_table_vocab_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || vocabId != null) {
      map['vocab_id'] = Variable<String>(vocabId);
    }
    if (!nullToAbsent || edition != null) {
      map['edition'] = Variable<DateTime>(edition);
    }
    if (!nullToAbsent || listId != null) {
      map['list_id'] = Variable<int>(listId);
    }
    if (!nullToAbsent || vocab != null) {
      map['vocab'] = Variable<String>(vocab);
    }
    if (!nullToAbsent || type != null) {
      final converter = $VocabSqliteTableTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type));
    }
    if (!nullToAbsent || mainTranslation != null) {
      map['main_translation'] = Variable<String>(mainTranslation);
    }
    if (!nullToAbsent || otherTranslation != null) {
      final converter = $VocabSqliteTableTable.$converter1;
      map['other_translation'] =
          Variable<String>(converter.mapToSql(otherTranslation));
    }
    if (!nullToAbsent || mainSound != null) {
      map['main_sound'] = Variable<String>(mainSound);
    }
    if (!nullToAbsent || otherSound != null) {
      final converter = $VocabSqliteTableTable.$converter2;
      map['other_sound'] = Variable<String>(converter.mapToSql(otherSound));
    }
    if (!nullToAbsent || englishTranslation != null) {
      map['english_translation'] = Variable<String>(englishTranslation);
    }
    if (!nullToAbsent || comments != null) {
      final converter = $VocabSqliteTableTable.$converter3;
      map['comments'] = Variable<String>(converter.mapToSql(comments));
    }
    if (!nullToAbsent || confusingWordId != null) {
      final converter = $VocabSqliteTableTable.$converter4;
      map['confusing_word_id'] =
          Variable<String>(converter.mapToSql(confusingWordId));
    }
    if (!nullToAbsent || memTips != null) {
      map['mem_tips'] = Variable<String>(memTips);
    }
    if (!nullToAbsent || exampleSentences != null) {
      final converter = $VocabSqliteTableTable.$converter5;
      map['example_sentences'] =
          Variable<String>(converter.mapToSql(exampleSentences));
    }
    if (!nullToAbsent || userVocabSqliteTableVocabId != null) {
      map['user_vocab_sqlite_table_vocab_id'] =
          Variable<String>(userVocabSqliteTableVocabId);
    }
    return map;
  }

  VocabSqliteTableCompanion toCompanion(bool nullToAbsent) {
    return VocabSqliteTableCompanion(
      vocabId: vocabId == null && nullToAbsent
          ? const Value.absent()
          : Value(vocabId),
      edition: edition == null && nullToAbsent
          ? const Value.absent()
          : Value(edition),
      listId:
          listId == null && nullToAbsent ? const Value.absent() : Value(listId),
      vocab:
          vocab == null && nullToAbsent ? const Value.absent() : Value(vocab),
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
      confusingWordId: confusingWordId == null && nullToAbsent
          ? const Value.absent()
          : Value(confusingWordId),
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
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VocabSqliteTableData(
      vocabId: serializer.fromJson<String>(json['vocabId']),
      edition: serializer.fromJson<DateTime>(json['edition']),
      listId: serializer.fromJson<int>(json['listId']),
      vocab: serializer.fromJson<String>(json['vocab']),
      type: serializer.fromJson<VocabType>(json['type']),
      mainTranslation: serializer.fromJson<String>(json['mainTranslation']),
      otherTranslation:
          serializer.fromJson<List<String>>(json['otherTranslation']),
      mainSound: serializer.fromJson<String>(json['mainSound']),
      otherSound: serializer.fromJson<List<String>>(json['otherSound']),
      englishTranslation:
          serializer.fromJson<String>(json['englishTranslation']),
      comments: serializer.fromJson<List<CommentModel>>(json['comments']),
      confusingWordId:
          serializer.fromJson<List<String>>(json['confusingWordId']),
      memTips: serializer.fromJson<String>(json['memTips']),
      exampleSentences:
          serializer.fromJson<List<String>>(json['exampleSentences']),
      userVocabSqliteTableVocabId:
          serializer.fromJson<String>(json['userVocabSqliteTableVocabId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vocabId': serializer.toJson<String>(vocabId),
      'edition': serializer.toJson<DateTime>(edition),
      'listId': serializer.toJson<int>(listId),
      'vocab': serializer.toJson<String>(vocab),
      'type': serializer.toJson<VocabType>(type),
      'mainTranslation': serializer.toJson<String>(mainTranslation),
      'otherTranslation': serializer.toJson<List<String>>(otherTranslation),
      'mainSound': serializer.toJson<String>(mainSound),
      'otherSound': serializer.toJson<List<String>>(otherSound),
      'englishTranslation': serializer.toJson<String>(englishTranslation),
      'comments': serializer.toJson<List<CommentModel>>(comments),
      'confusingWordId': serializer.toJson<List<String>>(confusingWordId),
      'memTips': serializer.toJson<String>(memTips),
      'exampleSentences': serializer.toJson<List<String>>(exampleSentences),
      'userVocabSqliteTableVocabId':
          serializer.toJson<String>(userVocabSqliteTableVocabId),
    };
  }

  VocabSqliteTableData copyWith(
          {String vocabId,
          DateTime edition,
          int listId,
          String vocab,
          VocabType type,
          String mainTranslation,
          List<String> otherTranslation,
          String mainSound,
          List<String> otherSound,
          String englishTranslation,
          List<CommentModel> comments,
          List<String> confusingWordId,
          String memTips,
          List<String> exampleSentences,
          String userVocabSqliteTableVocabId}) =>
      VocabSqliteTableData(
        vocabId: vocabId ?? this.vocabId,
        edition: edition ?? this.edition,
        listId: listId ?? this.listId,
        vocab: vocab ?? this.vocab,
        type: type ?? this.type,
        mainTranslation: mainTranslation ?? this.mainTranslation,
        otherTranslation: otherTranslation ?? this.otherTranslation,
        mainSound: mainSound ?? this.mainSound,
        otherSound: otherSound ?? this.otherSound,
        englishTranslation: englishTranslation ?? this.englishTranslation,
        comments: comments ?? this.comments,
        confusingWordId: confusingWordId ?? this.confusingWordId,
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
          ..write('listId: $listId, ')
          ..write('vocab: $vocab, ')
          ..write('type: $type, ')
          ..write('mainTranslation: $mainTranslation, ')
          ..write('otherTranslation: $otherTranslation, ')
          ..write('mainSound: $mainSound, ')
          ..write('otherSound: $otherSound, ')
          ..write('englishTranslation: $englishTranslation, ')
          ..write('comments: $comments, ')
          ..write('confusingWordId: $confusingWordId, ')
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
              listId.hashCode,
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
                                                  confusingWordId.hashCode,
                                                  $mrjc(
                                                      memTips.hashCode,
                                                      $mrjc(
                                                          exampleSentences
                                                              .hashCode,
                                                          userVocabSqliteTableVocabId
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VocabSqliteTableData &&
          other.vocabId == this.vocabId &&
          other.edition == this.edition &&
          other.listId == this.listId &&
          other.vocab == this.vocab &&
          other.type == this.type &&
          other.mainTranslation == this.mainTranslation &&
          other.otherTranslation == this.otherTranslation &&
          other.mainSound == this.mainSound &&
          other.otherSound == this.otherSound &&
          other.englishTranslation == this.englishTranslation &&
          other.comments == this.comments &&
          other.confusingWordId == this.confusingWordId &&
          other.memTips == this.memTips &&
          other.exampleSentences == this.exampleSentences &&
          other.userVocabSqliteTableVocabId ==
              this.userVocabSqliteTableVocabId);
}

class VocabSqliteTableCompanion extends UpdateCompanion<VocabSqliteTableData> {
  final Value<String> vocabId;
  final Value<DateTime> edition;
  final Value<int> listId;
  final Value<String> vocab;
  final Value<VocabType> type;
  final Value<String> mainTranslation;
  final Value<List<String>> otherTranslation;
  final Value<String> mainSound;
  final Value<List<String>> otherSound;
  final Value<String> englishTranslation;
  final Value<List<CommentModel>> comments;
  final Value<List<String>> confusingWordId;
  final Value<String> memTips;
  final Value<List<String>> exampleSentences;
  final Value<String> userVocabSqliteTableVocabId;
  const VocabSqliteTableCompanion({
    this.vocabId = const Value.absent(),
    this.edition = const Value.absent(),
    this.listId = const Value.absent(),
    this.vocab = const Value.absent(),
    this.type = const Value.absent(),
    this.mainTranslation = const Value.absent(),
    this.otherTranslation = const Value.absent(),
    this.mainSound = const Value.absent(),
    this.otherSound = const Value.absent(),
    this.englishTranslation = const Value.absent(),
    this.comments = const Value.absent(),
    this.confusingWordId = const Value.absent(),
    this.memTips = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.userVocabSqliteTableVocabId = const Value.absent(),
  });
  VocabSqliteTableCompanion.insert({
    @required String vocabId,
    @required DateTime edition,
    @required int listId,
    @required String vocab,
    this.type = const Value.absent(),
    this.mainTranslation = const Value.absent(),
    this.otherTranslation = const Value.absent(),
    this.mainSound = const Value.absent(),
    this.otherSound = const Value.absent(),
    this.englishTranslation = const Value.absent(),
    this.comments = const Value.absent(),
    this.confusingWordId = const Value.absent(),
    this.memTips = const Value.absent(),
    this.exampleSentences = const Value.absent(),
    this.userVocabSqliteTableVocabId = const Value.absent(),
  })  : vocabId = Value(vocabId),
        edition = Value(edition),
        listId = Value(listId),
        vocab = Value(vocab);
  static Insertable<VocabSqliteTableData> custom({
    Expression<String> vocabId,
    Expression<DateTime> edition,
    Expression<int> listId,
    Expression<String> vocab,
    Expression<int> type,
    Expression<String> mainTranslation,
    Expression<String> otherTranslation,
    Expression<String> mainSound,
    Expression<String> otherSound,
    Expression<String> englishTranslation,
    Expression<String> comments,
    Expression<String> confusingWordId,
    Expression<String> memTips,
    Expression<String> exampleSentences,
    Expression<String> userVocabSqliteTableVocabId,
  }) {
    return RawValuesInsertable({
      if (vocabId != null) 'vocab_id': vocabId,
      if (edition != null) 'edition': edition,
      if (listId != null) 'list_id': listId,
      if (vocab != null) 'vocab': vocab,
      if (type != null) 'type': type,
      if (mainTranslation != null) 'main_translation': mainTranslation,
      if (otherTranslation != null) 'other_translation': otherTranslation,
      if (mainSound != null) 'main_sound': mainSound,
      if (otherSound != null) 'other_sound': otherSound,
      if (englishTranslation != null) 'english_translation': englishTranslation,
      if (comments != null) 'comments': comments,
      if (confusingWordId != null) 'confusing_word_id': confusingWordId,
      if (memTips != null) 'mem_tips': memTips,
      if (exampleSentences != null) 'example_sentences': exampleSentences,
      if (userVocabSqliteTableVocabId != null)
        'user_vocab_sqlite_table_vocab_id': userVocabSqliteTableVocabId,
    });
  }

  VocabSqliteTableCompanion copyWith(
      {Value<String> vocabId,
      Value<DateTime> edition,
      Value<int> listId,
      Value<String> vocab,
      Value<VocabType> type,
      Value<String> mainTranslation,
      Value<List<String>> otherTranslation,
      Value<String> mainSound,
      Value<List<String>> otherSound,
      Value<String> englishTranslation,
      Value<List<CommentModel>> comments,
      Value<List<String>> confusingWordId,
      Value<String> memTips,
      Value<List<String>> exampleSentences,
      Value<String> userVocabSqliteTableVocabId}) {
    return VocabSqliteTableCompanion(
      vocabId: vocabId ?? this.vocabId,
      edition: edition ?? this.edition,
      listId: listId ?? this.listId,
      vocab: vocab ?? this.vocab,
      type: type ?? this.type,
      mainTranslation: mainTranslation ?? this.mainTranslation,
      otherTranslation: otherTranslation ?? this.otherTranslation,
      mainSound: mainSound ?? this.mainSound,
      otherSound: otherSound ?? this.otherSound,
      englishTranslation: englishTranslation ?? this.englishTranslation,
      comments: comments ?? this.comments,
      confusingWordId: confusingWordId ?? this.confusingWordId,
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
    if (listId.present) {
      map['list_id'] = Variable<int>(listId.value);
    }
    if (vocab.present) {
      map['vocab'] = Variable<String>(vocab.value);
    }
    if (type.present) {
      final converter = $VocabSqliteTableTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value));
    }
    if (mainTranslation.present) {
      map['main_translation'] = Variable<String>(mainTranslation.value);
    }
    if (otherTranslation.present) {
      final converter = $VocabSqliteTableTable.$converter1;
      map['other_translation'] =
          Variable<String>(converter.mapToSql(otherTranslation.value));
    }
    if (mainSound.present) {
      map['main_sound'] = Variable<String>(mainSound.value);
    }
    if (otherSound.present) {
      final converter = $VocabSqliteTableTable.$converter2;
      map['other_sound'] =
          Variable<String>(converter.mapToSql(otherSound.value));
    }
    if (englishTranslation.present) {
      map['english_translation'] = Variable<String>(englishTranslation.value);
    }
    if (comments.present) {
      final converter = $VocabSqliteTableTable.$converter3;
      map['comments'] = Variable<String>(converter.mapToSql(comments.value));
    }
    if (confusingWordId.present) {
      final converter = $VocabSqliteTableTable.$converter4;
      map['confusing_word_id'] =
          Variable<String>(converter.mapToSql(confusingWordId.value));
    }
    if (memTips.present) {
      map['mem_tips'] = Variable<String>(memTips.value);
    }
    if (exampleSentences.present) {
      final converter = $VocabSqliteTableTable.$converter5;
      map['example_sentences'] =
          Variable<String>(converter.mapToSql(exampleSentences.value));
    }
    if (userVocabSqliteTableVocabId.present) {
      map['user_vocab_sqlite_table_vocab_id'] =
          Variable<String>(userVocabSqliteTableVocabId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabSqliteTableCompanion(')
          ..write('vocabId: $vocabId, ')
          ..write('edition: $edition, ')
          ..write('listId: $listId, ')
          ..write('vocab: $vocab, ')
          ..write('type: $type, ')
          ..write('mainTranslation: $mainTranslation, ')
          ..write('otherTranslation: $otherTranslation, ')
          ..write('mainSound: $mainSound, ')
          ..write('otherSound: $otherSound, ')
          ..write('englishTranslation: $englishTranslation, ')
          ..write('comments: $comments, ')
          ..write('confusingWordId: $confusingWordId, ')
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
  final String _alias;
  $VocabSqliteTableTable(this._db, [this._alias]);
  final VerificationMeta _vocabIdMeta = const VerificationMeta('vocabId');
  GeneratedTextColumn _vocabId;
  @override
  GeneratedTextColumn get vocabId => _vocabId ??= _constructVocabId();
  GeneratedTextColumn _constructVocabId() {
    return GeneratedTextColumn(
      'vocab_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _editionMeta = const VerificationMeta('edition');
  GeneratedDateTimeColumn _edition;
  @override
  GeneratedDateTimeColumn get edition => _edition ??= _constructEdition();
  GeneratedDateTimeColumn _constructEdition() {
    return GeneratedDateTimeColumn(
      'edition',
      $tableName,
      false,
    );
  }

  final VerificationMeta _listIdMeta = const VerificationMeta('listId');
  GeneratedIntColumn _listId;
  @override
  GeneratedIntColumn get listId => _listId ??= _constructListId();
  GeneratedIntColumn _constructListId() {
    return GeneratedIntColumn(
      'list_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _vocabMeta = const VerificationMeta('vocab');
  GeneratedTextColumn _vocab;
  @override
  GeneratedTextColumn get vocab => _vocab ??= _constructVocab();
  GeneratedTextColumn _constructVocab() {
    return GeneratedTextColumn(
      'vocab',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mainTranslationMeta =
      const VerificationMeta('mainTranslation');
  GeneratedTextColumn _mainTranslation;
  @override
  GeneratedTextColumn get mainTranslation =>
      _mainTranslation ??= _constructMainTranslation();
  GeneratedTextColumn _constructMainTranslation() {
    return GeneratedTextColumn(
      'main_translation',
      $tableName,
      true,
    );
  }

  final VerificationMeta _otherTranslationMeta =
      const VerificationMeta('otherTranslation');
  GeneratedTextColumn _otherTranslation;
  @override
  GeneratedTextColumn get otherTranslation =>
      _otherTranslation ??= _constructOtherTranslation();
  GeneratedTextColumn _constructOtherTranslation() {
    return GeneratedTextColumn(
      'other_translation',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mainSoundMeta = const VerificationMeta('mainSound');
  GeneratedTextColumn _mainSound;
  @override
  GeneratedTextColumn get mainSound => _mainSound ??= _constructMainSound();
  GeneratedTextColumn _constructMainSound() {
    return GeneratedTextColumn(
      'main_sound',
      $tableName,
      true,
    );
  }

  final VerificationMeta _otherSoundMeta = const VerificationMeta('otherSound');
  GeneratedTextColumn _otherSound;
  @override
  GeneratedTextColumn get otherSound => _otherSound ??= _constructOtherSound();
  GeneratedTextColumn _constructOtherSound() {
    return GeneratedTextColumn(
      'other_sound',
      $tableName,
      true,
    );
  }

  final VerificationMeta _englishTranslationMeta =
      const VerificationMeta('englishTranslation');
  GeneratedTextColumn _englishTranslation;
  @override
  GeneratedTextColumn get englishTranslation =>
      _englishTranslation ??= _constructEnglishTranslation();
  GeneratedTextColumn _constructEnglishTranslation() {
    return GeneratedTextColumn(
      'english_translation',
      $tableName,
      true,
    );
  }

  final VerificationMeta _commentsMeta = const VerificationMeta('comments');
  GeneratedTextColumn _comments;
  @override
  GeneratedTextColumn get comments => _comments ??= _constructComments();
  GeneratedTextColumn _constructComments() {
    return GeneratedTextColumn(
      'comments',
      $tableName,
      true,
    );
  }

  final VerificationMeta _confusingWordIdMeta =
      const VerificationMeta('confusingWordId');
  GeneratedTextColumn _confusingWordId;
  @override
  GeneratedTextColumn get confusingWordId =>
      _confusingWordId ??= _constructConfusingWordId();
  GeneratedTextColumn _constructConfusingWordId() {
    return GeneratedTextColumn(
      'confusing_word_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _memTipsMeta = const VerificationMeta('memTips');
  GeneratedTextColumn _memTips;
  @override
  GeneratedTextColumn get memTips => _memTips ??= _constructMemTips();
  GeneratedTextColumn _constructMemTips() {
    return GeneratedTextColumn(
      'mem_tips',
      $tableName,
      true,
    );
  }

  final VerificationMeta _exampleSentencesMeta =
      const VerificationMeta('exampleSentences');
  GeneratedTextColumn _exampleSentences;
  @override
  GeneratedTextColumn get exampleSentences =>
      _exampleSentences ??= _constructExampleSentences();
  GeneratedTextColumn _constructExampleSentences() {
    return GeneratedTextColumn(
      'example_sentences',
      $tableName,
      true,
    );
  }

  final VerificationMeta _userVocabSqliteTableVocabIdMeta =
      const VerificationMeta('userVocabSqliteTableVocabId');
  GeneratedTextColumn _userVocabSqliteTableVocabId;
  @override
  GeneratedTextColumn get userVocabSqliteTableVocabId =>
      _userVocabSqliteTableVocabId ??= _constructUserVocabSqliteTableVocabId();
  GeneratedTextColumn _constructUserVocabSqliteTableVocabId() {
    return GeneratedTextColumn(
        'user_vocab_sqlite_table_vocab_id', $tableName, true,
        $customConstraints:
            'NULL REFERENCES user_vocab_sqlite_table(vocab_id)');
  }

  @override
  List<GeneratedColumn> get $columns => [
        vocabId,
        edition,
        listId,
        vocab,
        type,
        mainTranslation,
        otherTranslation,
        mainSound,
        otherSound,
        englishTranslation,
        comments,
        confusingWordId,
        memTips,
        exampleSentences,
        userVocabSqliteTableVocabId
      ];
  @override
  $VocabSqliteTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'vocab_sqlite_table';
  @override
  final String actualTableName = 'vocab_sqlite_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<VocabSqliteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vocab_id')) {
      context.handle(_vocabIdMeta,
          vocabId.isAcceptableOrUnknown(data['vocab_id'], _vocabIdMeta));
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    if (data.containsKey('edition')) {
      context.handle(_editionMeta,
          edition.isAcceptableOrUnknown(data['edition'], _editionMeta));
    } else if (isInserting) {
      context.missing(_editionMeta);
    }
    if (data.containsKey('list_id')) {
      context.handle(_listIdMeta,
          listId.isAcceptableOrUnknown(data['list_id'], _listIdMeta));
    } else if (isInserting) {
      context.missing(_listIdMeta);
    }
    if (data.containsKey('vocab')) {
      context.handle(
          _vocabMeta, vocab.isAcceptableOrUnknown(data['vocab'], _vocabMeta));
    } else if (isInserting) {
      context.missing(_vocabMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('main_translation')) {
      context.handle(
          _mainTranslationMeta,
          mainTranslation.isAcceptableOrUnknown(
              data['main_translation'], _mainTranslationMeta));
    }
    context.handle(_otherTranslationMeta, const VerificationResult.success());
    if (data.containsKey('main_sound')) {
      context.handle(_mainSoundMeta,
          mainSound.isAcceptableOrUnknown(data['main_sound'], _mainSoundMeta));
    }
    context.handle(_otherSoundMeta, const VerificationResult.success());
    if (data.containsKey('english_translation')) {
      context.handle(
          _englishTranslationMeta,
          englishTranslation.isAcceptableOrUnknown(
              data['english_translation'], _englishTranslationMeta));
    }
    context.handle(_commentsMeta, const VerificationResult.success());
    context.handle(_confusingWordIdMeta, const VerificationResult.success());
    if (data.containsKey('mem_tips')) {
      context.handle(_memTipsMeta,
          memTips.isAcceptableOrUnknown(data['mem_tips'], _memTipsMeta));
    }
    context.handle(_exampleSentencesMeta, const VerificationResult.success());
    if (data.containsKey('user_vocab_sqlite_table_vocab_id')) {
      context.handle(
          _userVocabSqliteTableVocabIdMeta,
          userVocabSqliteTableVocabId.isAcceptableOrUnknown(
              data['user_vocab_sqlite_table_vocab_id'],
              _userVocabSqliteTableVocabIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vocabId};
  @override
  VocabSqliteTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VocabSqliteTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VocabSqliteTableTable createAlias(String alias) {
    return $VocabSqliteTableTable(_db, alias);
  }

  static TypeConverter<VocabType, int> $converter0 =
      const EnumIndexConverter<VocabType>(VocabType.values);
  static TypeConverter<List<String>, String> $converter1 =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converter2 =
      const StringListConverter();
  static TypeConverter<List<CommentModel>, String> $converter3 =
      const CommentModelListConverter();
  static TypeConverter<List<String>, String> $converter4 =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converter5 =
      const StringListConverter();
}

class UserVocabSqliteTableData extends DataClass
    implements Insertable<UserVocabSqliteTableData> {
  final String vocabId;
  final int nthWord;
  final int nthAppear;
  final List<MarkColorModel> markColors;
  final String editedMeaning;
  final bool bookMarked;
  final bool questionMark;
  final bool starMark;
  final bool pinMark;
  final bool addedMark;
  UserVocabSqliteTableData(
      {@required this.vocabId,
      @required this.nthWord,
      @required this.nthAppear,
      this.markColors,
      this.editedMeaning,
      @required this.bookMarked,
      @required this.questionMark,
      @required this.starMark,
      @required this.pinMark,
      @required this.addedMark});
  factory UserVocabSqliteTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return UserVocabSqliteTableData(
      vocabId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}vocab_id']),
      nthWord:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}nth_word']),
      nthAppear:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}nth_appear']),
      markColors: $UserVocabSqliteTableTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}mark_colors'])),
      editedMeaning: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}edited_meaning']),
      bookMarked: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}book_marked']),
      questionMark: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}question_mark']),
      starMark:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}star_mark']),
      pinMark:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}pin_mark']),
      addedMark: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}added_mark']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || vocabId != null) {
      map['vocab_id'] = Variable<String>(vocabId);
    }
    if (!nullToAbsent || nthWord != null) {
      map['nth_word'] = Variable<int>(nthWord);
    }
    if (!nullToAbsent || nthAppear != null) {
      map['nth_appear'] = Variable<int>(nthAppear);
    }
    if (!nullToAbsent || markColors != null) {
      final converter = $UserVocabSqliteTableTable.$converter0;
      map['mark_colors'] = Variable<String>(converter.mapToSql(markColors));
    }
    if (!nullToAbsent || editedMeaning != null) {
      map['edited_meaning'] = Variable<String>(editedMeaning);
    }
    if (!nullToAbsent || bookMarked != null) {
      map['book_marked'] = Variable<bool>(bookMarked);
    }
    if (!nullToAbsent || questionMark != null) {
      map['question_mark'] = Variable<bool>(questionMark);
    }
    if (!nullToAbsent || starMark != null) {
      map['star_mark'] = Variable<bool>(starMark);
    }
    if (!nullToAbsent || pinMark != null) {
      map['pin_mark'] = Variable<bool>(pinMark);
    }
    if (!nullToAbsent || addedMark != null) {
      map['added_mark'] = Variable<bool>(addedMark);
    }
    return map;
  }

  UserVocabSqliteTableCompanion toCompanion(bool nullToAbsent) {
    return UserVocabSqliteTableCompanion(
      vocabId: vocabId == null && nullToAbsent
          ? const Value.absent()
          : Value(vocabId),
      nthWord: nthWord == null && nullToAbsent
          ? const Value.absent()
          : Value(nthWord),
      nthAppear: nthAppear == null && nullToAbsent
          ? const Value.absent()
          : Value(nthAppear),
      markColors: markColors == null && nullToAbsent
          ? const Value.absent()
          : Value(markColors),
      editedMeaning: editedMeaning == null && nullToAbsent
          ? const Value.absent()
          : Value(editedMeaning),
      bookMarked: bookMarked == null && nullToAbsent
          ? const Value.absent()
          : Value(bookMarked),
      questionMark: questionMark == null && nullToAbsent
          ? const Value.absent()
          : Value(questionMark),
      starMark: starMark == null && nullToAbsent
          ? const Value.absent()
          : Value(starMark),
      pinMark: pinMark == null && nullToAbsent
          ? const Value.absent()
          : Value(pinMark),
      addedMark: addedMark == null && nullToAbsent
          ? const Value.absent()
          : Value(addedMark),
    );
  }

  factory UserVocabSqliteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserVocabSqliteTableData(
      vocabId: serializer.fromJson<String>(json['vocabId']),
      nthWord: serializer.fromJson<int>(json['nthWord']),
      nthAppear: serializer.fromJson<int>(json['nthAppear']),
      markColors: serializer.fromJson<List<MarkColorModel>>(json['markColors']),
      editedMeaning: serializer.fromJson<String>(json['editedMeaning']),
      bookMarked: serializer.fromJson<bool>(json['bookMarked']),
      questionMark: serializer.fromJson<bool>(json['questionMark']),
      starMark: serializer.fromJson<bool>(json['starMark']),
      pinMark: serializer.fromJson<bool>(json['pinMark']),
      addedMark: serializer.fromJson<bool>(json['addedMark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vocabId': serializer.toJson<String>(vocabId),
      'nthWord': serializer.toJson<int>(nthWord),
      'nthAppear': serializer.toJson<int>(nthAppear),
      'markColors': serializer.toJson<List<MarkColorModel>>(markColors),
      'editedMeaning': serializer.toJson<String>(editedMeaning),
      'bookMarked': serializer.toJson<bool>(bookMarked),
      'questionMark': serializer.toJson<bool>(questionMark),
      'starMark': serializer.toJson<bool>(starMark),
      'pinMark': serializer.toJson<bool>(pinMark),
      'addedMark': serializer.toJson<bool>(addedMark),
    };
  }

  UserVocabSqliteTableData copyWith(
          {String vocabId,
          int nthWord,
          int nthAppear,
          List<MarkColorModel> markColors,
          String editedMeaning,
          bool bookMarked,
          bool questionMark,
          bool starMark,
          bool pinMark,
          bool addedMark}) =>
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
          ..write('addedMark: $addedMark')
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
                                  $mrjc(pinMark.hashCode,
                                      addedMark.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
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
          other.addedMark == this.addedMark);
}

class UserVocabSqliteTableCompanion
    extends UpdateCompanion<UserVocabSqliteTableData> {
  final Value<String> vocabId;
  final Value<int> nthWord;
  final Value<int> nthAppear;
  final Value<List<MarkColorModel>> markColors;
  final Value<String> editedMeaning;
  final Value<bool> bookMarked;
  final Value<bool> questionMark;
  final Value<bool> starMark;
  final Value<bool> pinMark;
  final Value<bool> addedMark;
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
  });
  UserVocabSqliteTableCompanion.insert({
    @required String vocabId,
    this.nthWord = const Value.absent(),
    this.nthAppear = const Value.absent(),
    this.markColors = const Value.absent(),
    this.editedMeaning = const Value.absent(),
    this.bookMarked = const Value.absent(),
    this.questionMark = const Value.absent(),
    this.starMark = const Value.absent(),
    this.pinMark = const Value.absent(),
    this.addedMark = const Value.absent(),
  }) : vocabId = Value(vocabId);
  static Insertable<UserVocabSqliteTableData> custom({
    Expression<String> vocabId,
    Expression<int> nthWord,
    Expression<int> nthAppear,
    Expression<String> markColors,
    Expression<String> editedMeaning,
    Expression<bool> bookMarked,
    Expression<bool> questionMark,
    Expression<bool> starMark,
    Expression<bool> pinMark,
    Expression<bool> addedMark,
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
    });
  }

  UserVocabSqliteTableCompanion copyWith(
      {Value<String> vocabId,
      Value<int> nthWord,
      Value<int> nthAppear,
      Value<List<MarkColorModel>> markColors,
      Value<String> editedMeaning,
      Value<bool> bookMarked,
      Value<bool> questionMark,
      Value<bool> starMark,
      Value<bool> pinMark,
      Value<bool> addedMark}) {
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
          Variable<String>(converter.mapToSql(markColors.value));
    }
    if (editedMeaning.present) {
      map['edited_meaning'] = Variable<String>(editedMeaning.value);
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
          ..write('addedMark: $addedMark')
          ..write(')'))
        .toString();
  }
}

class $UserVocabSqliteTableTable extends UserVocabSqliteTable
    with TableInfo<$UserVocabSqliteTableTable, UserVocabSqliteTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserVocabSqliteTableTable(this._db, [this._alias]);
  final VerificationMeta _vocabIdMeta = const VerificationMeta('vocabId');
  GeneratedTextColumn _vocabId;
  @override
  GeneratedTextColumn get vocabId => _vocabId ??= _constructVocabId();
  GeneratedTextColumn _constructVocabId() {
    return GeneratedTextColumn(
      'vocab_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nthWordMeta = const VerificationMeta('nthWord');
  GeneratedIntColumn _nthWord;
  @override
  GeneratedIntColumn get nthWord => _nthWord ??= _constructNthWord();
  GeneratedIntColumn _constructNthWord() {
    return GeneratedIntColumn('nth_word', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _nthAppearMeta = const VerificationMeta('nthAppear');
  GeneratedIntColumn _nthAppear;
  @override
  GeneratedIntColumn get nthAppear => _nthAppear ??= _constructNthAppear();
  GeneratedIntColumn _constructNthAppear() {
    return GeneratedIntColumn('nth_appear', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _markColorsMeta = const VerificationMeta('markColors');
  GeneratedTextColumn _markColors;
  @override
  GeneratedTextColumn get markColors => _markColors ??= _constructMarkColors();
  GeneratedTextColumn _constructMarkColors() {
    return GeneratedTextColumn(
      'mark_colors',
      $tableName,
      true,
    );
  }

  final VerificationMeta _editedMeaningMeta =
      const VerificationMeta('editedMeaning');
  GeneratedTextColumn _editedMeaning;
  @override
  GeneratedTextColumn get editedMeaning =>
      _editedMeaning ??= _constructEditedMeaning();
  GeneratedTextColumn _constructEditedMeaning() {
    return GeneratedTextColumn(
      'edited_meaning',
      $tableName,
      true,
    );
  }

  final VerificationMeta _bookMarkedMeta = const VerificationMeta('bookMarked');
  GeneratedBoolColumn _bookMarked;
  @override
  GeneratedBoolColumn get bookMarked => _bookMarked ??= _constructBookMarked();
  GeneratedBoolColumn _constructBookMarked() {
    return GeneratedBoolColumn('book_marked', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _questionMarkMeta =
      const VerificationMeta('questionMark');
  GeneratedBoolColumn _questionMark;
  @override
  GeneratedBoolColumn get questionMark =>
      _questionMark ??= _constructQuestionMark();
  GeneratedBoolColumn _constructQuestionMark() {
    return GeneratedBoolColumn('question_mark', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _starMarkMeta = const VerificationMeta('starMark');
  GeneratedBoolColumn _starMark;
  @override
  GeneratedBoolColumn get starMark => _starMark ??= _constructStarMark();
  GeneratedBoolColumn _constructStarMark() {
    return GeneratedBoolColumn('star_mark', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _pinMarkMeta = const VerificationMeta('pinMark');
  GeneratedBoolColumn _pinMark;
  @override
  GeneratedBoolColumn get pinMark => _pinMark ??= _constructPinMark();
  GeneratedBoolColumn _constructPinMark() {
    return GeneratedBoolColumn('pin_mark', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _addedMarkMeta = const VerificationMeta('addedMark');
  GeneratedBoolColumn _addedMark;
  @override
  GeneratedBoolColumn get addedMark => _addedMark ??= _constructAddedMark();
  GeneratedBoolColumn _constructAddedMark() {
    return GeneratedBoolColumn('added_mark', $tableName, false,
        defaultValue: Constant(false));
  }

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
        addedMark
      ];
  @override
  $UserVocabSqliteTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user_vocab_sqlite_table';
  @override
  final String actualTableName = 'user_vocab_sqlite_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserVocabSqliteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vocab_id')) {
      context.handle(_vocabIdMeta,
          vocabId.isAcceptableOrUnknown(data['vocab_id'], _vocabIdMeta));
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    if (data.containsKey('nth_word')) {
      context.handle(_nthWordMeta,
          nthWord.isAcceptableOrUnknown(data['nth_word'], _nthWordMeta));
    }
    if (data.containsKey('nth_appear')) {
      context.handle(_nthAppearMeta,
          nthAppear.isAcceptableOrUnknown(data['nth_appear'], _nthAppearMeta));
    }
    context.handle(_markColorsMeta, const VerificationResult.success());
    if (data.containsKey('edited_meaning')) {
      context.handle(
          _editedMeaningMeta,
          editedMeaning.isAcceptableOrUnknown(
              data['edited_meaning'], _editedMeaningMeta));
    }
    if (data.containsKey('book_marked')) {
      context.handle(
          _bookMarkedMeta,
          bookMarked.isAcceptableOrUnknown(
              data['book_marked'], _bookMarkedMeta));
    }
    if (data.containsKey('question_mark')) {
      context.handle(
          _questionMarkMeta,
          questionMark.isAcceptableOrUnknown(
              data['question_mark'], _questionMarkMeta));
    }
    if (data.containsKey('star_mark')) {
      context.handle(_starMarkMeta,
          starMark.isAcceptableOrUnknown(data['star_mark'], _starMarkMeta));
    }
    if (data.containsKey('pin_mark')) {
      context.handle(_pinMarkMeta,
          pinMark.isAcceptableOrUnknown(data['pin_mark'], _pinMarkMeta));
    }
    if (data.containsKey('added_mark')) {
      context.handle(_addedMarkMeta,
          addedMark.isAcceptableOrUnknown(data['added_mark'], _addedMarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vocabId};
  @override
  UserVocabSqliteTableData map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserVocabSqliteTableData.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  $UserVocabSqliteTableTable createAlias(String alias) {
    return $UserVocabSqliteTableTable(_db, alias);
  }

  static TypeConverter<List<MarkColorModel>, String> $converter0 =
      const MarkColorModelListConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $VocabSqliteTableTable _vocabSqliteTable;
  $VocabSqliteTableTable get vocabSqliteTable =>
      _vocabSqliteTable ??= $VocabSqliteTableTable(this);
  $UserVocabSqliteTableTable _userVocabSqliteTable;
  $UserVocabSqliteTableTable get userVocabSqliteTable =>
      _userVocabSqliteTable ??= $UserVocabSqliteTableTable(this);
  VocabSqliteDao _vocabSqliteDao;
  VocabSqliteDao get vocabSqliteDao =>
      _vocabSqliteDao ??= VocabSqliteDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [vocabSqliteTable, userVocabSqliteTable];
}
