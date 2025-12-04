import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stadium_eye/features/splash_screen/presentaion/view/widget/logo_splash.dart';
class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration:const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );


    _controller.forward();


    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, "home");

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration:const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0A2E1F),
            Color(0xFF1B5E20),
            Color(0xFF2E7D32),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          ...List.generate(20, (index) {
            return Positioned(
              left: (index * 50.0) % MediaQuery.of(context).size.width,
              top: (index * 30.0) % MediaQuery.of(context).size.height,
              child:AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: 0.3 * _fadeAnimation.value,
                    child: Container(
                      width: 4 + (index % 3) * 2,
                      height: 4 + (index % 3) * 2,
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(118, 255, 3, 0.6),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(118, 255, 3, 0.5),
                            blurRadius: 10,
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

         const LogoSplash(),

        ],
      ),




    );
  }
}
