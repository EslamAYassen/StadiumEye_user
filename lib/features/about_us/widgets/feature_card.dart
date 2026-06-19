import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode ? AppColors.borderDark : Colors.grey[200]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? AppColors.shadowDark
                : const Color.fromRGBO(158, 158, 158, 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.primaryDark.withAlpha(76)
                  : AppColors.lightGreen,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
