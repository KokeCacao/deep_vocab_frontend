// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_header_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabHeaderModelAdapter extends TypeAdapter<VocabHeaderModel> {
  @override
  final int typeId = 2;

  @override
  VocabHeaderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabHeaderModel(
      name: fields[0] as String,
      listId: fields[1] as int,
      edition: fields[2] as DateTime,
      vocabIds: (fields[3] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, VocabHeaderModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.listId)
      ..writeByte(2)
      ..write(obj.edition)
      ..writeByte(3)
      ..write(obj.vocabIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabHeaderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabHeaderModel _$VocabHeaderModelFromJson(Map<String, dynamic> json) {
  return VocabHeaderModel(
    name: json['name'] as String,
    listId: json['listId'] as int,
    edition: json['edition'] == null
        ? null
        : DateTime.parse(json['edition'] as String),
    vocabIds: (json['vocabIds'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$VocabHeaderModelToJson(VocabHeaderModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'listId': instance.listId,
      'edition': instance.edition?.toIso8601String(),
      'vocabIds': instance.vocabIds,
    };
