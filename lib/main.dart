import 'package:flutter_boilerplate/config/route/app_route.dart';
import 'package:flutter_boilerplate/config/style/custom_color.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await loadEnvironmentOfFlavor();

  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [Locale('ja', 'JP')],
      path: "assets/lang",
      fallbackLocale: const Locale("ja", "JP"),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 734),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: kDebugMode,
          title: '',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: CustomColor.colorPrimary),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        );
      },
    );
  }
}
