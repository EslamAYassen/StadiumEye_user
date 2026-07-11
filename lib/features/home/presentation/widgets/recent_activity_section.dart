import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/constants/app_routes.dart';
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
              child: SizedBox(height: 100, width: 100, child: LottieLoader()),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.myReports,
                        arguments: state.reports.totalResults,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppThemeConsts.radius8sm,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              locale.viewAll,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ...state.reports.tickets.asMap().entries.take(3).map((entry) {
                  final now = DateTime.now();
                  String timeType = "hrs";
                  int diffTieme = now.difference(entry.value.createdAt).inHours;
                  final ticket = entry.value;

                  if (now.difference(ticket.createdAt).inHours >= 24) {
                    diffTieme = now.difference(entry.value.createdAt).inDays;
                    timeType = "days";
                  }
                  return _RecentActivityItem(
                    title: ticket.observations,
                    subtitle: "${ticket.stadium.stadiumName} - ${ticket.area}",
                    timeAgo: "$diffTieme $timeType ago",
                    status: ticket.status,
                    imageUrl: ticket.ticketImages.isNotEmpty
                        ? ticket.ticketImages.first
                        : null,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.reportDetails,
                      arguments: ticket,
                    ),
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

/// Maps a raw ticket status string to a label + color, mirroring the same
/// palette [TicketsStatusChart] uses for its donut segments so status
/// colors stay consistent everywhere on the Home page.
class _StatusMeta {
  const _StatusMeta({required this.label, required this.color});
  final String label;
  final Color color;
}

_StatusMeta _statusMeta(String status, AppLocalizations locale) {
  switch (status) {
    case 'open':
      return _StatusMeta(label: locale.open, color: AppColors.success);
    case 'inProgress':
      return _StatusMeta(label: locale.inProgress, color: AppColors.info);
    case 'resolved':
      return _StatusMeta(label: locale.resolved, color: AppColors.primary);
    case 'closed':
      return _StatusMeta(label: locale.closed, color: AppColors.warning);
    case 'rejected':
      return _StatusMeta(label: locale.rejected, color: AppColors.error);
    default:
      return _StatusMeta(label: status, color: AppColors.mediumGray);
  }
}

class _RecentActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final String status;
  final String? imageUrl;
  final VoidCallback? onTap;

  const _RecentActivityItem({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.status,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;
    final meta = _statusMeta(status, locale);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.cardElevatedDark
              : AppColors.veryLightGray,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _placeholderThumb(isDarkMode),
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return _placeholderThumb(isDarkMode);
                      },
                    )
                  : _placeholderThumb(isDarkMode),
            ),
            const SizedBox(width: AppThemeConsts.padding12sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location_copy,
                        size: 12,
                        color: isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: isDarkMode
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? meta.color.withAlpha(46)
                        : meta.color.withAlpha(26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    meta.label,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: meta.color,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.mediumGray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderThumb(bool isDarkMode) {
    return Container(
      width: 56,
      height: 56,
      color: isDarkMode ? AppColors.cardDark : AppColors.lightGray,
      child: Icon(
        Iconsax.gallery_copy,
        size: 22,
        color: isDarkMode ? AppColors.textSecondaryDark : AppColors.mediumGray,
      ),
    );
  }
}
