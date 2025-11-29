
import 'package:flutter/material.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/forget_password.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/login_boutton.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/sign_up_boutton.dart';
class DataCard extends StatelessWidget {
  const DataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding:const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text("Welcome Back", style: TextStyle(fontSize: 20,),),),
          const SizedBox(height: 20),
          const Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 10),
          textField("your.email@example.com",const Icon(Icons.email_outlined)),
          const SizedBox(height: 25),
          const Text("Password", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          textField("••••••••", const Icon(Icons.lock_outline)),
          const SizedBox(height: 20),
          const LoginBoutton(),
          const SizedBox(height: 15),
          const ForgetPassword(),
          const SizedBox(height: 18),
          const SignUpBoutton(),
        ],
      ),
    );
  }
}
Widget textField(String hintText,Icon icon){
  return TextField(
    decoration: InputDecoration(
      hintText:hintText,
      prefixIcon: icon,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:
        BorderSide(color: Colors.grey.shade300, width: 1),
      ),
    ),
  );

}