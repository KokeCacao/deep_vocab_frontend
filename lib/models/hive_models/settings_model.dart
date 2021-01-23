import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class SettingsModel {
  @HiveField(0)
  bool darkMode = false;
  @HiveField(1)
  bool wifiDownload = false;
  @HiveField(2)
  String language = "zh/CN";
  @HiveField(3)
  int fontSize = -1;
  @HiveField(4)
  String font = "";
  @HiveField(5)
  bool devMode = false;
  @HiveField(6)
  bool soundOff = false;

  SettingsModel({this.darkMode, this.wifiDownload, this.language, this.fontSize, this.font, this.devMode, this.soundOff});
}