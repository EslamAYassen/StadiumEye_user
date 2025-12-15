import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_bloc.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_event.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_state.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';
import 'conect_information_card.dart';

import 'logout.dart';
import 'profile_header.dart';
import 'settings.dart';
import 'statistics_card.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<UserprofileBloc>().add(GetMyUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [
                  AppColors.backgroundDark,
                  AppColors.surfaceDark,
                  AppColors.cardDark,
                  AppColors.cardElevatedDark,
                ]
              : [
                  AppColors.primaryDark,
                  AppColors.primary,
                  AppColors.primaryLight,
                  AppColors.gradientStart,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<UserprofileBloc, UserprofileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(
                child: SizedBox(height: 100, width: 100, child: LottieLoader()),
              );
            }

            if (state is UserProfileError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppThemeConsts.padding16md),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.whiteColor,
                        size: 70,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.loadingDataError,
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<UserprofileBloc>().add(
                            GetMyUserProfileEvent(),
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: Text(AppLocalizations.of(context)!.retry),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppThemeConsts.radius12md,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is UserProfileLoaded) {
              final profile = state.profile;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button at top
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppThemeConsts.padding16md,
                        left: AppThemeConsts.padding16md,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.cardDark
                              : AppColors.whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? AppColors.shadowDark
                                  : const Color.fromRGBO(158, 158, 158, 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.primary,
                            size: 26,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 46),
                    ProfileHeader(profile: profile.user),
                    ContactInformationCard(profile: profile.user),
                    const SizedBox(height: 25),
                    StatisticsCard(data: profile),
                    const SizedBox(height: 25),
                    const Settings(),
                    const SizedBox(height: 14),
                    // const HelpSupport(),
                    // const SizedBox(height: 26),
                    const LogoutButton(),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
                strokeWidth: 3,
              ),
            );
          },
        ),
      ),
    );
  }
}
