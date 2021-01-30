import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vocab_header_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class VocabHeaderModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int listId;
  @HiveField(2)
  final DateTime edition;
  @HiveField(3)
  final List<String> vocabIds;

  const VocabHeaderModel({@required this.name, @required this.listId, @required this.edition, @required this.vocabIds});

  factory VocabHeaderModel.fromJson(Map<String, dynamic> json) => _$VocabHeaderModelFromJson(json);
  Map<String, dynamic> toJson() => _$VocabHeaderModelToJson(this);
  factory VocabHeaderModel.fromJsonString(String s) => VocabHeaderModel.fromJson(json.decode(s));
  String toJsonString() => json.encode(toJson());
}
