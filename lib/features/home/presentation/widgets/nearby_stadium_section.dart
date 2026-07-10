import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/widgets/loading/lottie_loading.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';
import '../../../matches/domain/entities/matches_res.dart';
import '../../../matches/domain/entities/nearby_stadium_res.dart';
import '../../../matches/presentation/cubit/nearby_stadium_cubit.dart';

/// Standalone nearby-stadium card, kept for any context that still wants
/// the fully self-contained gradient card (its own background + border +
/// shadow). On the Home page this content now lives directly inside
/// [HomeSliverAppBar] via [NearbyStadiumContent] instead, since the
/// location preview is the hero of the app bar rather than a separate
/// section below it.
class NearbyStadiumSection extends StatefulWidget {
  const NearbyStadiumSection({super.key});

  @override
  State<NearbyStadiumSection> createState() => _NearbyStadiumSectionState();
}

class _NearbyStadiumSectionState extends State<NearbyStadiumSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyStadiumCubit, NearbyStadiumState>(
      builder: (context, state) {
        if (state.status == NearbyStadiumStatus.initial) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppThemeConsts.padding16md,
            AppThemeConsts.padding16md,
            AppThemeConsts.padding16md,
            0,
          ),
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: _NearbyStadiumCard(state: state),
            ),
          ),
        );
      },
    );
  }
}

class _NearbyStadiumCard extends StatelessWidget {
  const _NearbyStadiumCard({required this.state});
  final NearbyStadiumState state;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [AppColors.primaryDark, AppColors.primary]
              : [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
        border: Border.all(
          color: Colors.white.withAlpha((0.15 * 255).toInt()),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? AppColors.shadowDark
                : AppColors.primary.withAlpha((0.25 * 255).toInt()),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: NearbyStadiumContent(state: state),
    );
  }
}

class NearbyStadiumContent extends StatelessWidget {
  const NearbyStadiumContent({super.key, required this.state});
  final NearbyStadiumState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    switch (state.status) {
      case NearbyStadiumStatus.initial:
      case NearbyStadiumStatus.loading:
        return _StatusContent(
          loading: true,
          title: locale.nearbyStadium,
          message: locale.upcomingMatchNearYou,
        );
      case NearbyStadiumStatus.locationServiceDisabled:
        return _StatusContent(
          icon: Iconsax.gps_slash,
          title: locale.nearbyStadium,
          message: locale.locationServiceDisabledMsg,
          onRetry: () =>
              context.read<NearbyStadiumCubit>().fetchNearbyStadium(),
          retryLabel: locale.retry,
        );
      case NearbyStadiumStatus.locationPermissionDenied:
        return _StatusContent(
          icon: Iconsax.location_slash,
          title: locale.nearbyStadium,
          message: locale.locationPermissionDeniedMsg,
          onRetry: () =>
              context.read<NearbyStadiumCubit>().fetchNearbyStadium(),
          retryLabel: locale.retry,
        );
      case NearbyStadiumStatus.error:
        // return _NearbyStadiumLoadedContent(
        //   data: NearbyStadiumDataEntity(
        //     fixture: Response(
        //       fixture: Fixture(
        //         id: 12,
        //         timezone: Timezone.UTC,
        //         periods: Periods(first: 1, second: 2),
        //         venue: Venue(),
        //         status: Status(),
        //       ),
        //       league: League(id: 1),
        //       teams: Teams(
        //         home: AwayAndHomeClass(id: 1),
        //         away: AwayAndHomeClass(id: 2),
        //       ),
        //       goals: Goals(),
        //       score: Score(
        //         halftime: Goals(),
        //         fulltime: Goals(),
        //         extratime: Goals(),
        //         penalty: Goals(),
        //       ),
        //     ),
        //     stadium: StadiumProximityEntity(
        //       location: StadiumLocationEntity(name: "ss", lat: 12, lng: 12),
        //       isActive: true,
        //       distance: 12.2,
        //     ),
        //     venue: VenueDetailsEntity(id: 1, name: "name"),
        //   ),
        // );
        return _StatusContent(
          icon: Icons.error_outline,
          title: locale.nearbyStadium,
          message: state.message ?? '',
          onRetry: () =>
              context.read<NearbyStadiumCubit>().fetchNearbyStadium(),
          retryLabel: locale.retry,
        );
      case NearbyStadiumStatus.loaded:
        return _NearbyStadiumLoadedContent(data: state.data!);
    }
  }
}

