import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/gen/assets.gen.dart';

/// Hiển thị trong lúc AuthController khôi phục phiên đăng nhập.
/// Việc điều hướng do redirect của router quyết định, splash không tự navigate.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.image.icLauncher.image(
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
