import 'dart:io';

import 'package:dio/dio.dart';

enum AppErrorType {
  network,
  badRequest,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
}

class AppException implements Exception {
  const AppException({
    required this.type,
    this.message = '',
    this.statusCode,
  });

  final AppErrorType type;
  final String message;
  final int? statusCode;

  factory AppException.from(Object error) {
    if (error is AppException) return error;
    if (error is DioException) return AppException.fromDioException(error);
    return AppException(type: AppErrorType.unknown, message: error.toString());
  }

  factory AppException.fromDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = _extractMessage(error);

    switch (error.type) {
      case DioExceptionType.connectionError:
        return AppException(type: AppErrorType.network, message: message);
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(type: AppErrorType.timeout, message: message);
      case DioExceptionType.cancel:
        return AppException(type: AppErrorType.cancel, message: message);
      case DioExceptionType.badResponse:
        return AppException(
          type: _typeFromStatusCode(statusCode),
          message: message,
          statusCode: statusCode,
        );
      case DioExceptionType.unknown:
      default:
        return AppException(
          type: error.error is SocketException
              ? AppErrorType.network
              : AppErrorType.unknown,
          message: message,
        );
    }
  }

  static AppErrorType _typeFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest: // 400
        return AppErrorType.badRequest;
      case HttpStatus.unauthorized: // 401
      case HttpStatus.forbidden: // 403
        return AppErrorType.unauthorized;
      case HttpStatus.internalServerError: // 500
      case HttpStatus.badGateway: // 502
      case HttpStatus.serviceUnavailable: // 503
      case HttpStatus.gatewayTimeout: // 504
        return AppErrorType.server;
      default:
        return AppErrorType.unknown;
    }
  }

  static String _extractMessage(DioException error) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final detail = data['detail'] ?? data['message'];
      if (detail is String && detail.isNotEmpty) return detail;
    }
    return error.message ?? '';
  }

  @override
  String toString() =>
      'AppException(type: $type, statusCode: $statusCode, message: $message)';
}
