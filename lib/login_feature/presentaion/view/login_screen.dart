import 'package:flutter/material.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/login_screen_body.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:LoginBody(),
    );
  }
}