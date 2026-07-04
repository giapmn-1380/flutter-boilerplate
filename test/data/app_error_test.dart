import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/data/app_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final requestOptions = RequestOptions(path: '/posts');

  group('AppException.fromDioException', () {
    test('connection timeout maps to timeout', () {
      final exception = AppException.fromDioException(
        DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(exception.type, AppErrorType.timeout);
    });

    test('SocketException maps to network', () {
      final exception = AppException.fromDioException(
        DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
          error: const SocketException('no address'),
        ),
      );

      expect(exception.type, AppErrorType.network);
    });

    test('500 response maps to server with status code', () {
      final exception = AppException.fromDioException(
        DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: requestOptions, statusCode: 500),
        ),
      );

      expect(exception.type, AppErrorType.server);
      expect(exception.statusCode, 500);
    });

    test('401 response maps to unauthorized', () {
      final exception = AppException.fromDioException(
        DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: requestOptions, statusCode: 401),
        ),
      );

      expect(exception.type, AppErrorType.unauthorized);
    });
  });

  group('AppException.from', () {
    test('returns the same instance for AppException', () {
      const original = AppException(type: AppErrorType.server);

      expect(AppException.from(original), same(original));
    });

    test('wraps unknown errors', () {
      final exception = AppException.from(const FormatException('bad json'));

      expect(exception.type, AppErrorType.unknown);
    });
  });
}
