// lib/features/matches/presentation/pages/matches_page.dart
// Simplified version using Cubit for filters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';

import 'package:stadium_eye/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:stadium_eye/features/matches/presentation/widget/match_card.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../constants/app_consts.dart';
import '../../../../core/widgets/appbar_header/appbar_header.dart';
import '../../../../core/widgets/drop_down/custom_dropdown.dart';
import '../../../../l10n/app_localizations.dart';
// import '../../domain/entities/matches_res.dart';
import '../cubit/matches_state.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  // late Animation<Offset> _slide;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.darkGray
            : AppColors.backgroundLight,
        body: BlocBuilder<MatchesCubit, MatchesState>(
          builder: (context, state) {
            if (state is MatchesLoading) {
              return _buildLoadingState(isDarkMode, locale);
            } else if (state is MatchesLoaded) {
              return _buildLoadedState(context, isDarkMode, state, locale);
            } else if (state is MatchesError) {
              return _buildErrorState(
                context,
                isDarkMode,
                state.message,
                locale,
              );
            }
            return _buildErrorState(
              context,
              isDarkMode,
              locale.unknownState,
              locale,
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(bool isDarkMode, AppLocalizations locale) {
    return Column(
      children: [
        AppbarHeader(isDarkMode: isDarkMode, title: locale.matches),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(height: 100, width: 100, child: LottieLoader()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    bool isDarkMode,
    MatchesLoaded state,
    AppLocalizations locale,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppbarHeader(
            isDarkMode: isDarkMode,
            title: locale.matches,
            widget: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
              ),
              child: IconButton(
                icon: const Icon(
                  Iconsax.filter_copy,
                  color: AppColors.whiteColor,
                ),
                onPressed: () => _showFilterDialog(context, state),
              ),
            ),
          ),
          const SizedBox(height: AppThemeConsts.padding16md),

          // Show active filters
          if (state.filters.hasActiveFilters)
            _buildActiveFilters(context, state.filters, isDarkMode),

          // Show filtered count
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppThemeConsts.padding16md,
              vertical: AppThemeConsts.padding8xs,
            ),
            child: Text(
              '${locale.show} ${state.filteredMatches.length} ${locale.matche}',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.whiteColor.withAlpha((0.7 * 255) ~/ 1)
                    : AppColors.darkGray.withAlpha((0.7 * 255) ~/ 1),
                fontSize: 14,
              ),
            ),
          ),

          ...state.filteredMatches.map(
            (match) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: MatchCard(match: match),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, MatchesLoaded state) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final cubit = context.read<MatchesCubit>();
    final availableStatuses = [
      'All',
      'Not Started (NS)',
      'First Half (1H)',
      'Halftime (HT)',
      'Second Half (2H)',
      'Finished (FT)',
      'Postponed (PST)',
    ];

    var selectedLeague = state.filters.league;
    var selectedCountry = state.filters.country;
    var selectedStatus = state.filters.status;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        ),
        backgroundColor: isDarkMode ? AppColors.darkGray : AppColors.whiteColor,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 600),
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              final locale = AppLocalizations.of(context)!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(AppThemeConsts.padding16md),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppThemeConsts.radius16lg),
                        topRight: Radius.circular(AppThemeConsts.radius16lg),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.filterMatches,
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  // Filter Options
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppThemeConsts.padding16md),

                          // League Filter
                          CustomDropdown(
                            value: selectedLeague,
                            title: locale.league,
                            items: ['All', ...state.availableLeagues],
                            initText: locale.chooseLeague,
                            onChanged: (value) {
                              setDialogState(() {
                                selectedLeague = value;
                              });
                            },
                            icon: Icons.sports_soccer,
                          ),

                          const SizedBox(height: AppThemeConsts.padding16md),

                          // Country Filter
                          CustomDropdown(
                            value: selectedCountry,
                            title: locale.country,
                            items: ['All', ...state.availableCountries],
                            initText: locale.chooseCountry,
                            onChanged: (value) {
                              // setDialogState(() {
                              setDialogState(() {
                                selectedCountry = value;
                              });
                              // });
                            },
                            icon: Icons.flag,
                          ),

                          const SizedBox(height: AppThemeConsts.padding16md),

                          // Status Filter
                          CustomDropdown(
                            value: selectedStatus,
                            title: locale.status,
                            items: availableStatuses,
                            initText: locale.chooseStatus,
                            onChanged: (value) {
                              // setDialogState(() {
                              setDialogState(() {
                                selectedStatus = value;
                                // print('Selected Status: $selectedStatus');
                              });
                              // });
                            },
                            icon: Icons.info_outline,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action Buttons
                  Container(
                    padding: const EdgeInsets.all(AppThemeConsts.padding16md),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDarkMode
                              ? AppColors.lightGray.withAlpha((0.1 * 255) ~/ 1)
                              : AppColors.lightGray,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Clear Filters Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.read<MatchesCubit>().clearFilters();
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppThemeConsts.radius8sm,
                                ),
                              ),
                            ),
                            child: Text(
                              locale.reset,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppThemeConsts.padding12sm),

                        // Apply Filters Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<MatchesCubit>().updateFilters(
                                league: selectedLeague,
                                country: selectedCountry,
                                status: selectedStatus,
                              );

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppThemeConsts.radius8sm,
                                ),
                              ),
                            ),
                            child: Text(
                              locale.apply,
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFilters(
    BuildContext context,
    MatchFilters filters,
    bool isDarkMode,
  ) {
    final activeFilters = <String>[];

    if (filters.league != null && filters.league != 'All') {
      activeFilters.add(filters.league!);
    }
    if (filters.country != null && filters.country != 'All') {
      activeFilters.add(filters.country!);
    }
    if (filters.status != null && filters.status != 'All') {
      activeFilters.add(filters.status!);
    }

    if (activeFilters.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: AppThemeConsts.padding12sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: activeFilters.map((filter) {
          return Chip(
            label: Text(
              filter,
              style: const TextStyle(color: AppColors.whiteColor, fontSize: 12),
            ),
            backgroundColor: AppColors.primary,
            deleteIcon: const Icon(
              Icons.close,
              size: 16,
              color: AppColors.whiteColor,
            ),
            onDeleted: () {
              final cubit = context.read<MatchesCubit>();
              final currentFilters = filters;

              cubit.updateFilters(
                league: filter == currentFilters.league
                    ? null
                    : currentFilters.league,
                country: filter == currentFilters.country
                    ? null
                    : currentFilters.country,
                status: filter == currentFilters.status
                    ? null
                    : currentFilters.status,
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    bool isDarkMode,
    String message,
    AppLocalizations locale,
  ) {
    return Center(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppbarHeader(isDarkMode: isDarkMode, title: locale.matches),
            ],
          ),
          Image.asset(width: 100, height: 100, AppConsts.errorImage),
          const SizedBox(height: 20),
          Text(message),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<MatchesCubit>().getMatchesEvent(
              date: DateTime.now().toIso8601String().split('T')[0],
            ),
            child: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }
}
