import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_consts.dart';
import 'package:stadium_eye/features/report/presentation/widgets/header_section.dart';

// import 'package:stadium_eye/features/report/presentation/widgets/recent_activity.dart';
import 'package:stadium_eye/features/report/presentation/widgets/recent_activity_section.dart';

import '../widgets/quick_actions_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: const Color(0xFFf5fcf8),
      body: SafeArea(
        child: Stack(
          children: [
            _GlassmorphicImage(imagePath: AppConsts.stadiumDark),

            SingleChildScrollView(
              // padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  HeaderSection(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),

                        QuickActionsSection(),

                        SizedBox(height: 60),

                        RecentActivitySection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative version with more customization
class _GlassmorphicImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const _GlassmorphicImage({
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(imagePath, width: width, height: height, fit: fit),

          // Glass Effect Layer
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(93, 255, 255, 255),
                    Color.fromARGB(34, 255, 255, 255),
                  ],
                ),
                borderRadius: BorderRadius.circular(0),
                border: Border.all(
                  color: const Color.fromARGB(51, 255, 255, 255),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
