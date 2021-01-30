// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabModel _$VocabModelFromJson(Map<String, dynamic> json) {
  return VocabModel(
    vocabId: json['vocabId'] as String,
    edition: json['edition'] == null
        ? null
        : DateTime.parse(json['edition'] as String),
    listIds: (json['listIds'] as List)?.map((e) => e as int)?.toList(),
    vocab: json['vocab'] as String,
    type: _$enumDecodeNullable(_$VocabTypeEnumMap, json['type']),
    mainTranslation: json['mainTranslation'] as String,
    otherTranslation:
        (json['otherTranslation'] as List)?.map((e) => e as String)?.toList(),
    mainSound: json['mainSound'] as String,
    otherSound: (json['otherSound'] as List)?.map((e) => e as String)?.toList(),
    englishTranslation: json['englishTranslation'] as String,
    comments: (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : CommentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    confusingWords:
        (json['confusingWords'] as List)?.map((e) => e as String)?.toList(),
    memTips: json['memTips'] as String,
    exampleSentences:
        (json['exampleSentences'] as List)?.map((e) => e as String)?.toList(),
    nthWord: json['nthWord'] as int,
    nthAppear: json['nthAppear'] as int,
    markColors: (json['markColors'] as List)
        ?.map((e) => e == null
            ? null
            : MarkColorModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    editedMeaning: json['editedMeaning'] as String,
    bookMarked: json['bookMarked'] as bool,
    questionMark: json['questionMark'] as bool,
    starMark: json['starMark'] as bool,
    pinMark: json['pinMark'] as bool,
    addedMark: json['addedMark'] as bool,
    pushedMark: json['pushedMark'] as bool,
  );
}

Map<String, dynamic> _$VocabModelToJson(VocabModel instance) =>
    <String, dynamic>{
      'vocabId': instance.vocabId,
      'edition': instance.edition?.toIso8601String(),
      'listIds': instance.listIds,
      'vocab': instance.vocab,
      'type': _$VocabTypeEnumMap[instance.type],
      'mainTranslation': instance.mainTranslation,
      'otherTranslation': instance.otherTranslation,
      'mainSound': instance.mainSound,
      'otherSound': instance.otherSound,
      'englishTranslation': instance.englishTranslation,
      'comments': instance.comments,
      'confusingWords': instance.confusingWords,
      'memTips': instance.memTips,
      'exampleSentences': instance.exampleSentences,
      'nthWord': instance.nthWord,
      'nthAppear': instance.nthAppear,
      'markColors': instance.markColors,
      'editedMeaning': instance.editedMeaning,
      'bookMarked': instance.bookMarked,
      'questionMark': instance.questionMark,
      'starMark': instance.starMark,
      'pinMark': instance.pinMark,
      'addedMark': instance.addedMark,
      'pushedMark': instance.pushedMark,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$VocabTypeEnumMap = {
  VocabType.noun: 'noun',
  VocabType.adj: 'adj',
  VocabType.adv: 'adv',
};
