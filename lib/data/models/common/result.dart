import 'package:ai_sales_manager_mobile/data/app_error.dart';
import 'package:ai_sales_manager_mobile/view_models/common/error_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success({required T data}) = Success<T>;

  const factory Result.failure({required AppError error}) = Failure<T>;

  static Result<T> guard<T>(T Function() body, [ErrorHandler? errorHandler]) {
    try {
      return Result.success(data: body());
    } on Exception catch (e) {
      final appError = AppError(e);
      // listen and handle the error for app
      if (errorHandler != null) {
        errorHandler.setError(appError);
      }
      debugPrint("Error API: $e");
      return Result.failure(error: appError);
    }
  }

  static Future<Result<T>> guardFuture<T>(
    Future<T> Function() future, [
    ErrorHandler? errorHandler,
  ]) async {
    try {
      return Result.success(data: await future());
    } on Exception catch (error, stackTrace) {
      final appError = AppError(error);
      if (errorHandler != null) {
        errorHandler.setError(appError);
      }
      debugPrint(
        "Error API: $error, StackTrace: $stackTrace",
      );
      return Result.failure(error: appError);
    }
  }

  bool get isSuccess => when(success: (data) => true, failure: (e) => false);

  bool get isFailure => !isSuccess;

  void ifSuccess(Function(T data) body) {
    maybeWhen(
      success: (data) => body(data),
      orElse: () {
        // no-op
      },
    );
  }

  void ifFailure(Function(AppError e) body) {
    maybeWhen(
      failure: (e) => body(e),
      orElse: () {
        // no-op
      },
    );
  }

  T get dataOrThrow {
    return when(
      success: (data) => data,
      failure: (e) => throw e,
    );
  }
}

extension ResultObjectExt<T> on T {
  Result<T> get asSuccess => Result.success(data: this);

  Result<T> asFailure(Exception e) => Result.failure(error: AppError(e));
}
