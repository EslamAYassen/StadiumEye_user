import 'package:flutter/material.dart';
import 'package:stadium_eye/features/splash_screen/presentaion/view/widget/glowing_circle.dart';
import 'package:stadium_eye/features/splash_screen/presentaion/view/widget/glowing_eye.dart';
import 'package:stadium_eye/features/splash_screen/presentaion/view/widget/name_app.dart';
class LogoSplash extends StatefulWidget {
  const LogoSplash({super.key});

  @override
  State<LogoSplash> createState() => _LogoSplashState();
}

class _LogoSplashState extends State<LogoSplash>with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration:const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();



  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration:const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.fromRGBO(118, 255, 3, 0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                       const GlowingCircle(),
                        const GlowingEye(),
                        // glowing lines
                        ...List.generate(8, (index) {
                          final angle = (index * 45.0) * 3.14159 / 180;
                          return Transform.rotate(
                            angle: angle,
                            child: Container(
                              width: 2,
                              height: 100,
                              margin:const EdgeInsets.only(bottom: 150),
                              decoration:const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(118, 255, 3, 0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),


                      ],
                    ),
                  ),

                ),
              ),
            );

          },),


      ),
        Positioned(
          bottom: screenHeight * 0.08,
          left: 0,
          right: 0,
          child: const Center(
            child: NameApp(),),
        ),
      ],
    );

  }
}
