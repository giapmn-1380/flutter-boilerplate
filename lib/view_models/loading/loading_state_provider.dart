import 'package:flutter_boilerplate/view_models/loading/loading_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingStateProvider =
    ChangeNotifierProvider((ref) => LoadingStateNotifier());
