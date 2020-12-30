import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class HttpWidget extends Object {
//  Future<Widget> getOnlineImage(String url) async {
//
//  }
  static Dio _dio;

  static Dio get dio {
    if (_dio == null) createDio();
    return _dio;
  }

  static void createDio() {
    // the library we are using
    _dio = Dio(BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
        baseUrl: "http://10.0.2.2:5000", // TODO: baseUrl, 10.0.2.2 for android emulator, see https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
        responseType: ResponseType.json));
  }

  static Future<void> post({
    String path,
    String protocol,
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    void Function(Response<Map> response) onSuccess,
    void Function(Response<Map> response) onFail,
    void Function(Response<Map> response) onFinished,
  }) {
    FutureOr<dynamic> processResponse(response) {
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

  static Future<void> fakeGet({
    String path,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    void Function(dynamic response) onSuccess,
    void Function(dynamic response) onFail,
    void Function(dynamic response) onFinished,
  }) {
    final Response response =
        Response(data: "", headers: null, statusCode: 200); // for testing
    Future.delayed(Duration(seconds: 1)).then((_) {
      switch (response.statusCode) {
        case 200:
          {
            if (onSuccess != null) onSuccess(response);
            break;
          }
        default:
          if (onFail != null) onFail(response);
          throw new Exception("This should not be allowed in fakeGet since the point of fakeGet is to generate successful responses.");
          break;
      }
      if (onFinished != null) onFinished(response);
    });
    return Future.value();
  }
}
