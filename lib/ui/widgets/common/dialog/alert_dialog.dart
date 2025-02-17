import 'dart:io';

import 'package:ai_sales_manager_mobile/config/style/custom_break_point.dart';
import 'package:ai_sales_manager_mobile/config/style/custom_color.dart';
import 'package:ai_sales_manager_mobile/config/style/custom_shape.dart';
import 'package:ai_sales_manager_mobile/config/style/custom_spacing.dart';
import 'package:ai_sales_manager_mobile/config/style/custom_text_style.dart';
import 'package:ai_sales_manager_mobile/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAlertDialog({
  required BuildContext context,
  String? title,
  TextStyle? textStyleContent,
  required String content,
  required String positiveActionTitle,
  TextStyle? textStylePositiveTitle,
  String? negativeActionTitle,
  TextStyle? textStyleNegativeTitle,
  required Function() positiveActionPressed,
  Function()? negativeActionPressed,
  Widget? widget,
  bool barrierDismissible = true,
  Color? positiveTextColor,
  Widget? contentWidget,
  Function()? onCloseDialog,
  Color? contentColor,
  Color? backgroundColor,
}) {
  final textStyle = CustomTextStyle();
  final isMobile = CustomBreakpoint.isMobile(context);
  showDialog(
    barrierDismissible: barrierDismissible,
    barrierColor: CustomColor.bgOverlayDialog,
    context: context,
    builder: (builderContext) {
      return PopScope(
        canPop: barrierDismissible,
        child: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Dialog(
            backgroundColor: backgroundColor ?? Colors.white,
            insetPadding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? CustomSpacing.space40.w
                  : Platform.isIOS
                      ? CustomSpacing.space88.w
                      : CustomSpacing.space80.w,
            ),
            shape: CustomShape.buttonShapeRadius10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: CustomSpacing.space16.w,
                    top: CustomSpacing.space24.h,
                    right: CustomSpacing.space16.w,
                    bottom:
                        title?.isNotEmpty == true ? CustomSpacing.space16.h : 0,
                  ),
                  child: title?.isNotEmpty == true
                      ? Text(
                          title!,
                          style: textStyle.fontSize20sp
                              .bold()
                              .copyWith(color: CustomColor.textPrimary),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                ),
                content.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: CustomSpacing.space16.w,
                          right: CustomSpacing.space16.w,
                          bottom: CustomSpacing.space16.h,
                        ),
                        child: Text(
                          content,
                          textAlign: TextAlign.center,
                          style: textStyleContent ??
                              textStyle.fontSize16sp.copyWith(
                                color:
                                    contentColor ?? CustomColor.textSecondary,
                              ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          left: CustomSpacing.space16.w,
                          right: CustomSpacing.space16.w,
                          bottom: CustomSpacing.space16.h,
                        ),
                        child: contentWidget ?? const SizedBox(),
                      ),
                widget != null
                    ? Padding(
                        padding:
                            EdgeInsets.only(bottom: CustomSpacing.space16.h),
                        child: widget,
                      )
                    : const SizedBox(),
                Divider(
                  thickness: 1,
                  height: 0,
                  color: CustomColor.dialogDivider,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      if (negativeActionPressed != null &&
                          negativeActionTitle != null) ...[
                        _buildDialogAction(
                          negativeActionTitle,
                          textStyleNegativeTitle ?? textStyle.fontSize16sp,
                          onTap: () {
                            Navigator.pop(builderContext);
                            negativeActionPressed();
                          },
                        ),
                        VerticalDivider(
                          thickness: 1,
                          width: 0,
                          color: CustomColor.dialogDivider,
                        ),
                      ],
                      _buildDialogAction(
                        positiveActionTitle,
                        textStylePositiveTitle ??
                            textStyle.fontSize16sp.bold().copyWith(
                                  color: positiveTextColor ??
                                      CustomColor.dialogPositiveAction,
                                ),
                        onTap: () {
                          Navigator.pop(builderContext);
                          positiveActionPressed();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  ).then((value) {
    if (onCloseDialog != null) {
      onCloseDialog();
    }
  });
}

Widget _buildDialogAction(
  String text,
  TextStyle textStyle, {
  required Function() onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: CustomSpacing.space16.h),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    ),
  );
}
