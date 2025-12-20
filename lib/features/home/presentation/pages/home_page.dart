import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:stadium_eye/constants/app_consts.dart';
import 'package:stadium_eye/features/home/presentation/bloc/home_bloc.dart';
import 'package:stadium_eye/features/home/presentation/bloc/home_event.dart';
import 'package:stadium_eye/features/home/presentation/bloc/home_state.dart';
import 'package:stadium_eye/features/home/presentation/widgets/header_section.dart';

// import 'package:stadium_eye/features/report/presentation/widgets/recent_activity.dart';
import 'package:stadium_eye/features/home/presentation/widgets/recent_activity_section.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';

import '../../../../constants/app_routes.dart';
import '../../../../core/widgets/loading/lottie_loading.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../report/presentation/bloc/report_event.dart';
import '../../../settings/presentation/bloc/settings_cubit.dart';
import '../../home_injection.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/ball_indicator.dart';

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
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeError) {
              return SafeArea(
                child: Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        Image.asset(
                          width: 100,
                          height: 100,
                          AppConsts.errorImage,
                        ),
                        const SizedBox(height: 20),
                        Text(state.message),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => context.read<HomeBloc>().add(
                            const RefreshHomeDataEvent(),
                          ),
                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          ),
                          child: Text(AppLocalizations.of(context)!.goToSignIn),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is HomeLoaded) {
              return Scaffold(
                body: Stack(
                  children: [
                    BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        final bool isDarkMode =
                            state is SettingsLoaded && state.isDarkMode == true;
                        return _OptimizedGlassmorphicBackground(
                          imagePath: isDarkMode == false
                              ? AppConsts.stadiumLight
                              : AppConsts.stadiumDark,
                        );
                      },
                    ),

                    BallIndicator(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(
                          const RefreshHomeDataEvent(),
                        );
                        await Future.delayed(const Duration(seconds: 3));
                      },
                      child: SingleChildScrollView(
                        child: Skeletonizer(
                          enabled: state is HomeLoading,
                          child: Column(
                            children: [
                              const HeaderSection(),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30),

                                    QuickActionsSection(
                                      totalreports: state.homeData.totalTickets,
                                    ),

                                    const SizedBox(height: 60),

                                    const RecentActivitySection(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Scaffold(body: Center(child: LottieLoader()));
          },
        ),
      ),
    );
  }
}

// ALTERNATIVE: If you MUST have blur, use this more efficient version
class _OptimizedGlassmorphicBackground extends StatelessWidget {
  final String imagePath;

  const _OptimizedGlassmorphicBackground({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Pre-blurred image (blur applied once, not every frame)
            Image.asset(imagePath, fit: BoxFit.cover, cacheWidth: 1080),

            // Reduced blur intensity
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3.0, // Reduced from 8.0
                  sigmaY: 3.0, // Reduced from 8.0
                  tileMode: TileMode.clamp,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withAlpha((0.15 * 255).toInt()),
                        Colors.white.withAlpha((0.05 * 255).toInt()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
