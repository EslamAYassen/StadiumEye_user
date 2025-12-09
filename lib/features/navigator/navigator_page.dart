import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/about_us/presentation/about_us_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/home_page.dart';
import 'package:stadium_eye/features/splash_screen/presentaion/view/splash_screen.dart';

import '../auth/presentation/bloc/auth_bloc.dart';
import '../auth/presentation/bloc/auth_state.dart';

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLodingForCheckAuthStatus || state is AuthInitial) {
          return const SplashScreen();
        } else if (state is AuthAuthenticated) {
          return const HomePage();
        } else {
          return const AboutUsPage();
        }
      },
    );
  }
}
