import 'package:flutter/material.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';

import '../../../../../constants/app_routes.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Center(
      child: TextButton(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.forgetPasswordPage),
        child: Text(
          locale.forgotPasswordQuestion,
          style: TextStyle(
            color: isDarkMode ? AppColors.primaryLight : AppColors.primaryDark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
