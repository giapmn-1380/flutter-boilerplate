import 'package:ai_sales_manager_mobile/config/style/custom_color.dart';
import 'package:flutter/material.dart';

class PrimaryProgressIndicator extends StatelessWidget {
  const PrimaryProgressIndicator({super.key, this.color, this.sizeProgress});

  final Color? color;
  final double? sizeProgress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: sizeProgress != null
          ? SizedBox(
              height: sizeProgress,
              width: sizeProgress,
              child: circularProgress(color),
            )
          : circularProgress(color),
    );
  }

  Widget circularProgress(Color? color) {
    return CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation<Color>(color ?? CustomColor.progressFinish),
    );
  }
}
