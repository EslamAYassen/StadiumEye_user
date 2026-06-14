import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class ProfileHeader extends StatefulWidget {
  final UserProfile profile;
  const ProfileHeader({super.key, required this.profile});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _entranceController;
  late AnimationController _rotateController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _avatarScale;
  late Animation<double> _avatarFade;
  late Animation<Offset> _nameSlide;
  late Animation<double> _nameFade;
  late Animation<Offset> _roleSlide;
  late Animation<double> _roleFade;
  late Animation<double> _badgeFade;
  late Animation<double> _badgeScale;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateAnimation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(_rotateController);

    _avatarScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _avatarFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _nameSlide =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.35, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    _nameFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
      ),
    );

    _roleSlide =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.5, 0.75, curve: Curves.easeOutCubic),
          ),
        );

    _roleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOut),
      ),
    );

    _badgeFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.65, 0.9, curve: Curves.easeOut),
      ),
    );

    _badgeScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.65, 0.9, curve: Curves.elasticOut),
      ),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _entranceController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppThemeConsts.padding24lg,
        AppThemeConsts.padding32xl,
        AppThemeConsts.padding24lg,
        AppThemeConsts.padding32xl,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [
                  AppColors.backgroundDark,
                  AppColors.primaryDark,
                  AppColors.primary,
                ]
              : [AppColors.primaryDark, AppColors.primary, AppColors.gradientStart],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppThemeConsts.radius24xl),
          bottomRight: Radius.circular(AppThemeConsts.radius24xl),
        ),
      ),
      child: Column(
        children: [
          // ── Avatar with animated glow ring ──
          AnimatedBuilder(
            animation: Listenable.merge([
              _pulseController,
              _entranceController,
              _rotateController,
            ]),
            builder: (context, _) {
              return FadeTransition(
                opacity: _avatarFade,
                child: ScaleTransition(
                  scale: _avatarScale,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer rotating dashed ring
                      Transform.rotate(
                        angle: _rotateAnimation.value,
                        child: CustomPaint(
                          size: const Size(120, 120),
                          painter: _DashedRingPainter(
                            color: AppColors.whiteColor.withAlpha(60),
                            strokeWidth: 1.5,
                            dashCount: 18,
                          ),
                        ),
                      ),
                      // Pulsing glow ring
                      Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.whiteColor.withAlpha(80),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gradientStart.withAlpha(120),
                                blurRadius: 24,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Avatar circle
                      Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? AppColors.cardDark
                              : AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(60),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: widget.profile.profilePicture != null &&
                                widget.profile.profilePicture!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  widget.profile.profilePicture!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Iconsax.user,
                                    size: 44,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            : const Icon(
                                Iconsax.user,
                                size: 44,
                                color: AppColors.primary,
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // ── Full Name ──
          SlideTransition(
            position: _nameSlide,
            child: FadeTransition(
              opacity: _nameFade,
              child: Text(
                widget.profile.fullName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // ── Role ──
          SlideTransition(
            position: _roleSlide,
            child: FadeTransition(
              opacity: _roleFade,
              child: Text(
                widget.profile.role,
                style: TextStyle(
                  color: AppColors.whiteColor.withAlpha(200),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Member since badge ──
          FadeTransition(
            opacity: _badgeFade,
            child: ScaleTransition(
              scale: _badgeScale,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.whiteColor.withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Iconsax.calendar_1_copy,
                      color: AppColors.whiteColor,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Member since ${widget.profile.createdAt.year}',
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Custom dashed ring painter ──
class _DashedRingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;

  const _DashedRingPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;
    final dashAngle = (2 * math.pi) / dashCount;
    final gapFraction = 0.4;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * (1 - gapFraction);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRingPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}