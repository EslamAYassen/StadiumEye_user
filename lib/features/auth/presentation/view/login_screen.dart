import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/core/widgets/loading/loading_dialoge.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/login_screen_body.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

//TODO: fix loading on OTP page
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              useSafeArea: false,
              barrierDismissible: false,
              context: context,
              builder: (_) => const LoadingDialoge(),
            );
          }

          if (state is AuthUnauthenticated) {
            if (Navigator.canPop(context)) Navigator.pop(context);
          }
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }

          if (state is AuthError) {
            if (Navigator.canPop(context)) Navigator.pop(context);
            // TODO: improve this UI
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const LoginBody(),
      ),
    );
  }
}
