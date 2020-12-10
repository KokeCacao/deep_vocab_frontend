import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class HttpWidget extends Object {
//  Future<Widget> getOnlineImage(String url) async {
//
//  }
  static Dio _dio;

  static Dio get getDio {
    if (_dio == null) createDio();
    return _dio;
  }

  static void createDio() { // the library we are using
    _dio = Dio(BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
        baseUrl: "", // TODO: baseUrl
        responseType: ResponseType.json));
  }

  static Future<void> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    void Function(dynamic response) onSuccess,
    void Function(dynamic response) onFail,
    void Function(dynamic response) onFinished,
  }) {
    getDio
        .get(path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress)
        .then((response) {
      switch (response.statusCode) {
        case 200:
          {
            if (onSuccess != null) onSuccess(response);
            print("[DEBUG] internet connect successful");
            break;
          }
        default: // fail
          if (onFail != null) onFail(response);
          print("[DEBUG] internet connect failed");
          break;
      }
      if (onFinished != null) onFinished(response);
      print("[DEBUG] internet connect finished");
    });
    return Future.value();
  }

  static Future<void> fakeGet( // for testing purpose only
    String path, {
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
        default: // fail
          if (onFail != null) onFail(response);
          break;
      }
      if (onFinished != null) onFinished(response);
    });
    return Future.value();
  }
}
