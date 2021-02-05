import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

// for detail, see tutorial: https://medium.com/flutter-community/storing-local-data-with-hive-and-provider-in-flutter-a49b6bdea75a
@JsonSerializable()
@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final int xp;
  @HiveField(1)
  final int level;
  @HiveField(2)
  final String avatarUrl;
  @HiveField(3)
  final String userName;
  @HiveField(4)
  final String uuid;

  const UserModel({@required this.uuid, @required this.userName, @required this.avatarUrl, @required this.level, @required this.xp});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  factory UserModel.fromJsonString(String s) => UserModel.fromJson(json.decode(s));
  String toJsonString() => json.encode(toJson());

  // factory UserModel.fromJson(json) {
  //   dynamic user = json['user'];
  //   return UserModel(
  //       uuid: user['uuid'],
  //       userName: user['userName'],
  //       avatarUrl: user['avatarUrl'],
  //       level: user['level'] as int,
  //       xp: user['xp'] as int);
  // }
}
