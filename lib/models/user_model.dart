import 'package:hive/hive.dart';

part 'user_model.g.dart';

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
}