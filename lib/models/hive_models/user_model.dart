import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

// for detail, see tutorial: https://medium.com/flutter-community/storing-local-data-with-hive-and-provider-in-flutter-a49b6bdea75a
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

  // TODO: use @JsonSerializable() instead
  @Deprecated("use @JsonSerializable() instead")
  factory UserModel.fromJson(json) {
    dynamic user = json['user'];
    return UserModel(
        uuid: user['uuid'],
        userName: user['userName'],
        avatarUrl: user['avatarUrl'],
        level: user['level'] as int,
        xp: user['xp'] as int);
  }
}