import 'package:flutter/material.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/custom_appbar.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/item.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/logout.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/statistics_card.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CustomAppbar(),
          SizedBox(height: 220),
          StatisticsCard(
            reports: 24,
            approved: 18,
            pending: 3,
          ), //replace API data
          SizedBox(height: 15),
          Item(title: 'Settings', icon: Icons.settings),
          Item(title: 'Help & Support', icon: Icons.help_outline),
          SizedBox(height: 10),
          LogOut(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
