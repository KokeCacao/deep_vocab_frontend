// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabListModel _$VocabListModelFromJson(Map<String, dynamic> json) {
  return VocabListModel(
    name: json['name'] as String,
    id: json['id'] as int,
    edition: json['edition'] == null
        ? null
        : DateTime.parse(json['edition'] as String),
    vocabs: (json['vocabs'] as List)
        ?.map((e) =>
            e == null ? null : VocabModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VocabListModelToJson(VocabListModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'edition': instance.edition?.toIso8601String(),
      'vocabs': instance.vocabs,
    };
