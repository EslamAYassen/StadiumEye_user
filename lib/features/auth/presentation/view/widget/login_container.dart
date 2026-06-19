import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:stadium_eye/features/auth/presentation/view/widget/forget_password.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/no_account.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signin_button.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../bloc/auth_event.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl + 6),
        border: Border.all(
          color: isDarkMode
              ? AppColors.primaryDark.withAlpha(102)
              : const Color.fromRGBO(118, 255, 3, 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? AppColors.shadowDark
                : const Color.fromRGBO(118, 255, 3, 0.2),
            blurRadius: 40,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: isDarkMode
                ? AppColors.shadowDark
                : const Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            locale.welcomeBack,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.primaryDark,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            locale.signInToContinueMonitoring,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
          ),

          const SizedBox(height: 35),

          Text(
            locale.email,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.primaryDark,
            ),
          ),

          const SizedBox(height: 10),

          // Email Field
          Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.cardElevatedDark
                  : AppColors.veryLightGray,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isDarkMode
                    ? AppColors.borderDark
                    : AppColors.borderLight,
                width: 1,
              ),
              boxShadow: isDarkMode
                  ? []
                  : [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.03),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
            ),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontSize: 15,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              decoration: InputDecoration(
                hintText: locale.emailHint,
                hintStyle: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : Colors.grey[400],
                  fontSize: 14,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.primaryDark.withAlpha(76)
                        : const Color.fromRGBO(118, 255, 3, 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Iconsax.user_copy,
                    color: isDarkMode
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                    size: 20,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Password Label
          Text(
            locale.password,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.primaryDark,
            ),
          ),

          const SizedBox(height: 10),

          // Password Field
          Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.cardElevatedDark
                  : AppColors.veryLightGray,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isDarkMode
                    ? AppColors.borderDark
                    : AppColors.borderLight,
                width: 1,
              ),
              boxShadow: isDarkMode
                  ? []
                  : [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.03),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
            ),
            child: TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: TextStyle(
                fontSize: 15,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              decoration: InputDecoration(
                hintText: locale.passwordHint,
                hintStyle: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : Colors.grey[400],
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.primaryDark.withAlpha(76)
                        : const Color.fromRGBO(118, 255, 3, 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    color: isDarkMode
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                    size: 20,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Iconsax.eye_copy
                        : Iconsax.eye_slash_copy,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark
                        : Colors.grey[600],
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
              ),
            ),
          ),

          const SizedBox(height: 35),

          // Sign In Button
          SigninButton(
            onPressed: () => context.read<AuthBloc>().add(
              LoginEvent(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Forgot Password
          const ForgetPassword(),

          const SizedBox(height: 15),

          // Sign Up
          const NoAccount(),
        ],
      ),
    );
  }
}
