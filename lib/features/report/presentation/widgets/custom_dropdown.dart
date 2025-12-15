import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final String? value;
  final List<String> stadiums;
  final IconData icon;
  final String initText;
  final Function(String? value) onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.title,
    required this.stadiums,
    required this.initText,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding12sm,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        border: Border.all(
          color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? AppColors.shadowDark.withAlpha(76)
                : AppColors.shadowLight,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          disabledHint: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          value: value,
          hint: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
              const SizedBox(width: 8),
              Text(
                initText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDarkMode
                ? AppColors.textSecondaryDark
                : AppColors.mediumGray,
          ),
          dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          items: stadiums.map((stadium) {
            return DropdownMenuItem(
              value: stadium,
              child: Row(
                children: [
                  const Icon(
                    Iconsax.location_copy,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    stadium,
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
