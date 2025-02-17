import 'package:flutter_boilerplate/ui/widgets/splash/p_splash.dart';
import 'package:flutter_boilerplate/view_models/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CSplash extends HookConsumerWidget {
  const CSplash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openFlowNotifier = ref.watch(openFlowProvider);

    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        openFlowNotifier.getNextRoute().then((nextRoute) {
          context.go(nextRoute.path);
        });
      });
      return null;
    }, []);

    return const PSplash();
  }
}
