import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

/// Floating pill-shaped bottom navigation for the Home page.
///
/// The app's navigation is route-based (each destination is a screen
/// pushed via [Navigator]) rather than a persisted tab shell, so this bar
/// behaves as a lightweight launcher: "Dashboard" reflects the current
/// screen (always the active item, since this bar only renders on Home),
/// while the other three items push their respective existing routes.
class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    // this.totalReports = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;
  // final int totalReports;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        bottomInset > 0 ? 8 : AppThemeConsts.padding16md,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: locale.dashboard,
              active: currentIndex == 0,
              onTap: () => onChanged(0),
            ),
            _NavItem(
              icon: Icons.add_circle_outline_rounded,
              label: locale.addReport,
              active: currentIndex == 1,
              onTap: () => onChanged(1),
            ),
            _NavItem(
              icon: Iconsax.document_1_copy,
              label: locale.myReports,
              active: currentIndex == 2,
              onTap: () => onChanged(2),
            ),
            _NavItem(
              icon: Iconsax.setting_2_copy,
              label: locale.settings,
              active: currentIndex == 3,
              onTap: () => onChanged(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final color = active
        ? AppColors.primary
        : (isDarkMode ? AppColors.textSecondaryDark : AppColors.mediumGray);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
