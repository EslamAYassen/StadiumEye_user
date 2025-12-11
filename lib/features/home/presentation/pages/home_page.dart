// ignore_for_file: unused_element_parameter

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

import '../../../../constants/app_routes.dart';
import '../../../../core/widgets/loading/lottie_loading.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../home_injection.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/ball_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(getHomeDataUseCase: sl())..add(const LoadHomeDataEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeError) {
              return Scaffold(body: Center(child: Text(state.message)));
            } else if (state is HomeLoaded) {
              return Scaffold(
                body: Stack(
                  children: [
                    const _GlassmorphicImage(imagePath: AppConsts.stadiumDark),

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

// Alternative version with more customization
class _GlassmorphicImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const _GlassmorphicImage({
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(imagePath, width: width, height: height, fit: fit),

          // Glass Effect Layer
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(93, 255, 255, 255),
                    Color.fromARGB(34, 255, 255, 255),
                  ],
                ),
                borderRadius: BorderRadius.circular(0),
                border: Border.all(
                  color: const Color.fromARGB(51, 255, 255, 255),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
