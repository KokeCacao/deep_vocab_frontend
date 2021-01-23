// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 1;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      darkMode: fields[0] as bool,
      wifiDownload: fields[1] as bool,
      language: fields[2] as String,
      fontSize: fields[3] as int,
      font: fields[4] as String,
      devMode: fields[5] as bool,
      soundOff: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.darkMode)
      ..writeByte(1)
      ..write(obj.wifiDownload)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.fontSize)
      ..writeByte(4)
      ..write(obj.font)
      ..writeByte(5)
      ..write(obj.devMode)
      ..writeByte(6)
      ..write(obj.soundOff);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
