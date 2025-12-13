import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../../l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.settingsPage);
      },
      borderRadius: BorderRadius.circular(AppThemeConsts.radius16md),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppThemeConsts.padding16md,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppThemeConsts.padding16md,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16md),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.settings, color: AppColors.primary),
            const SizedBox(width: 20),
            Text(
              AppLocalizations.of(context)!.settings,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
          ],
        ),
      ),
    );
  }
}
