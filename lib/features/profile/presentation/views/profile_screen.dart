import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_bloc.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_event.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_state.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';
import 'widgets/conect_information_card.dart';
import 'widgets/logout.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings.dart';
import 'widgets/statistics_card.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _backBtnCtrl;
  late Animation<double> _backBtnFade;
  late Animation<double> _backBtnScale;

  @override
  void initState() {
    super.initState();
    context.read<UserprofileBloc>().add(GetMyUserProfileEvent());

    _backBtnCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _backBtnFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _backBtnCtrl, curve: Curves.easeOut));
    _backBtnScale = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _backBtnCtrl, curve: Curves.elasticOut));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _backBtnCtrl.forward();
    });
  }

  @override
  void dispose() {
    _backBtnCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: BlocBuilder<UserprofileBloc, UserprofileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(
              child: SizedBox(height: 100, width: 100, child: LottieLoader()),
            );
          }
    
          if (state is UserProfileError) {
            return _ErrorView(message: state.message);
          }
    
          if (state is UserProfileLoaded) {
            final profile = state.profile;
            return Stack(
              children: [
                // ── Scrollable content ──
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // ── Hero header ──
                    SliverToBoxAdapter(
                      child: ProfileHeader(profile: profile.user),
                    ),
    
                    // ── Spacer ──
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
    
                    // ── Contact Information ──
                    SliverToBoxAdapter(
                      child: ContactInformationCard(
                        profile: profile.user,
                        animationDelay: 200,
                      ),
                    ),
    
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
    
                    // ── Statistics ──
                    SliverToBoxAdapter(
                      child: StatisticsCard(
                        data: profile,
                        animationDelay: 350,
                      ),
                    ),
    
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
    
                    // ── Section label: Account ──
                    const SliverToBoxAdapter(
                      child: _SectionLabel(label: 'Account', delay: 480),
                    ),
    
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
    
                    // ── Settings tile ──
                    const SliverToBoxAdapter(child: Settings(delay: 520)),
    
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
    
                    // // ── Help & Support tile ──
                    // const SliverToBoxAdapter(child: HelpSupport(delay: 600)),
    
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
    
                    // ── Logout ──
                    const SliverToBoxAdapter(child: LogoutButton(delay: 700)),
    
                    // ── Bottom padding ──
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                ),
    
                // ── Floating back button ──
                Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 16,
                  child: FadeTransition(
                    opacity: _backBtnFade,
                    child: ScaleTransition(
                      scale: _backBtnScale,
                      child: _BackButton(isDarkMode: isDarkMode),
                    ),
                  ),
                ),
              ],
            );
          }
    
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
          );
        },
      ),
    );
  }
}

// ── Floating back button ──
class _BackButton extends StatelessWidget {
  final bool isDarkMode;
  const _BackButton({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.whiteColor,
          size: 18,
        ),
      ),
    );
  }
}

// ── Section label widget ──
class _SectionLabel extends StatefulWidget {
  final String label;
  final int delay;
  const _SectionLabel({required this.label, this.delay = 0});

  @override
  State<_SectionLabel> createState() => _SectionLabelState();
}

class _SectionLabelState extends State<_SectionLabel>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return FadeTransition(
      opacity: _fade,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppThemeConsts.padding16md,
        ),
        child: Text(
          widget.label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: isDarkMode
                ? AppColors.textSecondaryDark
                : AppColors.mediumGray,
          ),
        ),
      ),
    );
  }
}

// ── Error state view ──
class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppThemeConsts.padding24lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.error.withAlpha(40),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 52,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              locale.loadingDataError,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(color: AppColors.mediumGray, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.read<UserprofileBloc>().add(GetMyUserProfileEvent());
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text(locale.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
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
}
