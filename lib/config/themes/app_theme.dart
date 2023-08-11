import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: AppColors.primary,
      brightness: Brightness.light,
      canvasColor: AppColors.secondary,
      scaffoldBackgroundColor: AppColors.secondary,
      fontFamily: AppStrings.fontFamily,
      appBarTheme: const AppBarTheme(
          centerTitle: false,
          color: Colors.white,
          titleTextStyle: TextStyle(
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 20)),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
            fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColors.primary));
}