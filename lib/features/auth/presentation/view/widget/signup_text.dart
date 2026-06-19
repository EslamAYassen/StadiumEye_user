import 'package:flutter/material.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';

class SignupText extends StatelessWidget {
  const SignupText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          locale.signUp,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.primaryDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          locale.createYourAccount,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? AppColors.textSecondaryDark : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
