import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signup_body.dart';

import '../../../../core/widgets/loading/loading_dialoge.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignupBody());
  }
}
