import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';

import '../../bloc/auth_event.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () =>
            context.read<AuthBloc>().add(ForgotPasswordEvent(email)),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
