import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final String? value;
  final List<String> items;
  final IconData icon;
  final String initText;

  final Function(String? value) onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.title,
    required this.items,
    required this.initText,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      // width: double.infinity,
      // height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.lightGray,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: value == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: AppColors.primary, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          disabledHint: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          value: value,
          hint: Row(
            children: [
              Icon(
                icon,
                // size: 30,
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
              const SizedBox(width: 10),
              Text(
                initText,
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
          // dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Iconsax.location_copy,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      // maxLines: 1,
                      // softWrap: false,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
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
