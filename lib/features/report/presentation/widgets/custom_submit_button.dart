import 'package:flutter/material.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    this.onTap,
    this.isEndable = true,
    this.isLoading = false,
  });
  final void Function()? onTap;
  final bool isLoading;
  final bool isEndable;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: isEndable && !isLoading ? onTap : null,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isEndable
              ? AppColors.primary
              : (isDarkMode ? AppColors.cardElevatedDark : AppColors.lightGray),
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          boxShadow: isEndable
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(76),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: isLoading
            ? const SizedBox(height: 18, child: LottieLoader())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.send_rounded,
                    size: 18,
                    color: isEndable
                        ? AppColors.whiteColor
                        : (isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.mediumGray),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.submitReport,
                    style: TextStyle(
                      fontSize: 15,
                      color: isEndable
                          ? AppColors.whiteColor
                          : (isDarkMode
                                ? AppColors.textSecondaryDark
                                : AppColors.mediumGray),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
