import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum AppErrorType {
  network,
  badRequest,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
  common
}

class AppError {
  late int statusCode;
  late String message;
  late AppErrorType type;

  factory AppError.newInstance(AppErrorType type) {
    return AppError.m(type);
  }

  factory AppError.newInstanceWithMessage(AppErrorType type, String message) {
    return AppError.n(type, message);
  }

  factory AppError.newInstanceWithMessageAndStatusCode(
      AppErrorType type, String message, int? statusCode) {
    return AppError.u(type, message, statusCode ?? 0);
  }

  AppError.m(this.type);

  AppError.n(this.type, this.message);

  AppError.u(this.type, this.message, this.statusCode);

  AppError(Exception? error) {
    if (error is DioException) {
      debugPrint('AppError(DioError): '
          'type is ${error.type}, message is ${error.message}');
      try {
        statusCode = error.response?.statusCode ?? 0;
        message = error.response?.data['detail'];
      } catch (e) {
        statusCode = 0;
        message = error.message ?? "";
      }

      switch (error.type) {
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            // SocketException: Failed host lookup: '***'
            // (OS Error: No address associated with hostname, err no = 7)
            type = AppErrorType.network;
          } else {
            type = AppErrorType.unknown;
          }
          break;
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          type = AppErrorType.timeout;
          break;
        case DioExceptionType.sendTimeout:
          type = AppErrorType.network;
          break;
        case DioExceptionType.badResponse:
          // TODO(api): need define more http status;
          switch (error.response?.statusCode) {
            case HttpStatus.badRequest: // 400
              type = AppErrorType.badRequest;
              break;
            case HttpStatus.unauthorized: // 401
              type = AppErrorType.unauthorized;
              break;
            case HttpStatus.internalServerError: // 500
            case HttpStatus.badGateway: // 502
            case HttpStatus.serviceUnavailable: // 503
            case HttpStatus.gatewayTimeout: // 504
              type = AppErrorType.server;
              break;
            default:
              type = AppErrorType.unknown;
              break;
          }
          break;
        case DioExceptionType.cancel:
          type = AppErrorType.cancel;
          break;
        default:
          type = AppErrorType.unknown;
      }
    } else {
      debugPrint('AppError(UnKnown): $error');
      type = AppErrorType.unknown;
      statusCode = 0;
      message = 'AppError: $error';
    }
  }
}
