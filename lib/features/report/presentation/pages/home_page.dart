import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/widgets/header_section.dart';

import 'package:stadium_eye/features/report/presentation/widgets/recent_activity.dart';
import 'package:stadium_eye/features/report/presentation/widgets/recent_activity_section.dart';

import '../widgets/quick_actions_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFf5fcf8),
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: EdgeInsets.all(20),
          child: Column(
            children: [
              HeaderSection(),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),

                    QuickActionsSection(),

                    SizedBox(height: 30),

                    // MyReportsButton(),
                    SizedBox(height: 30),

                    RecentActivitySection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
