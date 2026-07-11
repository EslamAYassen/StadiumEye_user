import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  // Primary Colors
  static const Color primary = Color.fromARGB(255, 12, 155, 77);
  static const Color primaryDark = Color(0xFF085A2E);
  static const Color primaryLight = Color(0xFF0E9F50);

  // Green Shades
  static const Color lightGreen = Color(0xFFDFF3E8);
  static const Color veryLightGreen = Color(0xFFE8F5EE);
  static const Color mintGreen = Color(0xFFB8E6CC);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF00c951);
  static const Color gradientEnd = Color(0xFF00bd7e);

  // Grayscale
  static const Color darkGray = Color(0xFF111827);
  static const Color mediumGray = Color(0xFF6B7280);
  static const Color lightGray = Color(0xFFF3F4F6);
  static const Color veryLightGray = Color(0xFFF9FAFB);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color cardElevatedDark = Color(0xFF334155);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF047857);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF2563EB);

  // Fixed Colors
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color redColor = Color(0xFFFF6B6B);

  // Border Colors
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF334155);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x40000000);

  // Badge/Chip Colors
  static const Color badgeGreen = Color(0xFFD1FAE5);
  static const Color badgeGreenText = Color(0xFF065F46);
  static const Color badgeGray = Color(0xFFF3F4F6);
  static const Color badgeGrayText = Color(0xFF374151);

  // Accent Colors (used for categorizing quick actions / tiles that need
  // a 4th hue beyond primary/info/warning — kept in the shared palette
  // rather than hardcoded locally so it stays reusable and themeable).
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentPurpleLight = Color(0xFFEDE9FE);
}
