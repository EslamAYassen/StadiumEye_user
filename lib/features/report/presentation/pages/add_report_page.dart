import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_form.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../core/widgets/appbar_header/appbar_header.dart';

class AddReportPage extends StatelessWidget {
  const AddReportPage({super.key, this.fromNormalNav = false});
  final bool fromNormalNav;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppbarHeader(
                isDarkMode: isDarkMode,
                title: AppLocalizations.of(context)!.addReport,
                showBackButton: fromNormalNav,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(
                  left: AppThemeConsts.padding16md,
                  right: AppThemeConsts.padding16md,
                ),
                child: ReportForm(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
