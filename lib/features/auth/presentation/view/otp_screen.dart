import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pinput/pinput.dart';
import 'package:stadium_eye/theme/app_colors.dart';

import '../../../../constants/app_routes.dart';
import '../../../../core/widgets/loading/loading_dialoge.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'widget/signup_body.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is AuthLoading) {
        //   showDialog(
        //     useSafeArea: false,
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (_) => const LoadingDialoge(),
        //   );
        // }
        if (state is AuthVerificationSuccess) {


          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Success',
            desc: state.message,
            btnOkOnPress: () => Navigator.popAndPushNamed(context, AppRoutes.login),
              btnOkText: "Back to Login"
          ).show();
        }

        if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      },
      child: Scaffold(
        body: SignupBody(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: _buildPinPut(context),
              // OtpTextField(
              //   numberOfFields: 4,
              //   borderColor: Colors.lightGreen,

              //   textStyle: Theme.of(
              //     context,
              //   ).textTheme.bodyMedium?.copyWith(color: AppColors.gradientEnd),
              //   fillColor: AppColors.gradientEnd,
              //   //set to true to show as box or false to show as dash
              //   showFieldAsBox: true,

              //   //runs when every textfield is filled
              //   onSubmit: (String verificationCode) {
              //     BlocProvider.of<AuthBloc>(
              //       context,
              //     ).add(VerifyEmailEvent(email: email, code: verificationCode));
              //   },
              // ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinPut(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.gradientEnd,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromARGB(255, 38, 255, 129)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      length: 4,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => BlocProvider.of<AuthBloc>(
        context,
      ).add(VerifyEmailEvent(email: email, code: pin)),
    );
  }
}
