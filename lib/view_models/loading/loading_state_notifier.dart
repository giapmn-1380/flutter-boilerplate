import 'package:flutter/foundation.dart';

class LoadingStateNotifier extends ChangeNotifier {
  bool isLoading = false;

  void toLoading() {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
  }

  void toIdle() {
    if (!isLoading) return;
    isLoading = false;
    notifyListeners();
  }
}
