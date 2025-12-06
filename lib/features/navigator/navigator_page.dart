import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/about_us/presentation/about_us_page.dart';

import 'package:stadium_eye/features/report/presentation/pages/home_page.dart';

import '../auth/presentation/bloc/auth_bloc.dart';
import '../auth/presentation/bloc/auth_state.dart';

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const LottieLoader();
        } else if (state is AuthAuthenticated) {
          // Navigate to home page
          return const HomePage();
        } else {
          // Navigate to login page
          return const AboutUsPage();
        }
      },
    );
  }
}
