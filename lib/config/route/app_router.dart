import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/ui/screens/auth/login_screen.dart';
import 'package:flutter_boilerplate/ui/screens/auth/register_screen.dart';
import 'package:flutter_boilerplate/ui/screens/main/main_screen.dart';
import 'package:flutter_boilerplate/ui/screens/main/tabs/home_tab.dart';
import 'package:flutter_boilerplate/ui/screens/main/tabs/posts_tab.dart';
import 'package:flutter_boilerplate/ui/screens/main/tabs/profile_tab.dart';
import 'package:flutter_boilerplate/ui/screens/main/tabs/settings_tab.dart';
import 'package:flutter_boilerplate/ui/screens/splash/splash_screen.dart';
import 'package:flutter_boilerplate/view_models/auth/auth_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AppRoute {
  splash('/splash'),
  // AuthStack
  login('/login'),
  register('/register'),
  // MainStack
  home('/home'),
  posts('/posts'),
  settings('/settings'),
  profile('/profile');

  final String path;

  const AppRoute(this.path);
}

final routerProvider = Provider<GoRouter>((ref) {
  // Bridge auth state -> refreshListenable để GoRouter chạy lại redirect
  // mỗi khi trạng thái đăng nhập thay đổi.
  final authStatus = ValueNotifier(AuthStatus.unknown);
  ref
    ..listen(
      authControllerProvider,
      (_, next) => authStatus.value = next,
      fireImmediately: true,
    )
    ..onDispose(authStatus.dispose);

  return GoRouter(
    initialLocation: AppRoute.splash.path,
    refreshListenable: authStatus,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isSplash = location == AppRoute.splash.path;
      final inAuthStack = location == AppRoute.login.path ||
          location == AppRoute.register.path;

      switch (authStatus.value) {
        case AuthStatus.unknown:
          return isSplash ? null : AppRoute.splash.path;
        case AuthStatus.unauthenticated:
          return inAuthStack ? null : AppRoute.login.path;
        case AuthStatus.authenticated:
          return (isSplash || inAuthStack) ? AppRoute.home.path : null;
      }
    },
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      // AuthStack
      GoRoute(
        path: AppRoute.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.register.path,
        builder: (context, state) => const RegisterScreen(),
      ),
      // MainStack: bottom navigation giữ state riêng cho từng tab.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                builder: (context, state) => const HomeTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.posts.path,
                builder: (context, state) => const PostsTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.settings.path,
                builder: (context, state) => const SettingsTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                builder: (context, state) => const ProfileTab(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
