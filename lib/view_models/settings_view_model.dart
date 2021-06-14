import '/models/hive_models/settings_model.dart';
import '/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';

class SettingsViewModel extends ChangeNotifier {
  /// storage
  final BuildContext context;

  /// store value
  SettingsModel? _settingsModel;

  SettingsViewModel({required this.context});

  /// getters
  get settingsModel {
    return _settingsModel;
  }


  /// interface
}
