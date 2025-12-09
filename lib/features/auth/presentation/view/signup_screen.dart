// signup_screen.dart
import 'package:flutter/material.dart';

import 'package:stadium_eye/features/auth/presentation/view/widget/signup_body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignupBody());
  }
}
