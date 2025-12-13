import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';
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
    this.onTapOutside,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool isPassword;

  late bool passwordVisible = isPassword;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      ),
      child: TextFormField(
        onTapOutside: onTapOutside,
        autovalidateMode: AutovalidateMode.onUnfocus,
        validator: validator,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: passwordVisible,
        enableSuggestions: true,
        autocorrect: true,
        cursorColor: AppColors.primary,
        cursorWidth: 0.5,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary, width: 1.7),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
            ),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.error, width: 1.0),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: hint ?? "",
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDarkMode
                ? AppColors.textSecondaryDark
                : AppColors.mediumGray,
          ),
          labelStyle: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
