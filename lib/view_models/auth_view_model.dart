import 'package:f_logs/f_logs.dart' hide AppDatabase, Constants;
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../models/sqlite_models/app_database.dart';
import '../utils/hive_box.dart';
import '../utils/http_widget.dart';
import '../utils/constants.dart';

class AuthViewModel extends ChangeNotifier {
  /// storage
  final BuildContext context;
  final Box<dynamic> _box;
  final boxUuidKey = HiveBox.USER_SINGLETON_UUID;
  final boxAccessTokenKey = HiveBox.USER_SINGLETON_ACCESS_TOKEN;
  final boxRefreshTokenKey = HiveBox.USER_SINGLETON_REFRESH_TOKEN;
  final boxWxTokenKey = HiveBox
      .USER_SINGLETON_WX_TOKEN; // TODO: un-initialize it and implement it. change updateAccessTokenIfNull() as needed

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
  AuthViewModel({required this.context})
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
  Future<String?> loginWithUsernameIfNeeded(
      String? userName, String? password) async {
    assert(userName != null && password != null);
    FLog.info(
        text:
            "[AuthViewModel] try login with userName=$userName and password=$password");
    if (isLoggedIn) return Future.value("[Warning] You have already logged in");
    NetworkException? exception =
        await _loginHttp(userName: userName, password: password);
    if (exception == null) return Future.value();
    return Future.value(exception.message);
  }

  void logout() async {
    await HiveBox.clear();
    await Provider.of<AppDatabase>(context, listen: false).deleteEverything();
    notifyListeners();
  }

  Future<String?> requestEmailVerification(
      String userName, String password, String email) async {
    FLog.info(
        text:
            "[AuthViewModel] request email with userName=$userName, password=$password, and email=$email");
    if (isLoggedIn) return Future.value("[Warning] You have already logged in");

    Map<String, dynamic>? result = await HttpWidget.graphQLMutation2(
        context: context,
        queryString: Constants.REQUEST_EMAIL_VERIFICATION_MUTATION,
        operation: Constants.REQUEST_EMAIL_VERIFICATION_MUTATION_OPERATION,
        queryName: Constants.REQUEST_EMAIL_VERIFICATION_MUTATION_NAME,
        variables: {"userName": userName, "password": password, "email": email},
        onDuplicate: () => {
              "error":
                  "please wait for a few minutes before sending another request"
            },
        onFail: (error, map) => {"error": error});

    if (result!.containsKey("error")) return result["error"];
    return Future.value();
  }

  Future<String?> createUser(String userName, String password, String email,
      String emailVerification) async {
    FLog.info(
        text:
            "[AuthViewModel] create user with userName=$userName, password=$password, email=$email, and verification=$emailVerification");
    if (isLoggedIn) return Future.value("[Warning] You have already logged in");

    Map<String, dynamic>? result = await HttpWidget.graphQLMutation2(
        context: context,
        queryString: Constants.CREATE_USER_MUTATION,
        operation: Constants.CREATE_USER_MUTATION_OPERATION,
        queryName: Constants.CREATE_USER_MUTATION_NAME,
        variables: {
          "userName": userName,
          "password": password,
          "email": email,
          "emailVerification": emailVerification
        },
        onDuplicate: () => {
              "error":
                  "please wait for a few minutes before sending another request"
            },
        onFail: (error, map) => {"error": error});

    if (result!.containsKey("error"))
      return result["error"];
    else {
      await _updateWith(
          uuid: result["uuid"],
          accessToken: result["accessToken"],
          refreshToken: result["refreshToken"]);
      return Future.value();
    }
  }

  Future<String?> updateAccessTokenHttp() async {
    if (uuid == null || refreshToken == null)
      return Future.value("[AuthViewModel] there is no refresh token or uuid");
    FLog.info(
        text:
            "[AuthViewModel] detected refresh token, trying to login using that");
    NetworkException? exception =
        await _refreshAccessTokenHttp(uuid: uuid, refreshToken: refreshToken);
    if (exception != null) return Future.value(exception.message);
    return Future.value();
  }

  Future<NetworkException?> _loginHttp(
      {required String? userName, required String? password}) async {
    Map<String, dynamic>? map = await HttpWidget.graphQLMutation(
        context: context,
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
        onSuccess: (Map<String, dynamic>? response) => response,
        onFail: (String exception) =>
            <String, dynamic>{"errorMessage": exception});
    if (map == null)
      return Future.value(
          NetworkException(message: "duplicated request", uri: null));
    if (map.containsKey("errorMessage"))
      return Future.value(
          NetworkException(message: map["errorMessage"], uri: null));

    if (map["uuid"] != null &&
        map["accessToken"] != null &&
        map["refreshToken"] != null)
      await _updateWith(
          uuid: map["uuid"],
          accessToken: map["accessToken"],
          refreshToken: map["refreshToken"]);
    return Future.value();
  }

  Future<NetworkException?> _refreshAccessTokenHttp(
      {required String? uuid, required String? refreshToken}) async {
    Map<String, dynamic>? map = await HttpWidget.graphQLMutation(
        context: context,
        data: """
          mutation {
              refresh(uuid: "$uuid", refreshToken: "$refreshToken") {
                  accessToken
              }
          }
        """,
        queryName: "refresh",
        onSuccess: (Map<String, dynamic>? response) => response,
        onFail: (String exception) =>
            <String, dynamic>{"errorMessage": exception});
    if (map == null)
      return Future.value(
          NetworkException(message: "duplicated request", uri: null));
    if (map.containsKey("errorMessage"))
      return Future.value(
          NetworkException(message: map["errorMessage"], uri: null));

    await _updateWith(accessToken: map["accessToken"]);
    return Future.value();
  }

  Future<void> _updateWith(
      {String? accessToken,
      String? refreshToken,
      String? wxToken,
      String? uuid}) async {
    if (accessToken != null) {
      await _box.put(boxAccessTokenKey, accessToken);
      FLog.info(text: "[Box] put $accessToken");
    }
    if (refreshToken != null) {
      await _box.put(boxRefreshTokenKey, refreshToken);
      FLog.info(text: "[Box] put $refreshToken");
    }
    if (wxToken != null) {
      await _box.put(boxWxTokenKey, wxToken);
      FLog.info(text: "[Box] put $wxToken");
    }
    if (uuid != null) {
      await _box.put(boxUuidKey, uuid);
      FLog.info(text: "[Box] put $uuid");
    }
    notifyListeners();
    return Future.value();
  }
}
