import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../report/presentation/bloc/report_bloc.dart';
import '../../../report/presentation/bloc/report_state.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    // Solid, theme-matched card — see QuickActionsSection for why the old
    // BackdropFilter/blur treatment was dropped.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading) {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: LottieLoader(),
              ),
            );
          } else if (state is ReportsError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontSize: 16,
                ),
              ),
            );
          } else if (state is ReportsLoaded &&
              state.reports.tickets.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        AppThemeConsts.padding8xs,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.primaryDark.withAlpha(76)
                            : AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(
                          AppThemeConsts.radius12md,
                        ),
                      ),
                      child: const Icon(
                        Icons.history_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      locale.recentActivity,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ...state.reports.tickets.asMap().entries.take(3).map((
                  entry,
                ) {
                  final now = DateTime.now();
                  String timeType = "hrs";
                  int diffTieme = now
                      .difference(entry.value.createdAt)
                      .inHours;
                  final ticket = entry.value;

                  if (now.difference(ticket.createdAt).inHours >= 24) {
                    diffTieme = now
                        .difference(entry.value.createdAt)
                        .inDays;
                    timeType = "days";
                  }
                  return _RecentActivityItem(
                    title: ticket.status,
                    subtitle:
                        "${ticket.stadium.stadiumName} - ${ticket.area}",
                    timeAgo: "$diffTieme $timeType ago",
                  );
                }),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _RecentActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;

  const _RecentActivityItem({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.cardElevatedDark
            : AppColors.veryLightGray,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
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
            child: const Icon(
              Iconsax.document,
              color: AppColors.primary,
              size: 28,
            ),
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
