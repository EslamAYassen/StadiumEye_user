import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(AppThemeConsts.padding16md),
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppColors.cardDark.withAlpha(76)
                : const Color.fromARGB(26, 255, 255, 255),
            gradient: isDarkMode
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.cardDark.withAlpha(122),
                      AppColors.cardDark.withAlpha(76),
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(50, 255, 255, 255),
                      Color.fromARGB(26, 255, 255, 255),
                    ],
                  ),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
            border: Border.all(
              color: isDarkMode
                  ? AppColors.borderDark.withAlpha(76)
                  : const Color.fromARGB(75, 255, 255, 255),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? AppColors.shadowDark
                    : const Color.fromARGB(26, 0, 0, 0),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.cardElevatedDark
                      : AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(
                    AppThemeConsts.radius16md,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? AppColors.shadowDark.withAlpha(76)
                          : Colors.black12,
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const _RecentActivityItem(
                title: "Report submitted",
                subtitle: "King Fahd Stadium - North Stand",
                timeAgo: "2 hours ago",
              ),
              const _RecentActivityItem(
                title: "Photo captured",
                subtitle: "Al Janoub Stadium - West Entrance",
                timeAgo: "5 hours ago",
                icon: Iconsax.camera,
              ),
              const _RecentActivityItem(
                title: "Report submitted",
                subtitle: "Education City Stadium - East Stand",
                timeAgo: "1 day ago",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;

  const _RecentActivityItem({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.icon = Iconsax.document,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? AppColors.shadowDark.withAlpha(76)
                : Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.primaryDark.withAlpha(76)
                  : AppColors.lightGreen,
              borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: AppThemeConsts.padding16md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
