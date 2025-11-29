import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,

    this.maxLines = 1,

    this.hint,
    required this.keyboardType,

    required this.controller,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;

  final int maxLines;
  final String? hint;

  bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool passwordVisible = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],

        borderRadius: const BorderRadius.all(
          Radius.circular(AppThemeConsts.radius16lg),
        ),
      ),
      child: TextField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
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
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.7,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppThemeConsts.radius16lg),
            ),
          ),

          floatingLabelAlignment: FloatingLabelAlignment.start,

          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(224, 224, 224, 1),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(AppThemeConsts.radius12md),
            ),
          ),
          // labelText: widget.labelText,
          hint: Text(
            widget.hint ?? "",
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
