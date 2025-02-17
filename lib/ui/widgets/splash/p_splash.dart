import 'package:ai_sales_manager_mobile/ui/widgets/common/error/container_error_handling.dart';
import 'package:ai_sales_manager_mobile/ui/widgets/common/progress/primary_progress_indicator.dart';
import 'package:flutter/material.dart';

class PSplash extends StatelessWidget {
  const PSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerErrorHandling(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: const PrimaryProgressIndicator(),
      ),
    );
  }
}
