import 'package:flutter/material.dart';

import 'package:stadium_eye/theme/app_colors.dart';
// import 'package:stadium_eye/theme/app_theme_consts.dart';

abstract class AppTheme {
  const AppTheme._();
  static const TextStyle _mainTextTheme = TextStyle(
    color: AppColors.blackColor,
    // fontFamily: AppThemeConsts.outfitfontFamily,
  );
  static final ThemeData mainTheme = ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.darkGray,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    iconTheme: const IconThemeData(color: AppColors.primary),
    textTheme: const TextTheme(
      bodySmall: _mainTextTheme,
      bodyMedium: _mainTextTheme,
      titleLarge: _mainTextTheme,
      titleMedium: _mainTextTheme,
      bodyLarge: _mainTextTheme,
      titleSmall: _mainTextTheme,
      displayLarge: _mainTextTheme,
      displayMedium: _mainTextTheme,
      displaySmall: _mainTextTheme,
      headlineLarge: _mainTextTheme,
      headlineMedium: _mainTextTheme,
      headlineSmall: _mainTextTheme,
      labelLarge: _mainTextTheme,
      labelMedium: _mainTextTheme,
      labelSmall: _mainTextTheme,
    ),
  );
}
