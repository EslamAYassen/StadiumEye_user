import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_form.dart';
import 'package:stadium_eye/theme/app_colors.dart';

class AddReportPage extends StatelessWidget {
  const AddReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.green.shade400,
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
