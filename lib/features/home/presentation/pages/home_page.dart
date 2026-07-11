import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:stadium_eye/features/home/presentation/bloc/home_bloc.dart';
import 'package:stadium_eye/features/home/presentation/bloc/home_event.dart';
import 'package:stadium_eye/features/home/presentation/bloc/home_state.dart';
import 'package:stadium_eye/features/home/presentation/widgets/home_sliver_app_bar.dart';
import 'package:stadium_eye/features/matches/presentation/cubit/nearby_stadium_cubit.dart';

import 'package:stadium_eye/features/home/presentation/widgets/recent_activity_section.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/utils/language.dart';

import '../../../../constants/app_routes.dart';
import '../../../../core/widgets/loading/lottie_loading.dart';
import '../../../../theme/app_colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../report/presentation/bloc/report_event.dart';
import '../../home_injection.dart';
import '../widgets/home_error_view.dart';
import '../widgets/matches_section.dart';
import '../widgets/ball_indicator.dart';
import '../widgets/staggered_fade_in.dart';
import '../widgets/tickets_status_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //TODO: remove this shit
      providers: [
        BlocProvider(
          create: (context) =>
              HomeBloc(getHomeDataUseCase: sl())
                ..add(const LoadHomeDataEvent()),
        ),
        BlocProvider(
          create: (context) => ReportsBloc(
            getMyReportsUseCase: sl(),
            getStadiumsUseCase: sl(),
            createReportUseCase: sl(),
            getCitiesUseCase: sl(),
            getCountriesUseCase: sl(),
          )..add(const LoadMyReportsEvent()),
        ),
        BlocProvider(
          create: (context) => sl<NearbyStadiumCubit>()..fetchNearbyStadium(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;
            final locale = AppLocalizations.of(context)!;

            if (state is HomeError) {
              return SafeArea(
                child: Scaffold(
                  backgroundColor: isDarkMode
                      ? AppColors.backgroundDark
                      : AppColors.backgroundLight,
                  body: HomeErrorView(
                    failure: state.failure,
                    onRetry: () => context.read<HomeBloc>().add(
                      const RefreshHomeDataEvent(),
                    ),
                  ),
                ),
              );
            } else if (state is HomeLoaded) {
              return SafeArea(
                child: Scaffold(
                  // floatingActionButtonLocation:

                  //     FloatingActionButtonLocation.,
                  floatingActionButton: SpeedDial(
                    // 1. BUTTERY SMOOTH ANIMATION
                    animationCurve: Curves
                        .easeOutExpo, // Gives that premium, Apple-like smooth feel
                    isOpenOnStart: false,
                    direction: SpeedDialDirection.up,

                    // 2. ELEGANT DARK OVERLAY
                    overlayColor: AppColors.primaryDark,
                    overlayOpacity: 0.65,
                    activeChild: _buildPremiumFab(
                      Iconsax.close_circle,
                      true,
                    ), // Changes to an 'X' when open
                    // 4. THE MENU ITEMS
                    children: [
                      SpeedDialChild(
                        child: const Icon(
                          Iconsax.add_circle_copy,
                          color: AppColors.primaryDark,
                          size: 22,
                        ),
                        backgroundColor: Colors
                            .white, // Crisp white creates high-end contrast
                        foregroundColor: AppColors.primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: AppColors.mintGreen.withAlpha(
                              0.6 * 255 ~/ 1,
                            ),
                            width: 1.5,
                          ), // Subtle mint border
                        ),
                        labelWidget: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildPremiumLabel(locale.addReport),
                        ),
                        elevation: 4.0,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.addReportPage,
                        ),
                      ),

                      SpeedDialChild(
                        child: const Icon(
                          Iconsax.document_text,
                          color: AppColors.primaryDark,
                          size: 22,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: AppColors.mintGreen.withAlpha(
                              0.6 * 255 ~/ 1,
                            ),
                            width: 1.5,
                          ),
                        ),
                        labelWidget: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildPremiumLabel(locale.myReports),
                        ),
                        elevation: 4.0,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.myReports,
                            arguments: state.homeData.totalTickets,
                          );
                        },
                      ),
                    ], // Darkens the background slightly to focus attention
                    // 3. CUSTOM MAIN BUTTON (The "Expensive" Look)
                    // We use a custom Container instead of the default icon to apply gradients & soft shadows
                    child: _buildPremiumFab(Iconsax.document_1_copy, false),
                  ),
                  backgroundColor: isDarkMode
                      ? AppColors.backgroundDark
                      : AppColors.backgroundLight,
                  body: BallIndicator(
                    ballColors: [
                      isDarkMode ? AppColors.primaryLight : AppColors.primary,
                    ],
                    onRefresh: () async {
                      context.read<HomeBloc>().add(
                        const RefreshHomeDataEvent(),
                      );
                      context.read<ReportsBloc>().add(
                        const LoadMyReportsEvent(),
                      );
                      await Future.delayed(const Duration(seconds: 1));
                    },
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        const HomeSliverAppBar(),

                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              const StaggeredFadeIn(
                                index: 0,
                                child: MatchesSection(),
                              ),
                              const SizedBox(height: 28),

                              const StaggeredFadeIn(
                                index: 1,
                                child: TicketsStatusChart(),
                              ),
                              const SizedBox(height: 28),

                              // StaggeredFadeIn(
                              //   index: 2,
                              //   child: QuickActionsSection(
                              //     totalreports: state.homeData.totalTickets,
                              //   ),
                              // ),
                              // const SizedBox(height: 28),
                              const StaggeredFadeIn(
                                index: 2,
                                child: RecentActivitySection(),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Scaffold(
              backgroundColor: isDarkMode
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
              body: const Center(child: LottieLoader()),
            );
          },
        ),
      ),
    );
  }

  /// Builds the glowing, gradient main FAB
  Widget _buildPremiumFab(IconData icon, bool isMain) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Rich, vibrant emerald gradient
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // 1. A soft, green-tinted drop shadow for a "floating" effect
        // 2. A diffused background glow to make it look illuminated
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(0.4 * 255 ~/ 1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.gradientStart.withAlpha(0.2 * 255 ~/ 15),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
        // A subtle white inner border to give it a "polished glass" edge
        border: Border.all(
          color: Colors.white.withAlpha(0.3 * 255 ~/ 1),
          width: 1.5,
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 26),
    );
  }

  /// Builds the floating "pill" labels for the child buttons
  Widget _buildPremiumLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Very subtle mint border to tie it to the theme
        border: Border.all(
          color: AppColors.mintGreen.withAlpha(0.5 * 255 ~/ 1),
          width: 1,
        ),
        // Soft, realistic shadow for the label itself
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(0.0 * 255 ~/ 16),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600, // Semi-bold for crisp readability
          color: AppColors.primaryDark, // Deep green text for high contrast
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
