import 'package:ai_sales_manager_mobile/ui/widgets/home/p_home.dart';
import 'package:ai_sales_manager_mobile/view_models/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CHome extends HookConsumerWidget {
  const CHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return PHome(
      onPress: () => {user.getUserInfo()},
    );
  }
}
