import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../l10n/app_localizations.dart';

/// Quick access grid: four equal tiles (icon-in-tinted-square, title,
/// subtitle) for the most common actions — a denser, app-launcher-style
/// layout replacing the previous full-width action rows.
class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key, this.totalreports = 0});
  final int totalreports;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.quickActions,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _QuickActionTile(
                  index: 0,
                  icon: Icons.add_rounded,
                  iconColor: AppColors.primary,
                  iconBackground: isDarkMode
                      ? AppColors.primaryDark.withAlpha(76)
                      : AppColors.lightGreen,
                  title: locale.addReport,
                  subtitle: locale.reportAnIssueQuickly,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.addReportPage),
                ),
              ),
              Expanded(
                child: _QuickActionTile(
                  index: 1,
                  icon: Iconsax.document_1_copy,
                  iconColor: AppColors.info,
                  iconBackground: isDarkMode
                      ? AppColors.info.withAlpha(46)
                      : AppColors.infoLight,
                  title: locale.myReports,
                  subtitle: locale.viewSubmittedReports,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.myReports,
                    arguments: totalreports,
                  ),
                ),
              ),
              Expanded(
                child: _QuickActionTile(
                  index: 2,
                  icon: Icons.stadium_rounded,
                  iconColor: AppColors.accentPurple,
                  iconBackground: isDarkMode
                      ? AppColors.accentPurple.withAlpha(46)
                      : AppColors.accentPurpleLight,
                  title: locale.matches,
                  subtitle: locale.viewAll,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.matches),
                ),
              ),
              Expanded(
                child: _QuickActionTile(
                  index: 3,
                  icon: Iconsax.profile_2user,
                  iconColor: AppColors.warning,
                  iconBackground: isDarkMode
                      ? AppColors.warning.withAlpha(46)
                      : AppColors.warningLight,
                  title: locale.myProfile,
                  subtitle: locale.viewPersonalDataSettings,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatefulWidget {
  const _QuickActionTile({
    required this.index,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final int index;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  State<_QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<_QuickActionTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _scale = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    Future.delayed(Duration(milliseconds: 80 * widget.index), () {
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

    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.iconBackground,
                    borderRadius: BorderRadius.circular(
                      AppThemeConsts.radius16md,
                    ),
                  ),
                  child: Icon(widget.icon, color: widget.iconColor, size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.mediumGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
