import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({
    super.key,
    // required this.email,
    // required this.password,
    required this.onPressed,
  });
  // final String email;
  // final String password;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(118, 255, 3, 0.4),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: onPressed,

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: state is AuthLoading
                ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: LottieLoader(),
                  )
                : Text(
                    locale.signIn,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
