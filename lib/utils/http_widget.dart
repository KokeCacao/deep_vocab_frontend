import 'dart:async';
import 'dart:convert';
import 'dart:io';

import './file_manager.dart';
import '../view_models/auth_view_model.dart';

import 'package:crypto/crypto.dart';
import 'package:f_logs/f_logs.dart';
import 'package:dio/dio.dart' hide MultipartFile;
import 'package:http/http.dart' show MultipartFile;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart' hide Response;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'hive_box.dart';

class HttpWidget extends Object {
  static Dio? _dio;
  static GraphQLClient? _graphQLClient;
  static const String BASE_URL =
      "https://deepvocab.kokecacao.me";
  // static const String BASE_URL =
  //     "http://10.0.2.2:5000"; // TODO: baseUrl, 10.0.2.2 for android emulator, see https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan

  static Dio? get dio {
    if (_dio == null) {
      // TODO: somehow downloading takes a lot of connectTimeout
      _dio = Dio(BaseOptions(
          connectTimeout: 100000,
          receiveTimeout: 100000,
          sendTimeout: 100000,
          baseUrl: BASE_URL,
          responseType: ResponseType.json));
    }
    return _dio;
  }

  static GraphQLClient? get graphQLClient {
    if (_graphQLClient == null) {
      _graphQLClient = GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink(BASE_URL + '/graphql'),
          defaultPolicies: DefaultPolicies(
              watchQuery: Policies.safe(
                FetchPolicy.networkOnly, // so that no cache is saved
                ErrorPolicy.all, // so that all error present
                CacheRereadPolicy
                    .ignoreAll, // TODO: not sure what exactly this will do, but it seems like it will obtain original behavior before upgrade
              ),
              query: Policies.safe(
                FetchPolicy.networkOnly,
                ErrorPolicy.all,
                CacheRereadPolicy.ignoreAll,
              ),
              mutate: Policies.safe(
                FetchPolicy.networkOnly,
                ErrorPolicy.all,
                CacheRereadPolicy.ignoreAll,
              )));
    }
    return _graphQLClient;
  }

  // see: https://stackoverflow.com/questions/60761984/flutter-how-to-download-video-and-save-them-to-internal-storage
  static Future<String?> secureDownloadFile(
      {required BuildContext context,
      required int listId,
      required String from,
      required String to,
      required void Function(int count, int total)? onReceiveProgress,
      bool autoRefreshToken = true}) async {
    /// return null if there is an error
    /// return path to file if success
    var appDocDir = await getApplicationDocumentsDirectory();
    try {
      FLog.info(
          text: "[HttpWidget] Start downloading to ${appDocDir.path} with ");
      AuthViewModel authViewModel =
          Provider.of<AuthViewModel>(context, listen: false);
      Response response = await dio!.download(
          "$BASE_URL/secure_download/${authViewModel.accessToken}/${authViewModel.uuid}/$listId/$from",
          "${appDocDir.path}/$to", onReceiveProgress: (int count, int total) {
        FLog.info(
            text:
                "[HttpWidget] $count / $total = ${((count / total) * 100).toStringAsFixed(0) + "%"}");
        if (onReceiveProgress != null) onReceiveProgress(count, total);
      });
      if (response.statusCode != 200)
        FLog.error(
            text:
                "[HttpWidget] downloading to ${appDocDir.path} failed with status code ${response.statusCode} : ${response.statusMessage}");
    } catch (e) {
      // TODO: smarter way to check 401 code
      if (e.toString().contains("[401]")) {
        AuthViewModel authViewModel =
            Provider.of<AuthViewModel>(context, listen: false);
        String? error = await authViewModel.updateAccessTokenHttp();
        if (error == null) {
          FLog.info(
              text:
                  "[HttpWidget] Successfully updated access token, resend request");
          return secureDownloadFile(
              context: context,
              listId: listId,
              from: from,
              to: to,
              onReceiveProgress: onReceiveProgress,
              autoRefreshToken: false);
        } else {
          FLog.warning(text: "[HttpWidget] Try to refresh access token failed");
          return Future.value();
        }
      }
      FLog.error(text: "[HttpWidget] $e");
      return Future.value(null);
    }
    FLog.info(text: "[HttpWidget] Download completed.");
    FileManager.printDir(appDocDir);
    return Future.value("${appDocDir.path}/$to");
  }

  static Future<Map<String, dynamic>?> graphQLQuery(
      {required BuildContext context,
        required String queryString,
        required String operation,
        required String queryName,
        required Map<String, dynamic> variables,
        required Map<String, dynamic>? Function() onDuplicate,
        required Map<String, dynamic>? Function(
            String errorMessage, Map<String, dynamic>? response)
        onFail,
        Map<String, dynamic>? Function(Map<String, dynamic> response)? onSuccess,
        bool autoRefreshToken = true}) async {
    QueryOptions options = QueryOptions(
        document: gql(queryString),
        operationName: operation,
        variables: variables);

    int hash = options.asRequest.hashCode;

    // don't send another request if there is one processing
    if (HiveBox.containKey(HiveBox.REQUEST_BOX, hash)) {
      FLog.warning(text: "[HttpWidget] duplicate request detected: $hash");
      return onDuplicate();
    }

    // send request
    HiveBox.put(HiveBox.REQUEST_BOX, hash, hash);
    QueryResult response = await graphQLClient!.query(options);
    HiveBox.deleteFrom(HiveBox.REQUEST_BOX, hash);

    FLog.info(
        text:
        "[HttpWidget] Response data=${response.data}; error=${response.exception.toString()};");

    // process request
    Map<String, dynamic>? result = response.data;
    if (result == null) {
      return onFail("[HttpWidget] Response has no data field", result);
    } else if (response.hasException || result.containsKey("errorMessage")) {
      String exception = response.exception!.graphqlErrors.length > 0
          ? response.exception!.graphqlErrors[0].message
          : response.exception.toString();
      if (result.containsKey("errorMessage"))
        exception += " " + result["errorMessage"];
      FLog.error(
          text: "[HttpWidget] Exception: ${exception.replaceAll("\n", "; ")}");
      return onFail(exception, result);
    } else {
      if (response.data![queryName] == null)
        return onFail(
            "[HttpWidget] Response has no corresponding field", result);
      else if (onSuccess != null)
        return onSuccess(result);
      else
        return Future.value(result[queryName]);
    }
  }

  static Future<Map<String, dynamic>?> graphQLMutation2(
      {required BuildContext context,
        required String queryString,
        required String operation,
        required String queryName,
        required Map<String, dynamic> variables,
        required Map<String, dynamic>? Function() onDuplicate,
        required Map<String, dynamic>? Function(
            String errorMessage, Map<String, dynamic>? response)
        onFail,
        Map<String, dynamic>? Function(Map<String, dynamic> response)? onSuccess,
        bool autoRefreshToken = true}) async {
    MutationOptions options = MutationOptions(
        document: gql(queryString),
        operationName: operation,
        variables: variables);

    int hash = options.asRequest.hashCode;

    // don't send another request if there is one processing
    if (HiveBox.containKey(HiveBox.REQUEST_BOX, hash)) {
      FLog.warning(text: "[HttpWidget] duplicate request detected: $hash");
      return onDuplicate();
    }

    // send request
    HiveBox.put(HiveBox.REQUEST_BOX, hash, hash);
    QueryResult response = await graphQLClient!.mutate(options);
    HiveBox.deleteFrom(HiveBox.REQUEST_BOX, hash);

    FLog.info(
        text:
        "[HttpWidget] Response data=${response.data}; error=${response.exception.toString()};");

    // process request
    Map<String, dynamic>? result = response.data;
    if (result == null) {
      return onFail("[HttpWidget] Response has no data field", result);
    } else if (response.hasException || result.containsKey("errorMessage")) {
      String exception = response.exception!.graphqlErrors.length > 0
          ? response.exception!.graphqlErrors[0].message
          : response.exception.toString();
      if (result.containsKey("errorMessage"))
        exception += " " + result["errorMessage"];
      FLog.error(
          text: "[HttpWidget] Exception: ${exception.replaceAll("\n", "; ")}");
      return onFail(exception, result);
    } else {
      if (result[queryName] == null)
        return onFail(
            "[HttpWidget] Response has no corresponding field", result);
      else if (onSuccess != null)
        return onSuccess(result);
      else
        return Future.value(result[queryName]);
    }
  }

  static Future<Map<String, dynamic>?> graphQLUploadMutation(
      {required BuildContext context,
      required File file,
      Map<String, dynamic>? Function(Map<String, dynamic>? response)? onSuccess,
      Map<String, dynamic> Function(String errorMessage)? onFail,
      bool autoRefreshToken = true}) async {
    AuthViewModel authViewModel =
        Provider.of<AuthViewModel>(context, listen: false);
    assert(authViewModel.isLoggedIn);

    MultipartFile multipartFile = MultipartFile.fromBytes(
      "file",
      file.readAsBytesSync(),
      filename: '${DateTime.now()}-${authViewModel.uuid}.txt',
      contentType: MediaType("text", "plain"),
    );

    const String uploadMutation = r'''
  mutation uploadMutation($uuid: UUID!, $accessToken: String!, $file: Upload!) {
    upload(uuid: $uuid, accessToken: $accessToken, file: $file) {
      ok
    }
  }
''';

    MutationOptions options = MutationOptions(
        document: gql(uploadMutation),
        operationName: "uploadMutation",
        variables: {
          "uuid": authViewModel.uuid,
          "accessToken": authViewModel.accessToken,
          "file": file.readAsStringSync(),
        });

    print("request string debug = ${options.asRequest.toString()}");
    int hash = options.asRequest.hashCode;

    // don't send another request if there is one processing
    if (HiveBox.containKey(HiveBox.REQUEST_BOX, hash)) {
      FLog.warning(text: "[HttpWidget] duplicate request detected: $hash");
      return Future.value();
    }

    // send request
    HiveBox.put(HiveBox.REQUEST_BOX, hash, hash);
    QueryResult response = await graphQLClient!.mutate(options);
    HiveBox.deleteFrom(HiveBox.REQUEST_BOX, hash);

    // process request
    Map<String, dynamic>? result = response.data;
    if (response.hasException) {
      String exception = response.exception!.graphqlErrors.length > 0
          ? response.exception!.graphqlErrors[0].message
          : response.exception.toString();
      FLog.error(
          text: "[HttpWidget] Exception: ${exception.replaceAll("\n", "; ")}");
      // refresh access token if query unsuccessful because of expiration of access token
      if (autoRefreshToken && exception.contains("JWT")) {
        // TODO: use actual error number to determine
        AuthViewModel authViewModel =
            Provider.of<AuthViewModel>(context, listen: false);
        String? error = await authViewModel.updateAccessTokenHttp();
        if (error == null) {
          FLog.info(
              text:
                  "[HttpWidget] Successfully updated access token, resend request");
          return graphQLUploadMutation(
              context: context,
              file: file,
              onSuccess: onSuccess,
              onFail: onFail,
              autoRefreshToken: false);
        } else {
          FLog.error(text: "[HttpWidget] Try to refresh access token failed");
          if (onFail != null) result = onFail(exception);
        }
      } else {
        if (onFail != null) result = onFail(exception);
      }
    } else {
      if (response.data!["upload"] == null) {
        if (onFail != null) result = onFail("[HttpWidget] Null Return");
      } else if (onSuccess != null) result = onSuccess(result!["upload"]);
    }
    FLog.info(
        text:
            "[HttpWidget] Response data=${response.data}; error=${response.exception.toString()};");
    return Future.value(result);
  }

  /// onSuccess inputs with a map of the requested argument
  /// onFail inputs with error message
  /// if onFail, onSuccess are defined, graphQLMutation() returns what those function returns
  /// if onFail, onSuccess are both undefined, graphQLMutation() returns variable, s.t. variable["data"] may result an error
  @Deprecated("use graphQLMutation2 instead")
  static Future<Map<String, dynamic>?> graphQLMutation(
      {required BuildContext context,
      required String data,
      required String queryName,
      Map<String, dynamic>? Function(Map<String, dynamic>? response)? onSuccess,
      Map<String, dynamic> Function(String errorMessage)? onFail,
      bool autoRefreshToken = true}) async {
    String hash = md5.convert(utf8.encode(data)).toString();

    // don't send another request if there is one processing
    if (HiveBox.containKey(HiveBox.REQUEST_BOX, hash)) {
      FLog.warning(text: "[HttpWidget] duplicate request detected: $data");
      return Future.value();
    }

    // send request
    HiveBox.put(HiveBox.REQUEST_BOX, hash, data);
    QueryResult response =
        await graphQLClient!.query(QueryOptions(document: gql(data)));
    HiveBox.deleteFrom(HiveBox.REQUEST_BOX, hash);

    // process request
    Map<String, dynamic>? result = response.data;
    if (response.hasException) {
      String exception = response.exception!.graphqlErrors.length > 0
          ? response.exception!.graphqlErrors[0].message
          : response.exception.toString();
      FLog.error(
          text: "[HttpWidget] Exception: ${exception.replaceAll("\n", "; ")}");
      // refresh access token if query unsuccessful because of expiration of access token
      if (autoRefreshToken && exception.contains("JWT")) {
        // TODO: use actual error number to determine
        AuthViewModel authViewModel =
            Provider.of<AuthViewModel>(context, listen: false);
        String? oldToken = authViewModel.accessToken;
        String? error = await authViewModel.updateAccessTokenHttp();
        if (error == null) {
          FLog.info(
              text:
                  "[HttpWidget] Successfully updated access token, resend request");
          data = data.replaceFirst(
              oldToken!,
              authViewModel
                  .accessToken); // Warning: assume only 1 accessToken provided
          return graphQLMutation(
              context: context,
              data: data,
              queryName: queryName,
              onSuccess: onSuccess,
              onFail: onFail,
              autoRefreshToken: false);
        } else {
          FLog.error(text: "[HttpWidget] Try to refresh access token failed");
          if (onFail != null) result = onFail(exception);
        }
      } else {
        if (onFail != null) result = onFail(exception);
      }
    } else {
      if (response.data![queryName] == null) {
        if (onFail != null) result = onFail("[HttpWidget] Null Return");
      } else if (onSuccess != null) result = onSuccess(result![queryName]);
    }
    FLog.info(
        text:
            "[HttpWidget] Response data=${response.data}; error=${response.exception.toString()};");
    return Future.value(result);
  }
}
