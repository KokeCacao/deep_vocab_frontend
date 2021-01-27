import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class SettingsModel {
  @HiveField(0)
  final bool darkMode;
  @HiveField(1)
  final bool wifiDownload;
  @HiveField(2)
  final String language;
  @HiveField(3)
  final int fontSize;
  @HiveField(4)
  final String font;
  @HiveField(5)
  final bool devMode;
  @HiveField(6)
  final bool soundOff;

  const SettingsModel(
      {this.darkMode = false,
      this.wifiDownload = false,
      this.language = "zh/CN",
      this.fontSize = -1,
      this.font = "",
      this.devMode = false,
      this.soundOff = false});
}
