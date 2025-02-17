import 'package:ai_sales_manager_mobile/data/app_error.dart';
import 'package:flutter/foundation.dart';

class ErrorHandler extends ChangeNotifier {
  ErrorHandler();

  AppError? _appError;

  get appError => _appError;

  get isShowErrorPopup => _isShowErrorPopup;
  bool _isShowErrorPopup = false;

  Future<void> setError(AppError appError) async {
    _appError = appError;
    notifyListeners();
  }

  void resetError() {
    _appError = null;
  }

  void setShowErrorPopup(bool isShow) {
    _isShowErrorPopup = isShow;
  }
}
