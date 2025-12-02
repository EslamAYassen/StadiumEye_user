
import 'package:flutter/material.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/conect_information_card.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/help_support.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/logout.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/profile_header.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/settings.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/statistics_card.dart';
class ProfilescreenBody extends StatelessWidget {
  const ProfilescreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration:const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1B5E20),
            Color(0xFF2E7D32),
            Color(0xFF43A047),
            Color(0xFF66BB6A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:const SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 46),
              ProfileHeader(),
              ContactInformationCard(),
              SizedBox(height: 25),
              StatisticsCard(),
              SizedBox(height: 25),
              Settings(),
              SizedBox(height: 14),
              HelpSupport(),
              SizedBox(height: 26),
              LogoutButton(),
              SizedBox(height: 30),

            ],
          ),
        ),




      ),
    );
  }
}

