import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stadium_eye/theme/app_colors.dart';

abstract class AppTheme {
  const AppTheme._();
  // Add theme transition duration constant
  static const Duration themeTransitionDuration = Duration(milliseconds: 200);

  // ==================== Text Styles ====================

  static const TextStyle _lightTextTheme = TextStyle(
    color: AppColors.textPrimaryLight,
    fontFamily: "cairo",
  );

  static const TextStyle _darkTextTheme = TextStyle(
    color: AppColors.textPrimaryDark,
    fontFamily: "cairo",
  );

  // ==================== Light Theme ====================

  static final ThemeData lightTheme = ThemeData(
    // Page Transition
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        .android: FadeUpwardsPageTransitionsBuilder(),
        // .iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardLight,
    dividerColor: AppColors.borderLight,

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.lightGreen,
      secondary: AppColors.gradientStart,
      secondaryContainer: AppColors.mintGreen,
      surface: AppColors.surfaceLight,
      // background: AppColors.backgroundLight,
      error: AppColors.error,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
      onSurface: AppColors.textPrimaryLight,
      // onBackground: AppColors.textPrimaryLight,
      onError: AppColors.whiteColor,
      outline: AppColors.borderLight,
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.cardLight,
      elevation: 2,
      shadowColor: AppColors.shadowLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: AppColors.primary, size: 24),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.whiteColor,
      elevation: 4,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightGreen,
      deleteIconColor: AppColors.primary,
      labelStyle: const TextStyle(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGray,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: _lightTextTheme,
      displayMedium: _lightTextTheme,
      displaySmall: _lightTextTheme,
      headlineLarge: _lightTextTheme,
      headlineMedium: _lightTextTheme,
      headlineSmall: _lightTextTheme,
      titleLarge: _lightTextTheme,
      titleMedium: _lightTextTheme,
      titleSmall: _lightTextTheme,
      bodyLarge: _lightTextTheme,
      bodyMedium: _lightTextTheme,
      bodySmall: _lightTextTheme,
      labelLarge: _lightTextTheme,
      labelMedium: _lightTextTheme,
      labelSmall: _lightTextTheme,
    ),
  );

  // ==================== Dark Theme ====================

  static final ThemeData darkTheme = ThemeData(
    // Page Transition
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        .android: FadeUpwardsPageTransitionsBuilder(),
        // .iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,
    dividerColor: AppColors.borderDark,

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryDark,
      secondary: AppColors.gradientStart,
      secondaryContainer: AppColors.primaryDark,
      surface: AppColors.surfaceDark,
      // background: AppColors.backgroundDark,
      error: AppColors.errorDark,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
      onSurface: AppColors.textPrimaryDark,
      // onBackground: AppColors.textPrimaryDark,
      onError: AppColors.whiteColor,
      outline: AppColors.borderDark,
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.cardDark,
      elevation: 4,
      shadowColor: AppColors.shadowDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: AppColors.primary, size: 24),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.whiteColor,
      elevation: 4,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryDark,
      deleteIconColor: AppColors.primary,
      labelStyle: const TextStyle(color: AppColors.textPrimaryDark),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardElevatedDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorDark),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: _darkTextTheme,
      displayMedium: _darkTextTheme,
      displaySmall: _darkTextTheme,
      headlineLarge: _darkTextTheme,
      headlineMedium: _darkTextTheme,
      headlineSmall: _darkTextTheme,
      titleLarge: _darkTextTheme,
      titleMedium: _darkTextTheme,
      titleSmall: _darkTextTheme,
      bodyLarge: _darkTextTheme,
      bodyMedium: _darkTextTheme,
      bodySmall: _darkTextTheme,
      labelLarge: _darkTextTheme,
      labelMedium: _darkTextTheme,
      labelSmall: _darkTextTheme,
    ),
  );
}
