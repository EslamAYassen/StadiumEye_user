import 'package:flutter/material.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/app_name.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/login_container.dart';

import '../../../../../constants/app_routes.dart';
import '../../../../../core/widgets/preferences_bar.dart';
import '../../../../../theme/app_colors.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            // SizedBox(height: 100),
            // Center(
            //   child: Container(
            //     width: 150,
            //     height: 150,
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Color.fromRGBO(118, 255, 3, 0.6),
            //           blurRadius: 30,
            //           spreadRadius: 10,
            //         ),
            //       ],
            //     ),
            //     child: ClipOval(
            //       child: Padding(
            //         padding: const EdgeInsets.all(12),
            //         child: Image.asset(
            //           'assets/images/logo_app.jpg',
            //           fit: BoxFit.fill,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _BackButton(isDarkMode: isDark),
                ),
                const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: PreferencesBar(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const AppName(),
            const SizedBox(height: 50),
            const LoginContainer(),
            const SizedBox(height: 16),
          ],
        ),
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
      onTap: () => Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.about,
        (route) => false,
      ),
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
