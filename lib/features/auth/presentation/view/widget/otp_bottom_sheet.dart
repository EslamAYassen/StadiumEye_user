import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_event.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_state.dart';
import 'package:stadium_eye/theme/app_colors.dart';

/// Shows the OTP verification as a modal bottom sheet.
///
/// Usage:
/// ```dart
/// OtpBottomSheet.show(context, email: 'user@example.com');
/// ```
class OtpBottomSheet {
  OtpBottomSheet._();

  static Future<void> show(
    BuildContext context, {
    required String email,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: false, // user must verify or explicitly close
      builder: (_) => BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: _OtpBottomSheetContent(email: email),
      ),
    );
  }
}

class _OtpBottomSheetContent extends StatefulWidget {
  const _OtpBottomSheetContent({required this.email});
  final String email;

  @override
  State<_OtpBottomSheetContent> createState() =>
      _OtpBottomSheetContentState();
}

class _OtpBottomSheetContentState extends State<_OtpBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onOtpCompleted(String pin) {
    context.read<AuthBloc>().add(
          VerifyEmailEvent(email: widget.email, code: pin),
        );
  }

  void _resendCode() {
    setState(() => _isResending = true);
    context.read<AuthBloc>().add(ForgotPasswordEvent(widget.email));
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isResending = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthVerificationSuccess) {
          Navigator.of(context).pop(); // close sheet
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Verified!',
            desc: state.message,
            btnOkOnPress: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.login),
            btnOkText: 'Go to Login',
          ).show();
        } else if (state is AuthAuthenticated) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is AuthError) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: state.message,
          ).show();
        }
      },
      child: FadeTransition(
        opacity: _fadeAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: bottomPadding + 24,
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? AppColors.shadowDark
                      : AppColors.shadowLight,
                  blurRadius: 24,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.borderDark
                          : AppColors.lightGray,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Icon badge
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(76),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mark_email_read_rounded,
                    color: AppColors.whiteColor,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  'Verify Your Email',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.mediumGray,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'We sent a 4-digit code to\n'),
                      TextSpan(
                        text: widget.email,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // PIN input
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return _buildPinput(context, isDarkMode, isLoading);
                  },
                ),
                const SizedBox(height: 28),

                // Resend row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.mediumGray,
                      ),
                    ),
                    GestureDetector(
                      onTap: _isResending ? null : _resendCode,
                      child: AnimatedOpacity(
                        opacity: _isResending ? 0.4 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Close button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.mediumGray,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinput(
    BuildContext context,
    bool isDarkMode,
    bool isLoading,
  ) {
    final defaultTheme = PinTheme(
      width: 58,
      height: 64,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardElevatedDark : AppColors.lightGray,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
          width: 1.5,
        ),
      ),
    );

    final focusedTheme = defaultTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary, width: 2),
      borderRadius: BorderRadius.circular(14),
    );

    final submittedTheme = defaultTheme.copyDecorationWith(
      color: isDarkMode
          ? AppColors.primary.withAlpha(40)
          : AppColors.lightGreen,
      border: Border.all(color: AppColors.primary, width: 1.5),
      borderRadius: BorderRadius.circular(14),
    );

    if (isLoading) {
      return const SizedBox(
        height: 64,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return Pinput(
      length: 4,
      defaultPinTheme: defaultTheme,
      focusedPinTheme: focusedTheme,
      submittedPinTheme: submittedTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: _onOtpCompleted,
    );
  }
}
