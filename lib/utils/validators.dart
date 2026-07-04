import 'package:easy_localization/easy_localization.dart';

class Validators {
  Validators._();

  static final _emailRegex = RegExp(r'^[\w\.\-+]+@[\w\-]+(\.[\w\-]+)+$');

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty || !_emailRegex.hasMatch(email)) {
      return 'invalid_email'.tr();
    }
    return null;
  }

  static String? password(String? value) {
    if ((value ?? '').length < 6) {
      return 'password_too_short'.tr();
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value != password) {
      return 'password_not_match'.tr();
    }
    return null;
  }
}
