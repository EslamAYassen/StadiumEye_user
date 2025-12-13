import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../auth/presentation/bloc/auth_event.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => context.read<AuthBloc>().add(const LogoutEvent()),
        icon: const Icon(Icons.logout, color: AppColors.primary),
        label: Text(
          locale.logout,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: isDarkMode
              ? AppColors.cardDark
              : AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          side: const BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeConsts.radius16md),
          ),
        ),
      ),
    );
  }
}
