import 'package:flutter/material.dart';

import 'conect_information_card.dart';
import 'help_support.dart';
import 'logout.dart';
import 'profile_header.dart';
import 'settings.dart';
import 'statistics_card.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
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
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // Back button at top
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(158, 158, 158, 0.3),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFF00D856),
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 46),
              const ProfileHeader(),
              const ContactInformationCard(),
              const SizedBox(height: 25),
              const StatisticsCard(),
              const SizedBox(height: 25),
              const Settings(),
              const SizedBox(height: 14),
              const HelpSupport(),
              const SizedBox(height: 26),
              const LogoutButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
