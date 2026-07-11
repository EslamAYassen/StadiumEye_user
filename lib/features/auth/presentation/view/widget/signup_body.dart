import 'package:flutter/material.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/geometriclinespainter.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signup_icons.dart';
import 'package:stadium_eye/core/widgets/preferences_bar.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key, this.child});
  final Widget? child;

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody>
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
          SignupIcons(child: widget.child),

          // ── Theme & Language buttons (top-right) ─────────────────
        ],
      ),
    );
  }
}
