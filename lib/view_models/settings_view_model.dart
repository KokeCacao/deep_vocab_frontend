import 'package:deep_vocab/models/hive_models/settings_model.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';

class SettingsViewModel extends ChangeNotifier {
  /// storage
  final BuildContext context;

  /// store value
  SettingsModel _settingsModel;

  SettingsViewModel({@required this.context});

  /// getters
  get settingsModel {
    return _settingsModel;
  }


  /// interface
  // TODO
  @Deprecated("TODO")
  fetch() {
    Map<String, dynamic> map = {
      "query": "hi",
      "wowo": "mom",
    };

    HttpWidget.post(
        path: "/graphql",
        data: map,
        protocol: "POST",
        onSuccess: (response) {
          _settingsModel = SettingsModel();
          notifyListeners();
        },
        onFail: (response) {
          print("[SettingsViewModel] Fetching Failed");
        },
        onFinished: (response) {
        });
  }
}
