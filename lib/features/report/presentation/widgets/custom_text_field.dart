import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.maxLines = 1,
    this.hint,
    required this.keyboardType,
    required this.controller,

    this.isPassword = false,
    this.validator,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? hint;
  final String? Function(String?)? validator;
  bool isPassword;

  late bool passwordVisible = isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.transparent),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppThemeConsts.radius16lg),
        ),
      ),
      child: TextFormField(
        validator: validator,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: passwordVisible,
        enableSuggestions: true,
        autocorrect: true,
        // textDirection: TextDirection.rtl,
        cursorColor: Colors.black,
        cursorWidth: 0.5,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppThemeConsts.radius12md),
            ),
          ),

          // focused state
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.7,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppThemeConsts.radius12md),
            ),
          ),

          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppThemeConsts.radius12md),
            ),
          ),

          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(AppThemeConsts.radius12md),
            ),
          ),

          floatingLabelAlignment: FloatingLabelAlignment.start,

          hint: Text(
            hint ?? "",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color.fromARGB(255, 150, 150, 150),
            ),
          ),

          labelStyle: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.green),
        ),
      ),
    );
  }
}
