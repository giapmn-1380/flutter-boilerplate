import 'package:ai_sales_manager_mobile/data/repositories/user_repositories.dart';
import 'package:ai_sales_manager_mobile/view_models/loading/loading_state_notifier.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier(this._userRepository, this.loadingStateNotifier);

  final UserRepository _userRepository;
  final LoadingStateNotifier loadingStateNotifier;

  void getUserInfo() async {
    try {
      loadingStateNotifier.toLoading();
      final result =
          (await _userRepository.getUserInfo(userId: "userId")).dataOrThrow;
    } catch (e) {
      debugPrint("Exception = " + e.toString());
    } finally {
      loadingStateNotifier.toIdle();
    }
  }
}
