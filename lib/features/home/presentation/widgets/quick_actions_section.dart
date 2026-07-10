import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../l10n/app_localizations.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key, this.totalreports = 0});
  final int totalreports;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    // Solid, theme-matched card. The old translucent BackdropFilter/blur
    // treatment here was designed to "frost" over the stadium-photo
    // background; now that the home page uses a flat theme background,
    // a plain elevated card reads cleaner and is cheaper to render.
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.primaryDark.withAlpha(76)
                      : AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(
                    AppThemeConsts.radius12md,
                  ),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
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
            ],
          ),
          const SizedBox(height: 18),
          // _ActionButton(
          //   onTap: () =>
          //       Navigator.pushNamed(context, AppRoutes.addReportPage),
          //   textColor: AppColors.whiteColor,
          //   icon: Iconsax.add_circle_copy,
          //   gradientColors: isDarkMode
          //       ? [AppColors.primaryDark, AppColors.primary]
          //       : [AppColors.gradientStart, AppColors.gradientEnd],
          //   title: locale.addReport,
          //   subtitle: locale.reportAnIssueQuickly,
          // ),
          const SizedBox(height: 14),
          _ActionButton(
            textColor: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.myReports,
              arguments: totalreports,
            ),
            icon: Iconsax.document_1_copy,
            title: locale.myReports,
            subtitle: locale.viewSubmittedReports,
            iconColor: AppColors.primary,
            fontWeight: FontWeight.w400,
            gradientColors: isDarkMode
                ? [AppColors.cardElevatedDark]
                : [AppColors.lightGreen],
            iconBackgroundColor: isDarkMode
                ? AppColors.backgroundDark
                : AppColors.whiteColor,
            numberOfReports: totalreports,
          ),
          const SizedBox(height: 14),
          // _ActionButton(
          //   textColor: isDarkMode
          //       ? AppColors.textPrimaryDark
          //       : AppColors.textPrimaryLight,
          //   onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
          //   icon: Iconsax.profile_2user,
          //   title: locale.myProfile,
          //   subtitle: locale.viewPersonalDataSettings,
          //   iconColor: AppColors.primary,
          //   fontWeight: FontWeight.w400,
          //   gradientColors: isDarkMode
          //       ? [AppColors.cardElevatedDark]
          //       : [AppColors.veryLightGreen],
          //   iconBackgroundColor: isDarkMode
          //       ? AppColors.backgroundDark
          //       : AppColors.whiteColor,
          // ),
          // const SizedBox(height: 14),
          // _ActionButton(
          //   textColor: isDarkMode
          //       ? AppColors.textPrimaryDark
          //       : AppColors.textPrimaryLight,
          //   onTap: () => Navigator.pushNamed(context, AppRoutes.matches),
          //   icon: Icons.stadium_rounded,
          //   title: "Matches",
          //   subtitle: "View Todays matches",
          //   iconColor: AppColors.primary,
          //   fontWeight: FontWeight.w400,
          //   gradientColors: isDarkMode
          //       ? [AppColors.cardElevatedDark]
          //       : [AppColors.lightGreen],
          //   iconBackgroundColor: isDarkMode
          //       ? AppColors.backgroundDark
          //       : AppColors.whiteColor,
          // ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String subtitle;
  final Color textColor;
  final FontWeight fontWeight;
  final int? numberOfReports;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    this.iconColor = AppColors.whiteColor,
    this.iconBackgroundColor = Colors.white24,
    required this.title,
    required this.subtitle,
    required this.textColor,
    this.fontWeight = FontWeight.bold,
    this.numberOfReports,
    this.onTap,
    this.gradientColors = const [
      AppColors.gradientStart,
      AppColors.gradientEnd,
    ],
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    _scale = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              padding: const EdgeInsets.all(AppThemeConsts.padding16md),
              decoration: BoxDecoration(
                color: widget.gradientColors.length != 1
                    ? null
                    : widget.gradientColors[0],
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? AppColors.shadowDark.withAlpha(76)
                        : const Color.fromARGB(20, 0, 0, 0),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
                gradient: widget.gradientColors.length == 1
                    ? null
                    : LinearGradient(colors: widget.gradientColors),
                borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: widget.iconBackgroundColor,
                    child: Icon(widget.icon, size: 30, color: widget.iconColor),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: widget.textColor,
                            fontSize: 18,
                            fontWeight: widget.fontWeight,
                          ),
                        ),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: widget.textColor.withAlpha(178),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.numberOfReports != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.cardDark
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(
                          AppThemeConsts.radius16md,
                        ),
                      ),
                      child: Text(
                        widget.numberOfReports.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
