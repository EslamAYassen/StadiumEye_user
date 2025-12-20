import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stadium_eye/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppThemeConsts.padding24lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [AppColors.primaryDark, AppColors.primary]
              : [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppThemeConsts.radius24xl),
        ),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
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
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            AppThemeConsts.radius12md,
                          ),
                        ),
                        child: const Icon(
                          Iconsax.eye,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        state is! HomeLoaded
                            ? locale.welcomeBack
                            : "${locale.welcomeBack},\n${state.homeData.user.fullName}",
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      context.read<AuthBloc>().add(const LogoutEvent());

                      context.read<SettingsCubit>().resetSettings();
                    },
                    borderRadius: BorderRadius.circular(
                      AppThemeConsts.radius12md,
                    ),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.all(
                            AppThemeConsts.padding8xs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(
                              AppThemeConsts.radius12md,
                            ),
                          ),
                          child: state is AuthLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: LottieLoader(),
                                  ),
                                )
                              : const Icon(
                                  Iconsax.logout_1_copy,
                                  color: AppColors.whiteColor,
                                  size: 32,
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StatCard(
                      title: locale.allReports,
                      value: state is! HomeLoaded
                          ? '0'
                          : "${state.homeData.totalTickets}",
                      icon: Iconsax.document_copy,
                    ),
                  ),
                  const SizedBox(width: AppThemeConsts.padding16md),
                  Expanded(
                    child: StatCard(
                      title: locale.active,
                      value: state is! HomeLoaded
                          ? '0'
                          : "${state.homeData.totalActiveUsers}",
                      icon: Iconsax.activity_copy,
                    ),
                  ),
                  const SizedBox(width: AppThemeConsts.padding16md),
                  Expanded(
                    child: StatCard(
                      title: locale.team,
                      value: state is! HomeLoaded
                          ? '0'
                          : "${state.homeData.totalTeams}",
                      icon: Iconsax.people_copy,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class StatCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scale = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  void _onTapDown(TapDownDetails d) => _controller.reverse();
  void _onTapUp(TapUpDetails d) => _controller.forward();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
              ),
              child: Column(
                children: [
                  Icon(widget.icon, color: AppColors.whiteColor, size: 26),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
