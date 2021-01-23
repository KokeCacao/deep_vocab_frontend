import 'package:hive/hive.dart';

part 'user_model.g.dart';

// for detail, see tutorial: https://medium.com/flutter-community/storing-local-data-with-hive-and-provider-in-flutter-a49b6bdea75a
@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  int xp;
  @HiveField(1)
  int level;
  @HiveField(2)
  String avatarUrl;
  @HiveField(3)
  String userName;
  @HiveField(4)
  String uuid;

  UserModel({this.uuid, this.userName, this.avatarUrl, this.level, this.xp});

  static UserModel fromJson(json) {
    dynamic user = json['user'];
    return UserModel(
        uuid: user['uuid'],
        userName: user['userName'],
        avatarUrl: user['avatarUrl'],
        level: user['level'] as int,
        xp: user['xp'] as int);
  }
}
