import 'dart:convert';

import 'package:deep_vocab/models/hive_models/vocab_header_model.dart';
import 'package:deep_vocab/utils/file_manager.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vocab_list_model.g.dart';

@JsonSerializable()
class VocabListModel {
  VocabHeaderModel header;
  List<VocabModel> vocabs;

  /// if vocabHeaderModel is null, VocabListModel represent random collection of vocab
  /// if vocabHeaderModel is not null, VocabListModel represent a full list of vocab, e.g. Barron3500
  VocabListModel({this.header, @required this.vocabs});

  factory VocabListModel.fromJson(Map<String, dynamic> json) => _$VocabListModelFromJson(json);
  Map<String, dynamic> toJson() => _$VocabListModelToJson(this);
  factory VocabListModel.fromJsonString(String s) => VocabListModel.fromJson(json.decode(s));
  String toJsonString() => json.encode(toJson());

  static Future<VocabListModel> fromFilePath(String path) async {
    return Future.value(VocabListModel.fromJson(await FileManager.filePathToJson(path)));
  }
}
