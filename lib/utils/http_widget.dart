import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:graphql/client.dart' hide BaseOptions;
import 'package:dio/dio.dart';
import 'hive_box.dart';

class HttpWidget extends Object {
  static Dio _dio;
  static GraphQLClient _graphQLClient;

  static Dio get dio {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
          connectTimeout: 10000,
          receiveTimeout: 10000,
          sendTimeout: 10000,
          baseUrl:
              "http://10.0.2.2:5000", // TODO: baseUrl, 10.0.2.2 for android emulator, see https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
          responseType: ResponseType.json));
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

  static Future<void> postWithGraphQL({
    String data,
    void Function(QueryResult response) onSuccess,
    void Function(String errorMessage) onFail,
    void Function(QueryResult response) onFinished,
  }) {
    String hash = md5.convert(utf8.encode(data)).toString();
    FutureOr<dynamic> processResponse(QueryResult response) {
      HiveBox.deleteFrom(HiveBox.REQUEST_BOX, hash);

      if (response.hasException && onFail != null) {
        if (response.exception.graphqlErrors.length > 0)
        onFail(response.exception.graphqlErrors[0].message); // suit response
        else onFail(response.exception.toString());
      }
      if (!response.hasException && onSuccess != null) onSuccess(response);
      if (onFinished != null) onFinished(response);

      print("[HTTP] Response data=${response.data}; error=${response.exception.toString()};");
    }
    if (HiveBox.containKey(HiveBox.REQUEST_BOX, hash)) {
      print("[DEBUG] duplicate request detected: ${data}");
      return null;
    }
    HiveBox.put(HiveBox.REQUEST_BOX, hash, data);
    return graphQLClient
        .query(QueryOptions(
          documentNode: gql(data),
        ))
        .then(processResponse);
  }

  static Future<void> post({
    String path,
    String protocol,
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    void Function(dynamic response) onSuccess,
    void Function(dynamic response) onFail,
    void Function(dynamic response) onFinished,
  }) {
    void processResponse(dynamic response) {
      switch (response.statusCode) {
        case 200:
          {
            if (onSuccess != null) onSuccess(response);
            break;
          }
        default: // fail
          if (onFail != null) onFail(response);
          break;
      }
      if (onFinished != null) onFinished(response);
    }

    switch (protocol) {
      case "GET":
        assert(data == null);
        dio
            .get(path,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken,
                onReceiveProgress: onReceiveProgress)
            .then(processResponse);
        break;
      case "POST":
        assert(data != null);
        dio
            .post(path,
                data: data,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken,
                onReceiveProgress: onReceiveProgress)
            .then(processResponse);
        break;
      default:
        throw new Exception("The protocol ${protocol} is not supported.");
        break;
    }

    return Future.value();
  }
}
