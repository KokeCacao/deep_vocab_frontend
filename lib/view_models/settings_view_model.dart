import 'package:deep_vocab/models/settings_model.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';

class SettingsVideModel extends ChangeNotifier {
  SettingsModel _settingsModel;

  get settingsModel {
    return _settingsModel;
  }

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
