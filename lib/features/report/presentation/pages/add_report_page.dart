import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_form.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class AddReportPage extends StatelessWidget {
  const AddReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppThemeConsts.padding16md,
          right: AppThemeConsts.padding16md,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppThemeConsts.padding16md),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppThemeConsts.radius16lg,
                        ),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Add Report",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const ReportForm(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
