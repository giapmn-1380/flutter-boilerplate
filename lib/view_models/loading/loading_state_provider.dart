import 'package:ai_sales_manager_mobile/view_models/loading/loading_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingStateProvider =
    ChangeNotifierProvider((ref) => LoadingStateNotifier());
