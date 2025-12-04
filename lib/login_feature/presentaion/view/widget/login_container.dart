import 'package:flutter/material.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/forget_password.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/no_account.dart';
import 'package:stadium_eye/login_feature/presentaion/view/widget/signin_button.dart';
class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer>with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration:const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color:const Color.fromRGBO(118, 255, 3, 0.3),
          width: 1.5,
        ),
        boxShadow: [
         const BoxShadow(
            color: Color.fromRGBO(118, 255, 3, 0.2),
            blurRadius: 40,
            spreadRadius: 5,
          ),
         const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

         const Text(
            'Welcome Back',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),

         const SizedBox(height: 8),

          Text(
            'Sign in to continue monitoring',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),

         const SizedBox(height: 35),


         const Text(
            'Email',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B5E20),
            ),
          ),

         const SizedBox(height: 10),

          // Email Field
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
              boxShadow: [
               const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.03),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style:const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'your.email@example.com',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: Container(
                  margin:const EdgeInsets.all(12),
                  padding:const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:const Color.fromRGBO(118, 255, 3, 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Icon(Icons.email_outlined, color: Color(0xFF2E7D32), size: 20),
                ),
                border: InputBorder.none,
                contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
          ),

         const SizedBox(height: 25),

          // Password Label
         const Text(
            'Password',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B5E20),
            ),
          ),

         const SizedBox(height: 10),

          // Password Field
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
              boxShadow: [
               const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.03),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style:const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Container(
                  margin:const EdgeInsets.all(12),
                  padding:const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:const Color.fromRGBO(118, 255, 3, 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Icon(Icons.lock_outline, color: Color(0xFF2E7D32), size: 20),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey[600],
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: InputBorder.none,
                contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
          ),

         const SizedBox(height: 35),

          // Sign In Button
          const SigninButton(),

         const SizedBox(height: 20),

          // Forgot Password
         const ForgetPassword(),

         const SizedBox(height: 15),

          // Sign Up
          const NoAccount(),
        ],
      ),);
  }
}
