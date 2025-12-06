import 'package:flutter/material.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signup_card.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/text_title.dart';

class SignupIcons extends StatefulWidget {
  const SignupIcons({super.key});

  @override
  State<SignupIcons> createState() => _SignupIconsState();
}

class _SignupIconsState extends State<SignupIcons> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(child: TextTitle2()),
              SizedBox(height: 40),
              SignupCard(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
