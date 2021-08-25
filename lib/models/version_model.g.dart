// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) {
  return VersionModel(
    json['latestVersion'] as String?,
    json['latestBuildNumber'] as int?,
    json['latestDate'] == null
        ? null
        : DateTime.parse(json['latestDate'] as String),
    (json['changeLogs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['shouldUpdate'] as bool?,
    json['breaking'] as bool?,
  );
}

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'latestVersion': instance.latestVersion,
      'latestBuildNumber': instance.latestBuildNumber,
      'latestDate': instance.latestDate?.toIso8601String(),
      'changeLogs': instance.changeLogs,
      'shouldUpdate': instance.shouldUpdate,
      'breaking': instance.breaking,
    };
