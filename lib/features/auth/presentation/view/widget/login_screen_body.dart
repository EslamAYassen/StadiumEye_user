import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/geometriclinespainter.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/logo_icon.dart';
import 'package:stadium_eye/core/widgets/preferences_bar.dart';

import '../../../../../theme/app_colors.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A2E1F), Color(0xFF1B5E20), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // ── Glowing particles ────────────────────────────────────
          ...List.generate(30, (index) {
            return Positioned(
              left: (index * 60.0) % MediaQuery.of(context).size.width,
              top: (index * 40.0) % MediaQuery.of(context).size.height,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: (0.2 + (index % 3) * 0.1) * _fadeAnimation.value,
                    child: Container(
                      width: 3 + (index % 4) * 1.5,
                      height: 3 + (index % 4) * 1.5,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF76FF03),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(118, 255, 3, 0.6),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          // ── Geometric lines ──────────────────────────────────────
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: GeometricLinesPainter(animation: _fadeAnimation),
          ),

          // ── Main content ─────────────────────────────────────────
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.bottomSlide,
                  title: 'ERROR',
                  desc: state.message,
                ).show();
              }
            },
            child: const LogoIcon(),
          ),

          // ── Theme & Language buttons (top-right) ─────────────────
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 12, right: 16),
                  child: PreferencesBar(),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: _BackButton(isDarkMode: isDark),
          ),
        ],
      ),
    );
  }
}

// ── Floating back button ──
class _BackButton extends StatelessWidget {
  final bool isDarkMode;
  const _BackButton({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.whiteColor,
          size: 18,
        ),
      ),
    );
  }
}
