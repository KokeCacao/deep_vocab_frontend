import 'package:f_logs/f_logs.dart';

import '../models/hive_models/user_model.dart';
import '../utils/hive_box.dart';
import '../utils/http_widget.dart';
import './auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class UserViewModel extends ChangeNotifier {
  /// storage
  final BuildContext context;
  final Box<dynamic> _box;
  final boxKey = HiveBox.USER_SINGLETON_INDEX;

  /// tracking if widget is disposed already
  /// Used to remove issue: Unhandled Exception: A UserViewModel was used after being disposed.
  /// Once you have called dispose() on a UserViewModel, it can no longer be used.
  bool _disposed = false;
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  UserViewModel({required this.context, required connectionStatus})
      : assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX)),
        _box = HiveBox.getBox(HiveBox.SINGLETON_BOX) {
    if (connectionStatus != ConnectionState.waiting) update();
  }

  /// getters
  get userModel => _box.get(boxKey, defaultValue: null);

  Future<void> setUserModel(UserModel? userModel) async {
    await _box.put(boxKey, userModel);
    notifyListeners();
    return Future.value();
  }

  /// interface
  Future<bool> update() async {
    // somehow get uuid
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (authViewModel.uuid == null) {
      await setUserModel(null);
      FLog.warning(text: "[UserViewModel] user not logged in, setUserModel to null");
      return Future.value(false);
    }
    NetworkException? exception = await _updateUser(uuid: authViewModel.uuid);
    if (exception != null) {
      FLog.error(text: "[UserViewModel] Exception: $exception");
      return Future.value(false);
    }
    FLog.info(text: "[UserViewModel] updated ${userModel.userName} as my username");
    return Future.value(true);
  }

  /// internal functions
  Future<NetworkException?> _updateUser({required String? uuid}) async {
    Map<String, dynamic>? map = await HttpWidget.graphQLMutation(
      context: context,
        data: """
          query {
              user(uuid: "$uuid") {
                  uuid
                  userName
                  avatarUrl
                  level
                  xp
              }
          }
        """,
        queryName: "user",
        onSuccess: (Map<String, dynamic>? response) => response,
        onFail: (String exception) => <String, dynamic>{"errorMessage": exception});
    if (map == null) return Future.value(NetworkException(message: "duplicated request", uri: null));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"], uri: null));

    await setUserModel(UserModel.fromJson(map));
    return Future.value();
  }
}
