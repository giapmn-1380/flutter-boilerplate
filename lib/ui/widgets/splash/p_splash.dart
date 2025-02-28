import 'package:ai_sales_manager_mobile/gen/assets.gen.dart';
import 'package:ai_sales_manager_mobile/ui/widgets/common/error/container_error_handling.dart';
import 'package:flutter/material.dart';

class PSplash extends StatelessWidget {
  const PSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerErrorHandling(
      child: Center(
        child: Assets.svgs.icLaunch.svg(),
      ),
    );
  }
}
