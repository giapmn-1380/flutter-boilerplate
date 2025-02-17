// import 'dart:async';
import 'dart:io';

import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioClientProvider = Provider((ref) => _buildClient(ref));

Dio _buildClient(Ref ref) {
  const Duration timeOutMilliSecond = Duration(milliseconds: 60000);
  // Timer? timer;

  final dio = Dio(
    BaseOptions(
      baseUrl: Constants.shared().baseUrl,
      headers: <String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      connectTimeout: timeOutMilliSecond,
      sendTimeout: timeOutMilliSecond,
      receiveTimeout: timeOutMilliSecond,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TO DO
        // Apply basic authentication
        // final basicAuth = "Basic ${EnvKey.appBasicAuthentication.read()}";

        // options.headers.addAll({
        //   "id-token": userToken,
        //   "Authorization": basicAuth,
        // });

        return handler.next(options);
      },
    ),
  );
  ref.onDispose(dio.close);
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: false,
        enabled: kDebugMode,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );
  }
  return dio;
}
