import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/ui/widgets/home/p_home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CHome extends HookConsumerWidget {
  const CHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider);

    return PHome(
      onPress: () {
        context.setLocale(const Locale("vi", "VN"));
        //user.getUserInfo();
      },
    );
  }
}
