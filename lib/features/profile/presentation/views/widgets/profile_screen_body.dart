import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_bloc.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_event.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_state.dart';
import 'conect_information_card.dart';
import 'help_support.dart';
import 'logout.dart';
import 'profile_header.dart';
import 'settings.dart';
import 'statistics_card.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<UserprofileBloc>().add(GetMyUserProfileEvent());
  }

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
        child: BlocBuilder<UserprofileBloc, UserprofileState>(
          builder: (context, state) {
             if (state is UserProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              );
            }

             if (state is UserProfileError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 70,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'An error occurred in loading data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<UserprofileBloc>().add(GetMyUserProfileEvent());
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2E7D32),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
             if (state is UserProfileLoaded) {
              final profile = state.profile;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button at top
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
                    ProfileHeader(profile: profile),
                    ContactInformationCard(profile: profile),
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
              );
            }

             return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            );
          },
        ),
      ),
    );
  }
}