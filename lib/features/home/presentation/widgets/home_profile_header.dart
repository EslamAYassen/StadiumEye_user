import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../constants/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';
import '../../../../utils/media_url_resolver.dart';
import '../../../matches/presentation/cubit/nearby_stadium_cubit.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

/// Compact profile header for the Home page: avatar + name + role, quick
/// access to notifications/settings, and a two-row "nearby stadium"
/// summary (a static promo row + a live status row driven directly by
/// [NearbyStadiumCubit]) — replacing the previous full-height hero app
/// bar with a tighter, denser layout.
class HomeProfileHeader extends StatelessWidget {
  const HomeProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [AppColors.primaryDark, AppColors.primary]
              : [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppThemeConsts.radius24xl),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final user = state is HomeLoaded ? state.homeData.user : null;
                  final avatarUrl =
                      user != null && user.profilePicture.isNotEmpty
                      ? MediaUrlResolver.resolve(user.profilePicture)
                      : null;

                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white24,
                        backgroundImage: avatarUrl != null
                            ? NetworkImage(avatarUrl)
                            : null,
                        child: avatarUrl == null
                            ? const Icon(
                                Iconsax.user,
                                color: AppColors.whiteColor,
                                size: 26,
                              )
                            : null,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.fullName ?? locale.welcomeBack,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (user != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                user.role,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      // _HeaderIconButton(
                      //   icon: Iconsax.notification_copy,
                      //   showBadge: true,
                      //   onTap: () {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         content: Text(locale.notificationsDisabled),
                      //         behavior: SnackBarBehavior.floating,
                      //       ),
                      //     );
                      //   },
                      // ),
                      // const SizedBox(width: 10),
                      _HeaderIconButton(
                        icon: Iconsax.profile_2user_copy,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.profile),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const _NearbyStadiumCompactCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.showBadge = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 22),
            if (showBadge)
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Two-row nearby-stadium summary: a static "promo" row linking to the
/// full Matches page, and a live status row reflecting
/// [NearbyStadiumCubit]'s current state (loading/permission/error/loaded).
class _NearbyStadiumCompactCard extends StatelessWidget {
  const _NearbyStadiumCompactCard();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.12 * 255).toInt()),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
        border: Border.all(
          color: Colors.white.withAlpha((0.15 * 255).toInt()),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _CompactRow(
            icon: Iconsax.location_copy,
            title: locale.nearbyStadium,
            subtitle: locale.upcomingMatchNearYou,
            trailing: _PillButton(
              label: locale.viewAll,
              onTap: () => Navigator.pushNamed(context, AppRoutes.matches),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.white.withAlpha((0.12 * 255).toInt()),
            indent: AppThemeConsts.padding16md + 40,
            endIndent: AppThemeConsts.padding16md,
          ),
          BlocBuilder<NearbyStadiumCubit, NearbyStadiumState>(
            builder: (context, state) =>
                _buildStatusRow(context, state, locale),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
    NearbyStadiumState state,
    AppLocalizations locale,
  ) {
    switch (state.status) {
      case NearbyStadiumStatus.initial:
      case NearbyStadiumStatus.loading:
        return _CompactRow(
          icon: Icons.stadium_rounded,
          title: locale.nearbyStadium,
          loading: true,
        );
      case NearbyStadiumStatus.locationServiceDisabled:
        return _CompactRow(
          icon: Icons.stadium_rounded,
          title: locale.nearbyStadium,
          subtitle: locale.locationServiceDisabledMsg,
          trailing: _RetryButton(
            label: locale.retry,
            onTap: () =>
                context.read<NearbyStadiumCubit>().fetchNearbyStadium(),
          ),
        );
      case NearbyStadiumStatus.locationPermissionDenied:
        return _CompactRow(
          icon: Icons.stadium_rounded,
          title: locale.nearbyStadium,
          subtitle: locale.locationPermissionDeniedMsg,
          trailing: _RetryButton(
            label: locale.retry,
            onTap: () =>
                context.read<NearbyStadiumCubit>().fetchNearbyStadium(),
          ),
        );
      case NearbyStadiumStatus.error:
        return _CompactRow(
          icon: Icons.stadium_rounded,
          title: locale.nearbyStadium,
          subtitle: state.message ?? '',
          trailing: _RetryButton(
            label: locale.retry,
            onTap: () =>
                context.read<NearbyStadiumCubit>().fetchNearbyStadium(),
          ),
        );
      case NearbyStadiumStatus.loaded:
        final teams = state.data!.fixture.teams;
        final home = teams.home.name ?? '';
        final away = teams.away.name ?? '';
        final distance = state.data!.stadium.distance;
        final distanceLabel = distance < 1000
            ? '${distance.round()} m'
            : '${(distance / 1000).toStringAsFixed(1)} km';
        return _CompactRow(
          icon: Icons.stadium_rounded,
          title: locale.nearbyStadium,
          subtitle: home.isNotEmpty && away.isNotEmpty
              ? '$home vs $away • $distanceLabel'
              : locale.upcomingMatchNearYou,
          onTap: () => Navigator.pushNamed(context, AppRoutes.matches),
        );
    }
  }
}

class _CompactRow extends StatelessWidget {
  const _CompactRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.loading = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool loading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppThemeConsts.padding16md,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.18 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.whiteColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (loading) ...[
                    const SizedBox(height: 4),
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ] else if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      style: TextButton.styleFrom(foregroundColor: AppColors.whiteColor),
      icon: const Icon(Icons.refresh_rounded, size: 16),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}
