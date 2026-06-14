import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/user_profile_res.dart';

class StatisticsCard extends StatefulWidget {
  const StatisticsCard({super.key, required this.data, this.animationDelay = 0});
  final UserProfileResponseEntity data;
  final int animationDelay;

  @override
  State<StatisticsCard> createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );

    Future.delayed(Duration(milliseconds: widget.animationDelay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppThemeConsts.padding16md,
          ),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
            boxShadow: [
              BoxShadow(
                color:
                    isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppThemeConsts.padding16md,
                  AppThemeConsts.padding16md,
                  AppThemeConsts.padding16md,
                  0,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.primaryDark.withAlpha(60)
                            : AppColors.lightGreen,
                        borderRadius:
                            BorderRadius.circular(AppThemeConsts.radius8sm),
                      ),
                      child: const Icon(
                        Iconsax.chart_2_copy,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      locale.statistics,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Stats row ──
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppThemeConsts.padding16md,
                  0,
                  AppThemeConsts.padding16md,
                  AppThemeConsts.padding16md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatItem(
                        value: widget.data.totalTickets,
                        label: locale.totalTickets,
                        icon: Iconsax.document_copy,
                        color: AppColors.primary,
                        delay: widget.animationDelay + 100,
                      ),
                    ),
                    _VerticalDivider(),
                    Expanded(
                      child: _StatItem(
                        value: widget.data.totalActiveUsers,
                        label: locale.totalActiveUsers,
                        icon: Iconsax.people_copy,
                        color: AppColors.info,
                        delay: widget.animationDelay + 200,
                      ),
                    ),
                    _VerticalDivider(),
                    Expanded(
                      child: _StatItem(
                        value: widget.data.totalTeams,
                        label: locale.totalTeams,
                        icon: Iconsax.activity_copy,
                        color: AppColors.warning,
                        delay: widget.animationDelay + 300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 1,
      height: 60,
      color: isDarkMode
          ? AppColors.borderDark.withAlpha(80)
          : AppColors.borderLight,
    );
  }
}

class _StatItem extends StatefulWidget {
  final int value;
  final String label;
  final IconData icon;
  final Color color;
  final int delay;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.delay,
  });

  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<int> _count;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _count = IntTween(begin: 0, end: widget.value).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

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

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.color.withAlpha(30),
                  borderRadius:
                      BorderRadius.circular(AppThemeConsts.radius8sm),
                ),
                child: Icon(widget.icon, color: widget.color, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                '${_count.value}',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}