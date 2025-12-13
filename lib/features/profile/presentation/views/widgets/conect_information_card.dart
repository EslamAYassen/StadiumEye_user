import 'package:flutter/material.dart';
import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../../l10n/app_localizations.dart';

class ContactInformationCard extends StatelessWidget {
  final UserProfile profile;
  const ContactInformationCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.contactInformation,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 15),
          buildContactItem(
            context,
            Icons.email_outlined,
            locale.email,
            profile.email,
          ),
          const SizedBox(height: 12),
          buildContactItem(
            context,
            Icons.phone_outlined,
            locale.phone,
            profile.phone,
          ),
          const SizedBox(height: 12),
          // buildContactItem(
          //   context,
          //   Icons.location_on_outlined,
          //   'Location',
          //   'San Francisco, CA',
          // ),
        ],
      ),
    );
  }

  Widget buildContactItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(
          icon,
          color: isDarkMode
              ? AppColors.textSecondaryDark
              : AppColors.mediumGray,
          size: 22,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
