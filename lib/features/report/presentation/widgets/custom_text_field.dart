import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.iconColor = Colors.green,
    this.maxLines = 1,
    this.icon,
    this.hint,
    required this.keyboardType,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final Color iconColor;
  final int maxLines;
  final String? hint;
  final IconData? icon;
  bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool passwordVisible = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.8,
            ),
          ),
          prefixIcon: Icon(widget.icon, color: widget.iconColor),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Iconsax.eye_slash : Iconsax.eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // labelText: widget.labelText,
          hint: Text(
            widget.hint ?? "",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black54,
              fontStyle: FontStyle.italic,
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
