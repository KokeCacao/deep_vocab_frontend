import 'package:deep_vocab/utils/hive_box.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';

class AuthViewModel extends ChangeNotifier {
  /// storage
  final BuildContext context;
  final Box<dynamic> _box;
  final boxUuidKey = HiveBox.USER_SINGLETON_UUID;
  final boxAccessTokenKey = HiveBox.USER_SINGLETON_ACCESS_TOKEN;
  final boxRefreshTokenKey = HiveBox.USER_SINGLETON_REFRESH_TOKEN;
  final boxWxTokenKey = HiveBox.USER_SINGLETON_WX_TOKEN; // TODO: un-initialize it and implement it. change updateAccessTokenIfNull() as needed

  /// store value

  /// @requires assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX));
  AuthViewModel({@required this.context})
      : assert(Hive.isBoxOpen(HiveBox.SINGLETON_BOX)),
        _box = HiveBox.getBox(HiveBox.SINGLETON_BOX) {
    updateAccessTokenHttp();
  }

  /// getters
  get isLoggedIn => accessToken != null;
  get isNotLoggedIn => accessToken == null;
  get box => _box;
  get uuid => box.get(boxUuidKey, defaultValue: null);
  get accessToken => box.get(boxAccessTokenKey, defaultValue: null);
  get refreshToken => box.get(boxRefreshTokenKey, defaultValue: null);
  get wxToken => box.get(boxWxTokenKey, defaultValue: null);

  /// interface
  Future<String> loginWithUsernameIfNeeded(String userName, String password) async {
    assert(userName != null && password != null);
    print("[AuthViewModel] try login with userName=${userName} and password=${password}");
    if (isLoggedIn) return Future.value("[Warning] You have already logged in");
    NetworkException exception = await _loginHttp(userName: userName, password: password);
    if (exception == null) return Future.value();
    return Future.value(exception.message);
  }

  void logout() {
    // TODO: clear database when logout
    _box.delete(boxAccessTokenKey);
    _box.delete(boxUuidKey);
    _box.delete(boxRefreshTokenKey);
    _box.delete(boxWxTokenKey);
    notifyListeners();
  }

  Future<String> createUser(String userName, String password, String email) async {
    assert(userName != null && password != null && email != null);
    print("[AuthViewModel] create user with userName=${userName}, password=${password}, and email=${email}");
    if (isLoggedIn) return Future.value("[Warning] You have already logged in");
    NetworkException exception = await _createAccountHttp(userName: userName, password: password, email: email);
    if (exception != null) return Future.value(exception.message);
    return Future.value();
  }

  Future<String> updateAccessTokenHttp() async {
    if (uuid == null || refreshToken == null) return Future.value("[AuthViewModel] there is no refresh token or uuid");
    print("[AuthViewModel] detected refresh token, trying to login using that");
    NetworkException exception = await _refreshAccessTokenHttp(uuid: uuid, refreshToken: refreshToken);
    if (exception != null) return Future.value(exception.message);
    return Future.value();
  }
  // TODO: implement login with email, ect

  /// internal functions
  Future<NetworkException> _createAccountHttp({@required String userName, @required String password, @required String email}) async {
    Map<String, dynamic> map = await HttpWidget.graphQLMutation(
        data: """
          mutation {
              createUser(userName: "$userName", password: "$password", email: "$email") {
                  uuid
                  accessToken
                  refreshToken
              }
          }
        """,
        queryName: "createUser",
        onSuccess: (Map<String, dynamic> response) => response,
        onFail: (String exception) => <String, dynamic>{"errorMessage": exception});
    if (map == null) return Future.value(NetworkException(message: "duplicated request"));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"]));

    await _updateWith(uuid: map["uuid"], accessToken: map["accessToken"], refreshToken: map["refreshToken"]);
    return Future.value();
  }

  Future<NetworkException> _loginHttp({@required String userName, @required String password}) async {
    Map<String, dynamic> map = await HttpWidget.graphQLMutation(
        data: """
          mutation {
              auth(userName: "$userName", password: "$password") {
                  uuid
                  accessToken
                  refreshToken
              }
          }
        """,
        queryName: "auth",
        onSuccess: (Map<String, dynamic> response) => response,
        onFail: (String exception) => <String, dynamic>{"errorMessage": exception});
    if (map == null) return Future.value(NetworkException(message: "duplicated request"));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"]));

    await _updateWith(uuid: map["uuid"], accessToken: map["accessToken"], refreshToken: map["refreshToken"]);
    return Future.value();
  }

  Future<NetworkException> _refreshAccessTokenHttp({@required String uuid, @required String refreshToken}) async {
    Map<String, dynamic> map = await HttpWidget.graphQLMutation(
        data: """
          mutation {
              refresh(uuid: "$uuid", refreshToken: "$refreshToken") {
                  accessToken
              }
          }
        """,
        queryName: "refresh",
        onSuccess: (Map<String, dynamic> response) => response,
        onFail: (String exception) => <String, dynamic>{"errorMessage": exception});
    if (map == null) return Future.value(NetworkException(message: "duplicated request"));
    if (map.containsKey("errorMessage")) return Future.value(NetworkException(message: map["errorMessage"]));

    await _updateWith(accessToken: map["accessToken"]);
    return Future.value();
  }

  Future<void> _updateWith({String accessToken, String refreshToken, String wxToken, String uuid}) async {
    if (accessToken != null) {
      await _box.put(boxAccessTokenKey, accessToken);
      print("[Box] put ${accessToken}");
    }
    if (refreshToken != null) {
      await _box.put(boxRefreshTokenKey, refreshToken);
      print("[Box] put ${refreshToken}");
    }
    if (wxToken != null) {
      await _box.put(boxWxTokenKey, wxToken);
      print("[Box] put ${wxToken}");
    }
    if (uuid != null) {
      await _box.put(boxUuidKey, uuid);
      print("[Box] put ${uuid}");
    }
    notifyListeners();
    return Future.value();
  }
}
