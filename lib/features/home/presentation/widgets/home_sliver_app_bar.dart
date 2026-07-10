import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_state.dart';
import 'package:stadium_eye/features/home/presentation/widgets/nearby_stadium_section.dart';
import 'package:stadium_eye/features/matches/presentation/cubit/nearby_stadium_cubit.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../constants/app_routes.dart';

/// Premium sliver app bar for the Home page.
///
/// The nearby-stadium / upcoming-match preview is now the primary visual
/// of this bar — it reuses [NearbyStadiumContent] directly (loading,
/// permission, error, and loaded states all reuse the exact same cubit
/// and widgets as everywhere else in the app, so nothing drifts out of
/// sync) rather than a generic greeting banner. It collapses into a
/// compact pinned title (the live match teams once loaded, otherwise a
/// generic label), with the logout action always reachable regardless of
/// scroll position.
class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  static const double _expandedHeight = 300;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return SliverAppBar(
      pinned: true,
      stretch: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      expandedHeight: _expandedHeight,
      backgroundColor: isDarkMode ? AppColors.primaryDark : AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppThemeConsts.radius24xl),
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double top = constraints.biggest.height;
          final double collapsedHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final double shrinkOffset = _expandedHeight - top;
          final double shrinkPct =
              (shrinkOffset / (_expandedHeight - collapsedHeight)).clamp(
                0.0,
                1.0,
              );

          return FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
              start: 20,
              bottom: 16,
              end: 60,
            ),
            centerTitle: false,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: shrinkPct > 0.6 ? 1 : 0,
              child: BlocBuilder<NearbyStadiumCubit, NearbyStadiumState>(
                builder: (context, state) {
                  String label = locale.nearbyStadium;
                  if (state.status == NearbyStadiumStatus.loaded) {
                    final teams = state.data!.fixture.teams;
                    final home = teams.home.name ?? '';
                    final away = teams.away.name ?? '';
                    if (home.isNotEmpty && away.isNotEmpty) {
                      label = '$home vs $away';
                    }
                  }
                  return Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [AppColors.primaryDark, AppColors.primary]
                      : [AppColors.gradientStart, AppColors.gradientEnd],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  // Top padding clears the pinned logout action that sits
                  // in the toolbar row above this content.
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: BlocBuilder<NearbyStadiumCubit, NearbyStadiumState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        switchInCurve: Curves.easeOut,
                        child: NearbyStadiumContent(
                          key: ValueKey(state.status),
                          state: state,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 6, bottom: 6),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile),

            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
            child: Container(
              padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state is AuthLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: LottieLoader(),
                        )
                      : const Icon(
                          Iconsax.profile_2user_copy,
                          color: AppColors.whiteColor,
                          size: 24,
                        );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 6, bottom: 6),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.settingsPage),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
            child: Container(
              padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state is AuthLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: LottieLoader(),
                        )
                      : const Icon(
                          Iconsax.setting_2_copy,
                          color: AppColors.whiteColor,
                          size: 24,
                        );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
