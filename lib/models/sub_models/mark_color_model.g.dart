// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_color_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkColorModel _$MarkColorModelFromJson(Map<String, dynamic> json) {
  return MarkColorModel(
    color: _$enumDecodeNullable(_$ColorModelEnumMap, json['color']),
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$MarkColorModelToJson(MarkColorModel instance) =>
    <String, dynamic>{
      'color': _$ColorModelEnumMap[instance.color],
      'time': instance.time?.toIso8601String(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ColorModelEnumMap = {
  ColorModel.black: 'black',
  ColorModel.red: 'red',
  ColorModel.yellow: 'yellow',
  ColorModel.green: 'green',
};
