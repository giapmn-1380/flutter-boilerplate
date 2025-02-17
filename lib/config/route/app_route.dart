import 'package:ai_sales_manager_mobile/ui/screens/home/home_screen.dart';
import 'package:ai_sales_manager_mobile/ui/screens/login/login_screen.dart';
import 'package:ai_sales_manager_mobile/ui/screens/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  splash('/splash'),
  login('/login'),
  home('/home');

  final String path;

  const AppRoute(this.path);
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoute.splash.path,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
