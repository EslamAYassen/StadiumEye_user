import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';
import 'package:stadium_eye/utils/language.dart';

/// A row of two pill buttons (theme + language) designed to float
/// on top of the dark green gradient backgrounds used by the auth
/// and about-us screens.
///
/// Usage (always at the TOP of a Stack, wrapped in SafeArea):
/// ```dart
/// SafeArea(
///   child: Align(
///     alignment: Alignment.topRight,
///     child: Padding(
///       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///       child: const PreferencesBar(),
///     ),
///   ),
/// )
/// ```
class PreferencesBar extends StatelessWidget {
  const PreferencesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isDark = state is SettingsLoaded && state.isDarkMode;
        final lang = state is SettingsLoaded
            ? state.locale
            : AppLanguage.english;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeButton(isDark: isDark),
            const SizedBox(width: 10),
            _LangButton(lang: lang),
          ],
        );
      },
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// Theme toggle pill
// ──────────────────────────────────────────────────────────────────
class _ThemeButton extends StatefulWidget {
  const _ThemeButton({required this.isDark});
  final bool isDark;

  @override
  State<_ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<_ThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _scale = Tween<double>(begin: 1, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _ctrl.forward();
  void _onTapUp(_) => _ctrl.reverse();
  void _onTapCancel() => _ctrl.reverse();

  void _toggle(BuildContext context) {
    HapticFeedback.lightImpact();
    context.read<SettingsCubit>().toggleDarkMode(!widget.isDark);
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.isDark
        ? Icons.light_mode_rounded
        : Icons.dark_mode_rounded;
    final label = widget.isDark ? 'Light' : 'Dark';

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () => _toggle(context),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: _PillShell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RotationTransition(
                turns: _rotation,
                child: Icon(icon, size: 16, color: AppColors.whiteColor),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// Language toggle pill
// ──────────────────────────────────────────────────────────────────
class _LangButton extends StatefulWidget {
  const _LangButton({required this.lang});
  final AppLanguage lang;

  @override
  State<_LangButton> createState() => _LangButtonState();
}

class _LangButtonState extends State<_LangButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scale = Tween<double>(begin: 1, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _ctrl.forward();
  void _onTapUp(_) => _ctrl.reverse();
  void _onTapCancel() => _ctrl.reverse();

  void _toggle(BuildContext context) {
    HapticFeedback.selectionClick();
    final next = widget.lang == AppLanguage.english
        ? AppLanguage.arabic
        : AppLanguage.english;
    context.read<SettingsCubit>().changeLocale(next.code);
  }

  @override
  Widget build(BuildContext context) {
    final isEn = widget.lang == AppLanguage.english;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () => _toggle(context),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: _PillShell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Iconsax.language_circle,
                size: 16,
                color: AppColors.whiteColor,
              ),
              const SizedBox(width: 6),
              // Animated text swap
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.4),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                ),
                child: Text(
                  isEn ? 'EN' : 'AR',
                  key: ValueKey(widget.lang),
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              // Arrow to hint there's another option
              const Icon(
                Icons.swap_horiz_rounded,
                size: 13,
                color: Colors.white60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// Shared pill shell
// ──────────────────────────────────────────────────────────────────
class _PillShell extends StatelessWidget {
  const _PillShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
        border: Border.all(
          color: Colors.white.withAlpha(60),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
