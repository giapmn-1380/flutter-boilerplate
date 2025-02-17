import 'package:ai_sales_manager_mobile/data/repositories/user_repositories_impl.dart';
import 'package:ai_sales_manager_mobile/view_models/common/error_notifier.dart';
import 'package:ai_sales_manager_mobile/view_models/common/open_flow_notifier.dart';
import 'package:ai_sales_manager_mobile/view_models/loading/loading_state_provider.dart';
import 'package:ai_sales_manager_mobile/view_models/user/user_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final errorProvider = ChangeNotifierProvider((ref) => ErrorHandler());

final openFlowProvider = ChangeNotifierProvider((ref) => OpenFlowNotifier());

final userProvider = ChangeNotifierProvider<UserNotifier>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final loadingProvider = ref.watch(loadingStateProvider);
  return UserNotifier(userRepository, loadingProvider);
});
