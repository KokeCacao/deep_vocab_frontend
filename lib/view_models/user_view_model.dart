import 'package:deep_vocab/models/hive_models/user_model.dart';
import 'package:deep_vocab/utils/hive_box.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';

class UserViewModel extends ChangeNotifier {
  /// storage
  final BuildContext context;
  final Box<dynamic> _box;
  final boxKey = HiveBox.USER_SINGLETON_INDEX;

  /// store value
  UserModel _userModel; // TODO: integrate displayName

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  UserViewModel({@required this.context})
      : assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX)),
        _box = HiveBox.getBox(HiveBox.SINGLETON_BOX) {
    _userModel = _box.get(boxKey, defaultValue: null);
  }

  /// getters
  get userModel {
    updateIfNeeded(); // who ever uses userModel must come from consumer, therefore will automatically notify them if needed
    return _userModel;
  }

  // TODO: fix a serious bug: when login with new account, Box is not updated, user info is still shows old one
  /// interface
  void updateIfNeeded() async {
    if (_userModel != null) return; // already fetched
    String refreshToken = HiveBox.get(HiveBox.SINGLETON_BOX, HiveBox.USER_SINGLETON_REFRESH_TOKEN);
    if (refreshToken == null) return; // user not logged in

    String uuid = HiveBox.get(HiveBox.SINGLETON_BOX, HiveBox.USER_SINGLETON_UUID);
    if (uuid != null) {
      UserModel userModel = await _fetchUserOrNull(uuid);
      if (userModel != null) _updateWith(userModel);
    } else {
      // waiting for auth to log in
      print("[UserViewModel] update unsuccessful, waiting 5 seconds");
      await Future.delayed(Duration(seconds: 5));
      updateIfNeeded();
    }
  }

  /// internal functions
  Future<UserModel> _fetchUserOrNull(String uuid) async {
    UserModel model;
    await HttpWidget.postWithGraphQL(
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
        onSuccess: (QueryResult response) {
          if (response.data["user"] == null) {
            throw NetworkException(message: "[AuthViewModel] null return.");
          }
          model = UserModel.fromJson(response.data);
        });
    return Future<UserModel>.value(model);
  }

  void _updateWith(UserModel userModel) {
    _box.put(boxKey, userModel);

    _userModel = userModel;
    print("[UserViewModel] updated ${_userModel.userName} as my username");
    notifyListeners();
  }
}
