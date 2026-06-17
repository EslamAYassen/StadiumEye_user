import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signup_body.dart';

import 'widget/otp_bottom_sheet.dart';

/// Thin wrapper kept for backward compatibility with [AppRoutes.otp].
/// It shows [OtpBottomSheet] immediately on top of the signup background
/// and then removes itself from the stack once the sheet closes.
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    // Show the bottom sheet right after the first frame renders so the
    // signup background is visible as a nice backdrop.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OtpBottomSheet.show(context, email: widget.email).then((_) {
        // After the sheet closes pop this transparent screen too
        if (mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provide the AuthBloc so the bottom sheet can read it
    return BlocProvider.value(
      value: context.read<AuthBloc>(),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SignupBody(), // decorative background
      ),
    );
  }
}
