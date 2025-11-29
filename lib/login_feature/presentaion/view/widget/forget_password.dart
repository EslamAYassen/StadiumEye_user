import 'package:flutter/material.dart';
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: InkWell(
        onTap: () {},
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            color: Colors.green,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
