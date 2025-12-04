import 'package:flutter/material.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/app_name.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/login_container.dart';
class LogoIcon extends StatelessWidget {
  const LogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
               const SizedBox(height: 100),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration:const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:Color.fromRGBO(118, 255, 3, 0.6),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/images/logo_app.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
               const SizedBox(height: 16,),
               const AppName(),
               const SizedBox(height: 50,),
               const LoginContainer(),

              ],
            ),


          )
      ),
    );
  }
}
