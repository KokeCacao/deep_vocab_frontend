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
  String id;

  // above are fetched from database
  int edition;
  int listId;
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
  bool expoMark = false;

  VocabModel({
    @required this.id,
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
    this.nthWord,
    this.nthAppear,
    this.markColors,
    this.editedMeaning,
    this.bookMarked,
    this.questionMark,
    this.starMark,
    this.expoMark,
  });

  factory VocabModel.fromJson(Map<String, dynamic> json) => _$VocabModelFromJson(json);
  Map<String, dynamic> toJson() => _$VocabModelToJson(this);
  factory VocabModel.fromJsonString(String s) => VocabModel.fromJson(json.decode(s));
  String toJsonString() => json.encode(toJson());

  factory VocabModel.fromSqlite(VocabSqliteTableData vocab, UserVocabSqliteTableData user) {
    assert(vocab.id == vocab.userVocabSqliteTableId); // TODO: enforce such constraint
    assert(vocab.userVocabSqliteTableId == user.id);
    return VocabModel(
      // TODO: check nullable
      id: vocab.id,
      edition: vocab.edition,
      listId: vocab.listId,
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
      nthWord: user.nthWord,
      nthAppear: user.nthAppear,
      markColors: user.markColors,
      editedMeaning: user.editedMeaning,
      bookMarked: user.bookMarked,
      questionMark: user.questionMark,
      starMark: user.starMark,
      expoMark: user.expoMark,
    );
  }

  factory VocabModel.fromCombinedSqlite(VocabSqliteTableDataWithUserVocabSqliteTableData data) {
    return VocabModel.fromSqlite(data.vocabSqliteTableData, data.userVocabSqliteTableData);
  }
  VocabSqliteTableDataWithUserVocabSqliteTableData toCombinedSqlite() {
    return VocabSqliteTableDataWithUserVocabSqliteTableData(
        vocabSqliteTableData: VocabSqliteTableData(
          id: this.id,
          edition: this.edition,
          listId: this.listId,
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
          userVocabSqliteTableId: this.id,
        ),
        userVocabSqliteTableData: UserVocabSqliteTableData(
          id: this.id,
          nthWord: this.nthWord,
          nthAppear: this.nthAppear,
          markColors: this.markColors,
          editedMeaning: this.editedMeaning,
          bookMarked: this.bookMarked,
          questionMark: this.questionMark,
          starMark: this.starMark,
          expoMark: this.expoMark,
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
