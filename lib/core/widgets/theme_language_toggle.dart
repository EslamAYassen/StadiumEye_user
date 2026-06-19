import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';
import 'package:stadium_eye/utils/language.dart';

/// A compact floating bar shown on auth/about screens to toggle theme & language.
/// Designed to sit at the top-right corner over gradient backgrounds.
class ThemeLanguageToggle extends StatefulWidget {
  const ThemeLanguageToggle({super.key, this.lightMode = false});

  /// When true, uses white-on-dark styling (for green gradient backgrounds).
  /// When false, adapts to current theme.
  final bool lightMode;

  @override
  State<ThemeLanguageToggle> createState() => _ThemeLanguageToggleState();
}

class _ThemeLanguageToggleState extends State<ThemeLanguageToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isDark =
            state is SettingsLoaded ? state.isDarkMode : false;
        final locale =
            state is SettingsLoaded ? state.locale : AppLanguage.english;

        final bgColor = widget.lightMode
            ? Colors.white.withAlpha(30)
            : (isDark ? AppColors.cardDark : AppColors.whiteColor);

        final iconColor = widget.lightMode
            ? AppColors.whiteColor
            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);

        final borderColor = widget.lightMode
            ? Colors.white.withAlpha(60)
            : (isDark ? AppColors.borderDark : AppColors.borderLight);

        return AnimatedBuilder(
          animation: _expandAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius:
                    BorderRadius.circular(AppThemeConsts.radius24xl),
                border: Border.all(color: borderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppThemeConsts.radius24xl),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Main toggle button
                    _IconBtn(
                      icon: _isExpanded
                          ? Icons.close_rounded
                          : Iconsax.setting_2,
                      color: iconColor,
                      onTap: _toggle,
                    ),

                    // Animated expansion
                    SizeTransition(
                      sizeFactor: _expandAnimation,
                      axis: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Divider(color: borderColor),

                          // Theme toggle
                          _IconBtn(
                            icon: isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            color: iconColor,
                            onTap: () {
                              context
                                  .read<SettingsCubit>()
                                  .toggleDarkMode(!isDark);
                            },
                          ),

                          _Divider(color: borderColor),

                          // Language toggle
                          _LangBtn(
                            locale: locale,
                            color: iconColor,
                            onTap: () {
                              final next =
                                  locale == AppLanguage.english
                                      ? AppLanguage.arabic
                                      : AppLanguage.english;
                              context
                                  .read<SettingsCubit>()
                                  .changeLocale(next.code);
                            },
                          ),

                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}

class _LangBtn extends StatelessWidget {
  const _LangBtn({
    required this.locale,
    required this.color,
    required this.onTap,
  });

  final AppLanguage locale;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.language_circle, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              locale == AppLanguage.english ? 'EN' : 'AR',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 20,
      color: color,
    );
  }
}
