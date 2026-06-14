import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../../l10n/app_localizations.dart';

/// A reusable animated action tile used for Settings, Help, etc.
class ProfileActionTile extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final int delay;
  final Widget? trailing;

  const ProfileActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.primary,
    this.iconBg = AppColors.lightGreen,
    this.subtitle,
    this.delay = 0,
    this.trailing,
  });

  @override
  State<ProfileActionTile> createState() => _ProfileActionTileState();
}

class _ProfileActionTileState extends State<ProfileActionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceCtrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut),
    );
    _slide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic),
        );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _entranceCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) {
            setState(() => _pressed = false);
            widget.onTap();
          },
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppThemeConsts.padding16md,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppThemeConsts.padding16md,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
                borderRadius:
                    BorderRadius.circular(AppThemeConsts.radius16lg),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? AppColors.shadowDark
                        : AppColors.shadowLight,
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.primaryDark.withAlpha(60)
                          : widget.iconBg,
                      borderRadius:
                          BorderRadius.circular(AppThemeConsts.radius12md),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.iconColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            widget.subtitle!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode
                                  ? AppColors.textSecondaryDark
                                  : AppColors.mediumGray,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  widget.trailing ??
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.mediumGray,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Settings tile – navigates to settings page
class Settings extends StatelessWidget {
  const Settings({super.key, this.delay = 0});
  final int delay;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ProfileActionTile(
      icon: Iconsax.setting_2_copy,
      title: locale.settings,
      subtitle: locale.appearance,
      delay: delay,
      onTap: () => Navigator.pushNamed(context, AppRoutes.settingsPage),
    );
  }
}

/// Help & Support tile
class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key, this.delay = 0});
  final int delay;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ProfileActionTile(
      icon: Icons.help_outline_rounded,
      title: locale.helpAndSupport,
      delay: delay,
      onTap: () {},
    );
  }
}