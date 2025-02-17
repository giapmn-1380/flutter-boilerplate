import 'dart:io';

import 'package:flutter_boilerplate/config/style/custom_color.dart';
import 'package:flutter_boilerplate/config/style/custom_text_style.dart';
import 'package:flutter_boilerplate/data/app_error.dart';
import 'package:flutter_boilerplate/ui/widgets/common/dialog/alert_dialog.dart';
import 'package:flutter_boilerplate/ui/widgets/common/progress/container_with_loading.dart';
import 'package:flutter_boilerplate/view_models/common/common_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerErrorHandling extends HookConsumerWidget {
  const ContainerErrorHandling({
    super.key,
    required this.child,
    this.isHome = false,
  });

  final Widget child;
  final bool? isHome;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check and show error when call api
    final appError = ref.watch(errorProvider.select((value) => value.appError));
    final errorNotifier = ref.watch(errorProvider);

    if (appError != null && appError is AppError) {
      if (appError.type == AppErrorType.network) {
        if (!errorNotifier.isShowErrorPopup) {
          Future.delayed(Duration.zero, () {
            errorNotifier.setShowErrorPopup(true);
            showAlertDialog(
              context: context,
              title: "Error",
              content: 'No internet connection',
              positiveActionTitle: "OK",
              textStylePositiveTitle: CustomTextStyle().fontSize16sp.copyWith(
                    color: CustomColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
              positiveActionPressed: () {},
              onCloseDialog: () {
                errorNotifier.setShowErrorPopup(false);
              },
            );
          });
        }
      } else if (appError.type == AppErrorType.common &&
          !errorNotifier.isShowErrorPopup) {
        Future.delayed(Duration.zero, () async {
          errorNotifier.setShowErrorPopup(true);
          showAlertDialog(
            context: context,
            title: "Có gì đó không ổn",
            content:
                'Đã xảy ra lỗi liên lạc. Nếu ứng dụng vẫn không khởi động ngay cả sau khi khởi động lại, vui lòng cài đặt lại ứng dụng.',
            positiveActionTitle: "OK",
            textStylePositiveTitle: CustomTextStyle().fontSize16sp.copyWith(
                  color: CustomColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
            positiveActionPressed: () {},
            onCloseDialog: () {
              errorNotifier.setShowErrorPopup(false);
            },
          );
        });
      } else {
        switch (appError.statusCode) {
          case HttpStatus.forbidden:
          case HttpStatus.notFound:
          case HttpStatus.badRequest:
            if (!errorNotifier.isShowErrorPopup) {
              Future.delayed(Duration.zero, () {
                errorNotifier.setShowErrorPopup(true);
                showAlertDialog(
                  context: context,
                  title: "問題が発生しました",
                  content:
                      'Đã xảy ra lỗi không mong muốn trong quá trình xử lý. Vui lòng thử lại sau một lúc.',
                  positiveActionTitle: "わかりました",
                  textStylePositiveTitle:
                      CustomTextStyle().fontSize16sp.copyWith(
                            color: CustomColor.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                  positiveActionPressed: () {},
                  onCloseDialog: () {
                    errorNotifier.setShowErrorPopup(false);
                  },
                );
              });
            }
            break;
          default:
            if (!errorNotifier.isShowErrorPopup) {
              Future.delayed(Duration.zero, () {
                errorNotifier.setShowErrorPopup(true);
                showAlertDialog(
                  context: context,
                  title: "問題が発生しました",
                  content:
                      'Đã xảy ra lỗi không mong muốn trong quá trình xử lý. Vui lòng thử lại sau một lúc.',
                  positiveActionTitle: "わかりました",
                  textStylePositiveTitle:
                      CustomTextStyle().fontSize16sp.copyWith(
                            color: CustomColor.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                  positiveActionPressed: () {},
                  onCloseDialog: () {
                    errorNotifier.setShowErrorPopup(false);
                  },
                );
              });
            }
            break;
        }
      }
      ref.read(errorProvider).resetError();
    }

    return ContainerWithLoading(child: child);
  }
}
