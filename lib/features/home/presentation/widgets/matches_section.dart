import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:stadium_eye/features/matches/presentation/cubit/matches_state.dart';
import 'package:stadium_eye/features/matches/presentation/widget/match_card.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

/// Home-page preview of today's matches.
///
/// Reuses the app-wide [MatchesCubit] (already fetching today's fixtures
/// from [main.dart]) and the same [MatchCard] used on the full Matches
/// page, so the look & feel stays identical without duplicating any logic.
class MatchesSection extends StatelessWidget {
  const MatchesSection({super.key, this.maxItems = 5});

  /// Maximum number of matches to preview on the home page.
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.primaryDark.withAlpha(76)
                          : AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(
                        AppThemeConsts.radius12md,
                      ),
                    ),
                    child: const Icon(
                      Icons.stadium_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    locale.matches,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.matches),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
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
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<MatchesCubit, MatchesState>(
            builder: (context, state) {
              if (state is MatchesLoading || state is MatchesInitial) {
                return const SizedBox(
                  height: 170,
                  child: Center(
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: LottieLoader(),
                    ),
                  ),
                );
              }

              if (state is MatchesError) {
                return _buildError(context, isDarkMode, locale, state.message);
              }

              if (state is MatchesLoaded) {
                final matches = state.filteredMatches.take(maxItems).toList();
                if (matches.isEmpty) {
                  return _buildEmpty(isDarkMode, locale);
                }

                return SizedBox(
                  height: 215,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: matches.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 320,
                        child: MatchCard(match: matches[index]),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations locale,
    String message,
  ) {
    return SizedBox(
      height: 170,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 36,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.read<MatchesCubit>().getMatchesEvent(
                // timezone: "Asia/Riyadh",
                date: DateTime.now().toIso8601String().split('T')[0],
                // league: "649",
                // season: DateTime.now().year.toString(),
              ),
              child: Text(locale.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(bool isDarkMode, AppLocalizations locale) {
    return SizedBox(
      height: 170,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sports_soccer,
              size: 40,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
            const SizedBox(height: 8),
            Text(
              locale.noData,
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
