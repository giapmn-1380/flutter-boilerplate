import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/data/app_error.dart';
import 'package:flutter_boilerplate/ui/widgets/common/progress/primary_progress_indicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Render một [AsyncValue] với loading/error mặc định,
/// dùng cho mọi màn hình fetch data qua FutureProvider/AsyncNotifier.
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const PrimaryProgressIndicator(),
      error: (error, _) => ErrorView(error: error, onRetry: onRetry),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  String get _message {
    final appError = error;
    if (appError is AppException && appError.type == AppErrorType.network) {
      return 'no_internet'.tr();
    }
    return 'error_occurred'.tr();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(_message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onRetry,
                child: Text('retry'.tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
