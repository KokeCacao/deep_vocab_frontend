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

const _$ColorModelEnumMap = {
  ColorModel.black: 'black',
  ColorModel.red: 'red',
  ColorModel.yellow: 'yellow',
  ColorModel.green: 'green',
};
