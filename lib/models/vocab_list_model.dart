import 'dart:convert';

import 'package:deep_vocab/utils/file_manager.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vocab_list_model.g.dart';

@JsonSerializable()
class VocabListModel {
  String name;
  int id;
  DateTime edition;
  List<VocabModel> vocabs;

  VocabListModel({@required this.name, @required this.id, @required this.edition, @required this.vocabs});

  factory VocabListModel.fromJson(Map<String, dynamic> json) => _$VocabListModelFromJson(json);
  Map<String, dynamic> toJson() => _$VocabListModelToJson(this);
  factory VocabListModel.fromJsonString(String s) => VocabListModel.fromJson(json.decode(s));
  String toJsonString() => json.encode(toJson());

  static Future<VocabListModel> fromFilePath(String path) async {
    return Future.value(VocabListModel.fromJson(await FileManager.filePathToJson(path)));
  }
}
