import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_app_bar_for_report.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/ticket_entity.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key, required this.data});
  final TicketEntity data;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          CustomAppBarForReport(id: data.id),
          SliverList.list(
            children: [
              _ReportHeaderWidget(
                stadiumName: data.stadium.stadiumName,
                section: data.area,
                createdDate: data.createdAt.toIso8601String().substring(0, 10),
                authorName: data.createdBy!.fullName,
              ),
              // Media Gallery
              _MediaGalleryWidget(photoUrls: data.ticketImages),

              // Observations
              _ReportSectionWidget(
                title: locale.observations,
                content: data.observations,
                icon: Iconsax.document_1_copy,
                iconColor: AppColors.primary,
              ),

              // // Challenges
              // _ReportSectionWidget(
              //   title: locale.challenges,
              //   content: data.challenges,
              //   icon: Icons.error_outline,
              //   iconColor: AppColors.warning,
              // ),

              // // Lessons Learned
              // _ReportSectionWidget(
              //   title: locale.lessonsLearned,
              //   content: data.lessonsLearned,
              //   icon: Icons.lightbulb_outline,
              //   iconColor: AppColors.warning,
              // ),

              // Status
              _ReportStatusWidget(statusText: data.status),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportHeaderWidget extends StatelessWidget {
  final String stadiumName;
  final String section;
  final String createdDate;
  final String authorName;

  const _ReportHeaderWidget({
    required this.stadiumName,
    required this.section,
    required this.createdDate,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppThemeConsts.padding16md),
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.primaryDark.withAlpha(76)
                      : AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(
                    AppThemeConsts.radius12md,
                  ),
                ),
                child: const Icon(
                  Iconsax.location_copy,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stadiumName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      section,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.mediumGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Iconsax.calendar_1_copy,
                      size: 18,
                      color: isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.mediumGray,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.created,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode
                                ? AppColors.textSecondaryDark
                                : AppColors.mediumGray,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          createdDate,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Iconsax.user,
                      size: 18,
                      color: isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.mediumGray,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.author,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode
                                  ? AppColors.textSecondaryDark
                                  : AppColors.mediumGray,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            authorName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MediaGalleryWidget extends StatelessWidget {
  final List<String> photoUrls;

  const _MediaGalleryWidget({required this.photoUrls});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppThemeConsts.padding16md),
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.gallery_add,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                locale.mediaGallery,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${locale.photos} (${photoUrls.length})',
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photoUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 240,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppThemeConsts.radius12md,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(photoUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(153),
                            borderRadius: BorderRadius.circular(
                              AppThemeConsts.radius8sm,
                            ),
                          ),
                          child: Text(
                            'Photo ${index + 1}',
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Report Section Widget (Observations, Challenges, Lessons)
class _ReportSectionWidget extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color iconColor;

  const _ReportSectionWidget({
    required this.title,
    required this.content,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppThemeConsts.padding16md),
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Status Widget
class _ReportStatusWidget extends StatelessWidget {
  final String statusText;
  // final bool isSubmitted;

  const _ReportStatusWidget({
    required this.statusText,
    // this.isSubmitted = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppThemeConsts.padding16md),
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: AppThemeConsts.padding16md,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: (isDarkMode
              ? [AppColors.primaryDark, AppColors.primary]
              : [AppColors.success, AppColors.successDark]),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(AppThemeConsts.radius16md),
            ),
            child: const Icon(
              Iconsax.document_copy,
              color: AppColors.success,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            locale.status,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            statusText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}
