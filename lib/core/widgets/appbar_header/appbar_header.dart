import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_theme_consts.dart';

class AppbarHeader extends StatelessWidget {
  const AppbarHeader({
    super.key,
    required this.isDarkMode,
    required this.title,
    this.widget,
  });
  final bool isDarkMode;
  final String title;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [AppColors.primaryDark, AppColors.primary]
              : [AppColors.primary, AppColors.gradientStart],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppThemeConsts.radius24xl),
          bottomRight: Radius.circular(AppThemeConsts.radius24xl),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppThemeConsts.padding16md,
          AppThemeConsts.padding16md,
          AppThemeConsts.padding16md,
          40,
        ),
        child: Row(
          children: [
            // Back button
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.whiteColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // const SizedBox(width: 48),
            widget ?? const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
