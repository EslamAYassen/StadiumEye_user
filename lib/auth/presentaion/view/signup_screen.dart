import 'package:flutter/material.dart';
import 'package:stadium_eye/auth/presentaion/view/widget/signup_body.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SignupBody(),
    );
  }
}
