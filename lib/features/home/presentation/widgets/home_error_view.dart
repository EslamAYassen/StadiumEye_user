import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/core/error/failures.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

/// Polished, animated, error-type-aware view shown on the Home page
/// whenever [HomeBloc] fails to load data.
///
/// Distinguishes between:
/// - [AuthFailure]: the access token expired/is invalid. AuthBloc already
///   reacts to this app-wide (see SessionExpiredNotifier) and redirects to
///   the login screen on its own, so this is mainly a graceful fallback
///   for that brief moment - a primary "Sign In" action instead of a
///   pointless retry with the same dead token.
/// - [NetworkFailure]: no internet connection.
/// - Anything else: a generic server/unknown error, with a real retry.
class HomeErrorView extends StatefulWidget {
  const HomeErrorView({super.key, required this.failure, required this.onRetry});

  final Failure failure;
  final VoidCallback onRetry;

  @override
  State<HomeErrorView> createState() => _HomeErrorViewState();
}

class _HomeErrorViewState extends State<HomeErrorView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
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
    final config = _resolveConfig(locale);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppThemeConsts.padding24lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scale,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: config.color.withAlpha((0.12 * 255).toInt()),
                ),
                child: Icon(config.icon, size: 44, color: config.color),
              ),
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _fade,
              child: Text(
                config.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _fade,
              child: Text(
                config.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ),
            const SizedBox(height: 30),
            FadeTransition(
              opacity: _fade,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: config.isAuthError
                      ? () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        )
                      : widget.onRetry,
                  icon: Icon(
                    config.isAuthError ? Icons.login_rounded : Icons.refresh_rounded,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.whiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppThemeConsts.radius16lg,
                      ),
                    ),
                  ),
                  label: Text(
                    config.isAuthError ? locale.signIn : locale.tryAgain,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            if (!config.isAuthError) ...[
              const SizedBox(height: 6),
              FadeTransition(
                opacity: _fade,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  ),
                  child: Text(
                    locale.goToSignIn,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  _ErrorViewConfig _resolveConfig(AppLocalizations locale) {
    if (widget.failure is AuthFailure) {
      return _ErrorViewConfig(
        icon: Icons.lock_outline,
        color: AppColors.warning,
        title: locale.sessionExpiredTitle,
        message: locale.sessionExpiredMessage,
        isAuthError: true,
      );
    }

    if (widget.failure is NetworkFailure) {
      return _ErrorViewConfig(
        icon: Icons.wifi_off_rounded,
        color: AppColors.error,
        title: locale.noInternetTitle,
        message: locale.noInternetMessage,
        isAuthError: false,
      );
    }

    return _ErrorViewConfig(
      icon: Icons.cloud_off_rounded,
      color: AppColors.error,
      title: locale.somethingWentWrongTitle,
      message: widget.failure.message,
      isAuthError: false,
    );
  }
}

class _ErrorViewConfig {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final bool isAuthError;

  _ErrorViewConfig({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.isAuthError,
  });
}
