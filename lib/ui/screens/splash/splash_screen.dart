import 'package:ai_sales_manager_mobile/ui/widgets/splash/c_splash.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CSplash(),
    );
  }
}
