import 'package:ai_sales_manager_mobile/config/route/app_route.dart';
import 'package:ai_sales_manager_mobile/data/local/preference_key.dart';
import 'package:flutter/material.dart';

class OpenFlowNotifier extends ChangeNotifier {
  OpenFlowNotifier();

  AppRoute? nextRoute;

  Future<AppRoute> getNextRoute() async {
    final hasLogin = await isLogin();
    if (hasLogin) {
      nextRoute = AppRoute.home;
    } else {
      nextRoute = AppRoute.login;
    }
    return nextRoute ?? AppRoute.login;
  }

  Future<bool> isLogin() async {
    return await PreferenceKey.hasLogin.getBool();
  }
}
