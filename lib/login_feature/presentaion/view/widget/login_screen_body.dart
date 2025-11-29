import 'package:stadium_eye/login_feature/presentaion/view/widget/data_card.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/logo.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/title.dart';
import 'package:flutter/material.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF00C26F),
            Color(0xFF009151),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child:const SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 150),
             Logo(),
             SizedBox(height: 15),
             TitleRepot(),
             SizedBox(height: 35),
             DataCard(),
          ],
        ),
      ),
    );
  }
}

