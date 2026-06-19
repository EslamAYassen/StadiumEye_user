import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          locale.dontHaveAccount,
          style: TextStyle(
            color: isDarkMode ? AppColors.textSecondaryDark : Colors.grey[700],
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.register),
          child: Text(
            locale.signUp,
            style: TextStyle(
              color: isDarkMode
                  ? AppColors.primaryLight
                  : AppColors.primaryDark,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
