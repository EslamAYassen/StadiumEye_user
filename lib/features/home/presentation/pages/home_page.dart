import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stadium_eye/features/home/presentation/bloc/home_bloc.dart';
import 'package:stadium_eye/features/home/presentation/bloc/home_event.dart';
import 'package:stadium_eye/features/home/presentation/bloc/home_state.dart';
import 'package:stadium_eye/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:stadium_eye/features/home/presentation/widgets/home_profile_header.dart';
import 'package:stadium_eye/features/matches/presentation/cubit/nearby_stadium_cubit.dart';

import 'package:stadium_eye/features/home/presentation/widgets/recent_activity_section.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_bloc.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_event.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/report/presentation/pages/add_report_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/my_reports_page.dart';

import '../../../../constants/app_routes.dart';
import '../../../../core/widgets/loading/lottie_loading.dart';
import '../../../../theme/app_colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../report/presentation/bloc/report_event.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../widgets/home_error_view.dart';
import '../widgets/matches_section.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/ball_indicator.dart';
import '../widgets/staggered_fade_in.dart';
import '../widgets/tickets_status_chart.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int currentIndex = 0;

  final _pages = const [
    HomePage(),
    AddReportPage(),
    MyReportsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BallIndicator(
        ballColors: [AppColors.primaryLight],
        onRefresh: () async {
          context.read<HomeBloc>().add(const RefreshHomeDataEvent());
          context.read<ReportsBloc>().add(const RefreshMyReportsEvent());
          context.read<UserprofileBloc>().add(GetMyUserProfileEvent());
          context.read<NearbyStadiumCubit>().fetchNearbyStadium();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: IndexedStack(index: currentIndex, children: _pages),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: currentIndex,
        onChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NearbyStadiumCubit>().fetchNearbyStadium();
    context.read<HomeBloc>().add(const LoadHomeDataEvent());
    context.read<ReportsBloc>().add(const LoadMyReportsEvent());
    context.read<UserprofileBloc>().add(GetMyUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;

          if (state is HomeError) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: isDarkMode
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
                body: HomeErrorView(
                  failure: state.failure,
                  onRetry: () {
                    context.read<HomeBloc>().add(const RefreshHomeDataEvent());
                    context.read<ReportsBloc>().add(const LoadMyReportsEvent());
                  },
                ),
              ),
            );
          } else if (state is HomeLoaded) {
            return Scaffold(
              backgroundColor: isDarkMode
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
              extendBody: true,
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: HomeProfileHeader()),

                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        StaggeredFadeIn(
                          index: 2,
                          child: QuickActionsSection(
                            totalreports: state.homeData.totalTickets,
                          ),
                        ),
                        const SizedBox(height: 28),

                        const StaggeredFadeIn(
                          index: 0,
                          child: MatchesSection(),
                        ),
                        const SizedBox(height: 28),

                        // The ticket status donut chart serves as the
                        // home page's single source of summary data.
                        const StaggeredFadeIn(
                          index: 1,
                          child: TicketsStatusChart(),
                        ),
                        const SizedBox(height: 28),

                        const StaggeredFadeIn(
                          index: 3,
                          child: RecentActivitySection(),
                        ),
                      ]),
                    ),
                  ),
                ],
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
    );
  }
}