class _StatusContent extends StatelessWidget {
  const _StatusContent({
    this.icon,
    this.loading = false,
    required this.title,
    required this.message,
    this.onRetry,
    this.retryLabel,
  });

  final IconData? icon;
  final bool loading;
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    // If you are using AppLocalizations, uncomment this and replace the hardcoded strings below:
    // final locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- HEADER (Matches _NearbyStadiumLoadedContent exactly) ---
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
              ),
              child: const Icon(
                Iconsax.location_copy,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearby Stadium', // Replace with locale.nearbyStadium
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Upcoming match near you', // Replace with locale.upcomingMatchNearYou
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Placeholder Status Chip to keep the header width stable
            // so it doesn't "jump" when the real data loads.
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.15 * 255).toInt()),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '--:--',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // --- BODY (The Status/Loading Content) ---
        if (loading)
          const Center(
            child: SizedBox(height: 80, width: 80, child: LottieLoader()),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                    // Subtle icon badge to match the premium feel
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white70, size: 22),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.4, // Better line height for readability
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onRetry,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.whiteColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      retryLabel ?? 'Retry',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _NearbyStadiumLoadedContent extends StatelessWidget {
  const _NearbyStadiumLoadedContent({required this.data});
  final NearbyStadiumDataEntity data;

  bool get _isLive {
    final long = data.fixture.fixture.status.long;
    return long == Long.FIRST_HALF || long == Long.SECOND_HALF;
  }

  bool get _isNotStarted {
    final long = data.fixture.fixture.status.long;
    return long == null || long == Long.NOT_STARTED;
  }

  String _statusLabel() {
    switch (data.fixture.fixture.status.long) {
      case Long.NOT_STARTED:
        return 'Not Started';
      case Long.FIRST_HALF:
        return '1st Half';
      case Long.SECOND_HALF:
        return '2nd Half';
      case Long.MATCH_FINISHED:
        return 'Finished';
      case Long.MATCH_POSTPONED:
        return 'Postponed';
      case null:
        return '';
    }
  }

  String _formatDistance(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  String _formatDateTime(DateTime? date) {
    if (date == null) return '';
    final local = date.toLocal();
    final h = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final period = local.hour >= 12 ? 'PM' : 'AM';
    final minute = local.minute.toString().padLeft(2, '0');
    return '${local.day}/${local.month}/${local.year} • $h:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final Response fixture = data.fixture;
    final league = fixture.league;
    final teams = fixture.teams;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
              ),
              child: const Icon(
                Iconsax.location_copy,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.nearbyStadium,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    locale.upcomingMatchNearYou,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            _StatusChip(
              isLive: _isLive,
              isNotStarted: _isNotStarted,
              label: _isLive
                  ? '${fixture.fixture.status.elapsed ?? ''}\''
                  : _statusLabel(),
            ),
          ],
        ),
        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(child: _TeamColumn(team: teams.home)),
            Column(
              children: [
                if (!_isNotStarted)
                  Text(
                    '${fixture.goals.home ?? 0}  -  ${fixture.goals.away ?? 0}',
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  const Text(
                    'VS',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (league.round != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    league.round!,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
            Expanded(child: _TeamColumn(team: teams.away)),
          ],
        ),
        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppThemeConsts.padding12sm,
            vertical: AppThemeConsts.padding8xs,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.12 * 255).toInt()),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Iconsax.buildings_2_copy,
                    color: AppColors.whiteColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      data.venue.name,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.2 * 255).toInt()),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_formatDistance(data.stadium.distance)} ${locale.awayFromYou}',
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (fixture.fixture.date != null) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Iconsax.calendar_1_copy,
                      color: Colors.white70,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDateTime(fixture.fixture.date),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TeamColumn extends StatelessWidget {
  const _TeamColumn({required this.team});
  final AwayAndHomeClass team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.15 * 255).toInt()),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: team.logo != null && team.logo!.isNotEmpty
                ? Image.network(
                    team.logo!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.sports_soccer,
                      color: AppColors.whiteColor,
                    ),
                  )
                : const Icon(Icons.sports_soccer, color: AppColors.whiteColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          team.name ?? '',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.isLive,
    required this.isNotStarted,
    required this.label,
  });

  final bool isLive;
  final bool isNotStarted;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isLive
            ? AppColors.redColor
            : Colors.white.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLive) ...[
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
