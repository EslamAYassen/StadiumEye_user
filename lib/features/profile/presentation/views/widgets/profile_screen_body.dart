import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/custom_appbar.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/item.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/logout.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/statistics_card.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppbar(),
          const SizedBox(height: 220),
          const StatisticsCard(
            reports: 24,
            approved: 18,
            pending: 3,
          ), //replace API data
          const SizedBox(height: 15),
          const Item(title: 'Settings', icon: Icons.settings),
          Item(
            title: 'Help & Support',
            icon: Icons.help_outline,
            onTap: () => Navigator.pushNamed(context, AppRoutes.settingsPage),
          ),
          const SizedBox(height: 10),
          const LogOut(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
