import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';
import '../../domain/entities/matches_res.dart';

class MatchCard extends StatefulWidget {
  const MatchCard({super.key, required this.match});
  final Response match;

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final locale = AppLocalizations.of(context)!;
    return SlideTransition(
      position: _slide,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppThemeConsts.padding12sm),
        padding: const EdgeInsets.all(AppThemeConsts.padding16md),
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.darkGray.withAlpha((0.5 * 255) ~/ 1)
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          border: Border.all(
            color: isDarkMode
                ? AppColors.lightGray.withAlpha((0.1 * 255) ~/ 1)
                : AppColors.lightGray,
          ),
          boxShadow: isDarkMode
              ? []
              : [
                  BoxShadow(
                    color: AppColors.blackColor.withAlpha((0.05 * 255) ~/ 1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTeam(
                  widget.match.teams.home.name ?? '',
                  widget.match.teams.home.logo ?? '',
                  true,
                  isDarkMode,
                ),
                _buildMatchScore(widget.match, isDarkMode),
                _buildTeam(
                  widget.match.teams.away.name ?? '',
                  widget.match.teams.away.logo ?? '',
                  false,
                  isDarkMode,
                ),
              ],
            ),
            const SizedBox(height: AppThemeConsts.padding12sm),
            _buildMatchInfo(widget.match, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildTeam(String name, String logo, bool isHome, bool isDarkMode) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.lightGray.withAlpha((0.1 * 255) ~/ 1)
                  : AppColors.lightGray,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode
                    ? AppColors.lightGray.withAlpha((0.2 * 255) ~/ 1)
                    : AppColors.lightGray,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: logo,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) {
                  return Icon(
                    Icons.sports_soccer,
                    color: isDarkMode
                        ? AppColors.whiteColor.withAlpha((0.5 * 255) ~/ 1)
                        : AppColors.primary,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: AppThemeConsts.padding8xs),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isDarkMode ? AppColors.whiteColor : AppColors.darkGray,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchScore(Response match, bool isDarkMode) {
    final status = match.fixture.status.short;
    final isLive =
        status?.name == 'HT' || status?.name == '1H' || status?.name == '2H';
    final bool isNotStarted = status?.name == 'NS' || status?.name == 'TBD';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
        vertical: AppThemeConsts.padding8xs,
      ),
      child: Column(
        children: [
          if (isNotStarted)
            Column(
              children: [
                Text(
                  '-  -  -',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor.withAlpha((0.5 * 255) ~/ 1)
                        : AppColors.darkGray.withAlpha((0.5 * 255) ~/ 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (match.fixture.date ?? DateTime.now())
                      .toIso8601String()
                      .split('T')[1]
                      .substring(0, 5),
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor.withAlpha((0.7 * 255) ~/ 1)
                        : AppColors.darkGray,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${match.goals.home ?? 0}',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.darkGray,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.whiteColor.withAlpha((0.5 * 255) ~/ 1)
                          : AppColors.darkGray.withAlpha((0.5 * 255) ~/ 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${match.goals.away ?? 0}',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.darkGray,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (isLive)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.redColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${match.fixture.status.elapsed}\'',
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMatchInfo(Response match, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding12sm,
        vertical: AppThemeConsts.padding8xs,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.primary.withAlpha((0.1 * 255) ~/ 1)
            : AppColors.lightGreen,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius8sm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 16,
            color: isDarkMode
                ? AppColors.primary.withAlpha((0.9 * 255) ~/ 1)
                : AppColors.primary,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              match.fixture.venue.name ?? 'Unknown Venue',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.primary.withAlpha((0.9 * 255) ~/ 1)
                    : AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
