import 'package:ai_sales_manager_mobile/ui/widgets/common/progress/primary_progress_indicator.dart';
import 'package:ai_sales_manager_mobile/view_models/loading/loading_state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerWithLoading extends HookConsumerWidget {
  const ContainerWithLoading({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loadingStateProvider);
    return Stack(
      children: [
        child,
        state.isLoading ? const PrimaryProgressIndicator() : const SizedBox(),
      ],
    );
  }
}
