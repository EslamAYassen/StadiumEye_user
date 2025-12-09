import 'package:flutter/material.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signup_card.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/text_title.dart';

class SignupIcons extends StatefulWidget {
  const SignupIcons({super.key, this.child});
  final Widget? child;

  @override
  State<SignupIcons> createState() => _SignupIconsState();
}

class _SignupIconsState extends State<SignupIcons> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(child: TextTitle2()),
            const SizedBox(height: 40),
            //TODO: fix this later
            widget.child ?? const SignupCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
