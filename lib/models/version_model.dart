import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'version_model.g.dart';

@JsonSerializable()
class VersionModel {
  String? latestVersion;
  int? latestBuildNumber;
  DateTime? latestDate;
  List<String>? changeLogs;
  bool? shouldUpdate;
  bool? breaking;

  VersionModel(this.latestVersion, this.latestBuildNumber, this.latestDate,
      this.changeLogs, this.shouldUpdate, this.breaking);

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);
  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
  factory VersionModel.fromJsonString(String s) =>
      VersionModel.fromJson(json.decode(s));
  String toJsonString() => json.encode(toJson());
}
