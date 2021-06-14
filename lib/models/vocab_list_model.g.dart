// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabListModel _$VocabListModelFromJson(Map<String, dynamic> json) {
  return VocabListModel(
    header: json['header'] == null
        ? null
        : VocabHeaderModel.fromJson(json['header'] as Map<String, dynamic>),
    vocabs: (json['vocabs'] as List<dynamic>?)
        ?.map((e) => VocabModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$VocabListModelToJson(VocabListModel instance) =>
    <String, dynamic>{
      'header': instance.header,
      'vocabs': instance.vocabs,
    };
