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
    updateAccessTokenIfRefreshTokenExists();
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
    Map<String, dynamic> map = await _loginOrNull(userName, password);

    if (map["errorMessage"] != null) return Future.value(map["errorMessage"]); // finished-error
    await _updateWith(uuid: map["uuid"], accessToken: map["accessToken"], refreshToken: map["refreshToken"]);
    return Future.value(); // finished-success
  }

  void logout() {
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
    Map<String, dynamic> map = await _createAccountOrNull(userName, password, email);

    if (map["errorMessage"] != null) return Future.value(map["errorMessage"]); // finished-error
    await _updateWith(uuid: map["uuid"], accessToken: map["accessToken"], refreshToken: map["refreshToken"]);
    return Future.value(); // finished-success
  }

  Future<bool> updateAccessTokenIfRefreshTokenExists() async {
    if (uuid != null && refreshToken != null) {
      print("[AuthViewModel] detected refresh token, trying to login using that");
      Map<String, dynamic> map = await _refreshAccessTokenOrNull(uuid, refreshToken);

      if (map["errorMessage"] != null) {
        print("[AuthViewModel] refresh error: ${map["errorMessage"]}");
        return Future.value(false);
      }
      else {
        await _updateWith(accessToken: map["accessToken"]);
        return Future.value(true);
      }
    } else {
      print("[AuthViewModel] there is no refresh token or uuid");
      return Future.value(false);
    }
  }
  // TODO: implement login with email, ect

  /// internal functions
  Future<Map<String, dynamic>> _createAccountOrNull(String userName, String password, String email) async {
    assert(userName != null && password != null && email != null);
    String accessToken;
    String refreshToken;
    String uuid;
    String errorMessage;
    await HttpWidget.postWithGraphQL(
        data: """
          mutation {
              createUser(userName: "$userName", password: "$password", email: "$email") {
                  uuid
                  accessToken
                  refreshToken
              }
          }
        """,
        onSuccess: (QueryResult response) {
          if (response.data["createUser"] == null) {
            throw NetworkException(message: "[AuthViewModel] null return.");
          }
          accessToken = response.data["createUser"]["accessToken"];
          refreshToken = response.data["createUser"]["refreshToken"];
          uuid = response.data["createUser"]["uuid"];
        },
        onFail: (String e) {
          errorMessage = e;
        },
        onFinished: (QueryResult response) {});
    return Future<Map<String, dynamic>>.value({
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "uuid": uuid,
      "errorMessage": errorMessage,
    });
  }

  Future<Map<String, dynamic>> _loginOrNull(String userName, String password) async {
    assert(userName != null && password != null);
    String accessToken;
    String refreshToken;
    String uuid;
    String errorMessage;
    await HttpWidget.postWithGraphQL(
        data: """
          mutation {
              auth(userName: "$userName", password: "$password") {
                  uuid
                  accessToken
                  refreshToken
              }
          }
        """,
        onSuccess: (QueryResult response) {
          if (response.data["auth"] == null) {
            throw NetworkException(message: "[AuthViewModel] null return.");
          }
          accessToken = response.data["auth"]["accessToken"];
          refreshToken = response.data["auth"]["refreshToken"];
          uuid = response.data["auth"]["uuid"];
        },
        onFail: (String e) {
          errorMessage = e;
        },
        onFinished: (QueryResult response) {});
    return Future<Map<String, dynamic>>.value({
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "uuid": uuid,
      "errorMessage": errorMessage,
    });
  }

  Future<Map<String, dynamic>> _refreshAccessTokenOrNull(String uuid, String refreshToken) async {
    assert(uuid != null && refreshToken != null);
    String accessToken;
    String errorMessage;
    await HttpWidget.postWithGraphQL(
        data: """
          mutation {
              refresh(uuid: "$uuid", refreshToken: "$refreshToken") {
                  accessToken
              }
          }
        """,
        onSuccess: (QueryResult response) {
          if (response.data["refresh"] == null) {
            throw NetworkException(message: "[AuthViewModel] null return.");
          }
          accessToken = response.data["refresh"]["accessToken"];
        },
        onFail: (String e) {
          errorMessage = e;
        },
        onFinished: (QueryResult response) {});
    return Future<Map<String, dynamic>>.value({"accessToken": accessToken, "errorMessage": errorMessage});
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
