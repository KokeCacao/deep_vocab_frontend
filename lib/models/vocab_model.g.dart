// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabModel _$VocabModelFromJson(Map<String, dynamic> json) {
  return VocabModel(
    id: json['id'] as String,
    edition: json['edition'] as int,
    listId: json['listId'] as int,
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
    confusingWordId:
        (json['confusingWordId'] as List)?.map((e) => e as String)?.toList(),
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
    expoMark: json['expoMark'] as bool,
  );
}

Map<String, dynamic> _$VocabModelToJson(VocabModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'edition': instance.edition,
      'listId': instance.listId,
      'vocab': instance.vocab,
      'type': _$VocabTypeEnumMap[instance.type],
      'mainTranslation': instance.mainTranslation,
      'otherTranslation': instance.otherTranslation,
      'mainSound': instance.mainSound,
      'otherSound': instance.otherSound,
      'englishTranslation': instance.englishTranslation,
      'comments': instance.comments,
      'confusingWordId': instance.confusingWordId,
      'memTips': instance.memTips,
      'exampleSentences': instance.exampleSentences,
      'nthWord': instance.nthWord,
      'nthAppear': instance.nthAppear,
      'markColors': instance.markColors,
      'editedMeaning': instance.editedMeaning,
      'bookMarked': instance.bookMarked,
      'questionMark': instance.questionMark,
      'starMark': instance.starMark,
      'expoMark': instance.expoMark,
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
