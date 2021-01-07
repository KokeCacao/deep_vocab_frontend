import 'package:deep_vocab/utils/hive_box.dart';
import 'package:deep_vocab/utils/http_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';

class AuthViewModel extends ChangeNotifier {
  final boxUuidKey = HiveBox.USER_SINGLETON_UUID;
  final boxAccessTokenKey = HiveBox.USER_SINGLETON_ACCESS_TOKEN;
  final boxRefreshTokenKey = HiveBox.USER_SINGLETON_REFRESH_TOKEN;
  final boxWxTokenKey = HiveBox.USER_SINGLETON_WX_TOKEN;

  String _uuid;
  String _accessToken;
  String _refreshToken;
  String _wxToken = "NOT IMPLEMENTED"; // TODO: un-initialize it and implement it. change updateAccessTokenIfNull() as needed

  Box<dynamic> _box;

  AuthViewModel({@required Box<dynamic> box}) {
    _box = box;
    _uuid = _box.get(boxUuidKey, defaultValue: null);
    _accessToken = _box.get(boxAccessTokenKey, defaultValue: null);
    _refreshToken = _box.get(boxRefreshTokenKey, defaultValue: null);
    _wxToken = _box.get(boxWxTokenKey, defaultValue: null);

    _updateAccessTokenIfRefreshTokenExists();
  }

  bool loggedIn() {
    return _accessToken != null;
  }

  void _updateAccessTokenIfRefreshTokenExists() async {
    if (_uuid != null && _refreshToken != null) {
      print("[AuthViewModel] detected refresh token, trying to login using that");
      Map<String, dynamic> map = await _refreshAccessTokenOrNull(_uuid, _refreshToken);

      if (map["errorMessage"] != null) print("[AuthViewModel] refresh error: ${map["errorMessage"]}");
      else _updateWith(accessToken: map["accessToken"]);
    } else {
      print("[AuthViewModel] there is no refresh token or uuid");
    }
  }

  Future<String> loginWithUsername(String userName, String password) async {
    assert(userName != null && password != null);
    print("[AuthViewModel] try login with userName=${userName} and password=${password}");
    if (_uuid != null) return Future.value("[Warning] You have already logged in");
    Map<String, dynamic> map = await _loginOrNull(userName, password);

    if (map["errorMessage"] != null) return Future.value(map["errorMessage"]); // finished-error
    _updateWith(uuid: map["uuid"], accessToken: map["accessToken"], refreshToken: map["refreshToken"]);
    return Future.value(); // finished-success
  }

  void logout() {
    _accessToken = null;
    _box.delete(boxAccessTokenKey);
    _uuid = null;
    _box.delete(boxUuidKey);
    _refreshToken = null;
    _box.delete(boxRefreshTokenKey);
    _wxToken = null;
    _box.delete(boxWxTokenKey);
    notifyListeners();
  }

  Future<String> createUser(String userName, String password, String email) async {
    assert(userName != null && password != null && email != null);
    print("[AuthViewModel] create user with userName=${userName}, password=${password}, and email=${email}");
    if (_uuid != null) return Future.value("[Warning] You have already logged in");
    Map<String, dynamic> map = await _createAccountOrNull(userName, password, email);

    if (map["errorMessage"] != null) return Future.value(map["errorMessage"]); // finished-error
    _updateWith(uuid: map["uuid"], accessToken: map["accessToken"], refreshToken: map["refreshToken"]);
    return Future.value(); // finished-success
  }

  // TODO: implement login with email, ect

  Future<Map<String, dynamic>> _createAccountOrNull(String userName,
      String password, String email) async {
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

  Future<Map<String, dynamic>> _loginOrNull(String userName,
      String password) async {
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

  Future<Map<String, dynamic>> _refreshAccessTokenOrNull(String uuid,
      String refreshToken) async {
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

  void _updateWith({String accessToken, String refreshToken, String wxToken, String uuid}) {
    if (accessToken != null) {
      print("[Box] put ${accessToken}");
      _box.put(boxAccessTokenKey, accessToken);
      _accessToken = accessToken;
    }
    if (refreshToken != null) {
      print("[Box] put ${refreshToken}");
      _box.put(boxRefreshTokenKey, refreshToken);
      _refreshToken = refreshToken;
    }
    if (wxToken != null) {
      print("[Box] put ${wxToken}");
      _box.put(boxWxTokenKey, wxToken);
      _wxToken = wxToken;
    }
    if (uuid != null) {
      print("[Box] put ${uuid}");
      _box.put(boxUuidKey, uuid);
      _uuid = uuid;
    }
    notifyListeners();
  }
}