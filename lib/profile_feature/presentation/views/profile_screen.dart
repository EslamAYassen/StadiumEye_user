import 'package:flutter/material.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/profile_screen_body.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileScreenBody(),
    );
  }
}