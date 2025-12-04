import 'package:flutter/material.dart';
import 'package:stadium_eye/features/splash_screen/presentaion/view/widget/splash_screen_body.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SplashScreenBody(),
    );
  }
}