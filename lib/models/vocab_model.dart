import 'dart:convert';

import 'package:deep_vocab/models/sub_models/comment_model.dart';
import 'package:deep_vocab/models/sub_models/mark_color_model.dart';
import 'package:deep_vocab/models/sqlite_models/app_database.dart';
import 'package:deep_vocab/models/sqlite_models/vocab_sqlite_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vocab_model.g.dart';

@JsonSerializable()
class VocabModel {
  String vocabId;

  // above are fetched from database
  DateTime edition;
  List<int> listIds;
  String vocab;
  VocabType type;
  String mainTranslation;
  List<String> otherTranslation;
  String mainSound;
  List<String> otherSound;
  String englishTranslation;
  List<CommentModel> comments;
  List<String> confusingWordId;
  String memTips;
  List<String> exampleSentences;

  // below are user defined and need to be saved
  int nthWord = 0;
  int nthAppear = 0;
  List<MarkColorModel> markColors = [];
  String editedMeaning;
  bool bookMarked = false;
  bool questionMark = false;
  bool starMark = false;
  bool pinMark = false;
  bool addedMark = false;
  bool pushedMark = false;

  VocabModel({
    @required this.vocabId,
    @required this.edition,
    @required this.listIds,
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
    this.nthWord = 0,
    this.nthAppear = 0,
    this.markColors,
    this.editedMeaning,
    this.bookMarked = false,
    this.questionMark = false,
    this.starMark = false,
    this.pinMark = false,
    this.addedMark = false,
    this.pushedMark = false,
  });

  factory VocabModel.fromJson(Map<String, dynamic> json) => _$VocabModelFromJson(json);
  Map<String, dynamic> toJson() => _$VocabModelToJson(this);
  factory VocabModel.fromJsonString(String s) => VocabModel.fromJson(json.decode(s));
  String toJsonString() => json.encode(toJson());

  factory VocabModel.fromSqlite(VocabSqliteTableData vocab, UserVocabSqliteTableData userVocab) {
    assert(vocab.vocabId == vocab.userVocabSqliteTableVocabId); // TODO: enforce such constraint
    assert(vocab.userVocabSqliteTableVocabId == userVocab.vocabId);
    return VocabModel(
      // TODO: check nullable
      vocabId: vocab.vocabId,
      edition: vocab.edition,
      listIds: vocab.listIds,
      vocab: vocab.vocab,
      type: vocab.type,
      mainTranslation: vocab.mainTranslation,
      otherTranslation: vocab.otherTranslation,
      mainSound: vocab.mainSound,
      otherSound: vocab.otherSound,
      englishTranslation: vocab.englishTranslation,
      comments: vocab.comments,
      confusingWordId: vocab.confusingWordId,
      memTips: vocab.memTips,
      exampleSentences: vocab.exampleSentences,
      nthWord: userVocab.nthWord,
      nthAppear: userVocab.nthAppear,
      markColors: userVocab.markColors,
      editedMeaning: userVocab.editedMeaning,
      bookMarked: userVocab.bookMarked,
      questionMark: userVocab.questionMark,
      starMark: userVocab.starMark,
      pinMark: userVocab.pinMark,
      addedMark: userVocab.addedMark,
      pushedMark: userVocab.pushedMark,
    );
  }

  factory VocabModel.fromCombinedSqlite(VocabSqliteTableDataWithUserVocabSqliteTableData vocabWithUserVocab) {
    return VocabModel.fromSqlite(vocabWithUserVocab.vocabSqliteTableData, vocabWithUserVocab.userVocabSqliteTableData);
  }
  VocabSqliteTableDataWithUserVocabSqliteTableData toCombinedSqlite() {
    return VocabSqliteTableDataWithUserVocabSqliteTableData(
        vocabSqliteTableData: VocabSqliteTableData(
          vocabId: this.vocabId,
          edition: this.edition,
          listIds: this.listIds,
          vocab: this.vocab,
          type: this.type,
          mainTranslation: this.mainTranslation,
          otherTranslation: this.otherTranslation,
          mainSound: this.mainSound,
          otherSound: this.otherSound,
          englishTranslation: this.englishTranslation,
          comments: this.comments,
          confusingWordId: this.confusingWordId,
          memTips: this.memTips,
          exampleSentences: this.exampleSentences,
          userVocabSqliteTableVocabId: this.vocabId,
        ),
        userVocabSqliteTableData: UserVocabSqliteTableData(
          vocabId: this.vocabId,
          nthWord: this.nthWord,
          nthAppear: this.nthAppear,
          markColors: this.markColors,
          editedMeaning: this.editedMeaning,
          bookMarked: this.bookMarked,
          questionMark: this.questionMark,
          starMark: this.starMark,
          pinMark: this.pinMark,
          addedMark: this.addedMark,
          pushedMark: this.pushedMark,
        ));
  }
}

// IMPORTANT: this will be serialized to int when adding to database
// so only append type AFTER the values, not in the middle

enum VocabType {
  noun,
  adj,
  adv,
}
