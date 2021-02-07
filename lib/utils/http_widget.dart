import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:deep_vocab/utils/file_manager.dart';
import 'package:deep_vocab/view_models/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart' hide BaseOptions;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'hive_box.dart';

class HttpWidget extends Object {
  static Dio _dio;
  static GraphQLClient _graphQLClient;
  static const String BASE_URL =
      "http://10.0.2.2:5000"; // TODO: baseUrl, 10.0.2.2 for android emulator, see https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan

  static Dio get dio {
    if (_dio == null) {
      // TODO: somehow downloading takes a lot of connectTimeout
      _dio = Dio(BaseOptions(connectTimeout: 100000, receiveTimeout: 100000, sendTimeout: 100000, baseUrl: BASE_URL, responseType: ResponseType.json));
    }
    return _dio;
  }

  static GraphQLClient get graphQLClient {
    if (_graphQLClient == null) {
      _graphQLClient = GraphQLClient(
          cache: InMemoryCache(),
          link: HttpLink(
            uri: 'http://10.0.2.2:5000/graphql',
          ),
          defaultPolicies: DefaultPolicies(
              watchQuery: Policies.safe(
                FetchPolicy.networkOnly, // so that no cache is saved
                ErrorPolicy.all, // so that all error present
              ),
              query: Policies.safe(
                FetchPolicy.networkOnly,
                ErrorPolicy.all,
              ),
              mutate: Policies.safe(
                FetchPolicy.networkOnly,
                ErrorPolicy.all,
              )));
    }
    return _graphQLClient;
  }

  // see: https://stackoverflow.com/questions/60761984/flutter-how-to-download-video-and-save-them-to-internal-storage
  static Future<String> secureDownloadFile({@required BuildContext context, @required int listId, @required String from, @required String to, @required void Function(int count, int total) onReceiveProgress, bool autoRefreshToken=true}) async {
    /// return null if there is an error
    /// return path to file if success
    var appDocDir = await getApplicationDocumentsDirectory();
    try {
      print("[HttpWidget] Start downloading to ${appDocDir.path} with ");
      AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      Response response = await dio.download("${BASE_URL}/secure_download/${authViewModel.accessToken}/${authViewModel.uuid}/${listId}/${from}", "${appDocDir.path}/${to}", onReceiveProgress: (int count, int total) {
        print("[HttpWidget] ${count} / ${total} = ${((count / total) * 100).toStringAsFixed(0) + "%"}");
        if (onReceiveProgress != null) onReceiveProgress(count, total);
      });
    } catch (e) {
      // TODO: smarter way to check 401 code
      if (e.toString().contains("[401]")) {
        AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);
        String error = await authViewModel.updateAccessTokenHttp();
        if (error == null) {
          print("[HttpWidget] Successfully updated access token, resend request");
          return secureDownloadFile(context: context, listId: listId, from: from, to: to, onReceiveProgress: onReceiveProgress, autoRefreshToken: false);
        } else {
          print("[HttpWidget] Try to refresh access token failed");
          return Future.value();
        }
      }
      print(e);
      return Future.value(null);
    }
    print("[HttpWidget] Download completed.");
    FileManager.printDir(appDocDir);
    return Future.value("${appDocDir.path}/${to}");
  }


  /// onSuccess inputs with a map of the requested argument
  /// onFail inputs with error message
  /// if onFail, onSuccess are defined, graphQLMutation() returns what those function returns
  /// if onFail, onSuccess are both undefined, graphQLMutation() returns variable, s.t. variable["data"] may result an error
  static Future<Map<String, dynamic>> graphQLMutation(
      {@required BuildContext context,
        @required String data,
      @required String queryName,
      Map<String, dynamic> Function(Map<String, dynamic> response) onSuccess,
      Map<String, dynamic> Function(String errorMessage) onFail, bool autoRefreshToken = true}) async {
    String hash = md5.convert(utf8.encode(data)).toString();

    // don't send another request if there is one processing
    if (HiveBox.containKey(HiveBox.REQUEST_BOX, hash)) {
      print("[HttpWidget] duplicate request detected: ${data}");
      return Future.value();
    }

    // send request
    HiveBox.put(HiveBox.REQUEST_BOX, hash, data);
    QueryResult response = await graphQLClient.query(QueryOptions(documentNode: gql(data)));
    HiveBox.deleteFrom(HiveBox.REQUEST_BOX, hash);

    // process request
    Map<String, dynamic> result = response.data;
    if (response.hasException) {
      String exception = response.exception.graphqlErrors.length > 0 ? response.exception.graphqlErrors[0].message : response.exception.toString();
      print("[HttpWidget] Exception: ${exception.replaceAll("\n", "; ")}");
      // refresh access token if query unsuccessful because of expiration of access token
      if (autoRefreshToken && exception.contains("JWT")) { // TODO: use actual error number to determine
        AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);
        String oldToken = authViewModel.accessToken;
        String error = await authViewModel.updateAccessTokenHttp();
        if (error == null) {
          print("[HttpWidget] Successfully updated access token, resend request");
          data = data.replaceFirst(oldToken, authViewModel.accessToken); // Warning: assume only 1 accessToken provided
          return graphQLMutation(
              context: context,
              data: data,
              queryName: queryName,
              onSuccess: onSuccess,
              onFail: onFail, autoRefreshToken: false);
        } else {
          print("[HttpWidget] Try to refresh access token failed");
          if (onFail != null) result = onFail(exception);
        }
      } else {
        if (onFail != null) result = onFail(exception);
      }
    } else {
      if (response.data[queryName] == null) {
        if (onFail != null) result = onFail("[HttpWidget] Null Return");
      } else if (onSuccess != null) result = onSuccess(result[queryName]);
    }
    print("[HttpWidget] Response data=${response.data}; error=${response.exception.toString()};");
    return Future.value(result);
  }
}
