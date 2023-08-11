import 'package:flutter/material.dart';

import 'config/routes/app_routes.dart';
import 'config/routes/navigation_service.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'injection_container.dart';

class JacksiLtdApp extends StatelessWidget {
  const JacksiLtdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      useInheritedMediaQuery: true,
      navigatorKey: sl<NavigationService>().navigationKey,
      //builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
