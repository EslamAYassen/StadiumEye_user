import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_event.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signup_text.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../core/widgets/loading/lottie_loading.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_theme_consts.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../bloc/auth_state.dart';

class SignupCard extends StatefulWidget {
  const SignupCard({super.key});

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  String? selectedGender;
  DateTime? selectedDate;

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final List<String> genders = ["male", "female"];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = args.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegistrationSuccess) {
          Navigator.pushNamed(
            context,
            AppRoutes.otp,
            arguments: state.user.email,
          );
          // Show success message
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            title: 'Success',
            desc: state.message,
          ).show();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? AppColors.shadowDark
                  : const Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SignupText(),
                  const SizedBox(height: 30),

                  // First Name
                  buildTextField(
                    isDarkMode: isDarkMode,
                    controller: _firstNameController,
                    label: locale.firstName,
                    hint: locale.ahmed,
                    icon: Iconsax.user_copy,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.pleaseEnterFirstName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Second Name
                  buildTextField(
                    isDarkMode: isDarkMode,
                    controller: _lastNameController,
                    label: locale.lastName,
                    hint: locale.alSalem,
                    icon: Iconsax.user_copy,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.pleaseEnterLastName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email
                  buildTextField(
                    isDarkMode: isDarkMode,
                    controller: _emailController,
                    label: locale.email,
                    hint: locale.emailHint,
                    icon: Iconsax.user_copy,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.pleaseEnterYourEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Phone
                  buildTextField(
                    isDarkMode: isDarkMode,
                    controller: _phoneNumberController,
                    label: locale.phone,
                    hint: locale.phoneExample,
                    icon: Iconsax.call_copy,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.pleaseEnterPhone;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  buildGenderDropdown(isDarkMode, locale),
                  const SizedBox(height: 20),

                  Text(
                    locale.dateOfBirth,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildDateOfBirth(isDarkMode),
                  const SizedBox(height: 20),

                  // Password
                  buildPasswordField(
                    isDarkMode: isDarkMode,
                    controller: _passwordController,
                    label: locale.password,
                    isHidden: hidePassword,
                    toggle: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.pleaseEnterPassword;
                      }
                      if (value.length < 6) {
                        return locale.passwordMinLength;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password
                  buildPasswordField(
                    isDarkMode: isDarkMode,
                    controller: _confirmPasswordController,
                    label: locale.confirmPassword,
                    isHidden: hideConfirmPassword,
                    toggle: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.pleaseConfirmPassword;
                      }
                      if (value != _passwordController.text) {
                        return locale.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 35),

                  // Create Account Button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: _handleSignup,
                        child: state is AuthLoading
                            ? const SizedBox(
                                width: 30,
                                height: 30,
                                child: LottieLoader(),
                              )
                            : Text(
                                locale.createAccount,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locale.alreadyHaveAccount,
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.textSecondaryDark
                              : Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.login),
                        child: Text(
                          locale.login,
                          style: TextStyle(
                            color: isDarkMode
                                ? AppColors.primaryLight
                                : AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Verify Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locale.alreadyHaveUnverifiedAccount,
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.textSecondaryDark
                              : Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(locale.pleaseEnterYourEmail),
                              ),
                            );
                            return;
                          }
                          Navigator.restorablePopAndPushNamed(
                            context,
                            AppRoutes.otp,
                            arguments: _emailController.text,
                          );
                        },
                        child: Text(
                          locale.verify,
                          style: TextStyle(
                            color: isDarkMode
                                ? AppColors.primaryLight
                                : AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Text Field Widget
  Widget buildTextField({
    required bool isDarkMode,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : Colors.grey[400],
            ),
            filled: true,
            fillColor: isDarkMode
                ? AppColors.cardElevatedDark
                : const Color(0xFFF7F7F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  // Password Field Widget
  Widget buildPasswordField({
    required bool isDarkMode,
    required TextEditingController controller,
    required String label,
    required bool isHidden,
    required VoidCallback toggle,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isHidden,
          validator: validator,
          style: TextStyle(
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock_outline,
              color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
            ),
            hintText: "••••••••",
            hintStyle: TextStyle(
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : Colors.grey[400],
            ),
            filled: true,
            fillColor: isDarkMode
                ? AppColors.cardElevatedDark
                : const Color(0xFFF7F7F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isHidden ? Iconsax.eye_copy : Iconsax.eye_slash_copy,
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : Colors.grey[600],
              ),
              onPressed: toggle,
            ),
          ),
        ),
      ],
    );
  }

  // Gender Dropdown Widget
  Widget buildGenderDropdown(bool isDarkMode, AppLocalizations locale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.gender,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppColors.cardElevatedDark
                : const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(15),
            border: selectedGender == null
                ? Border.all(color: Colors.transparent)
                : Border.all(
                    color: isDarkMode
                        ? AppColors.primaryLight
                        : AppColors.primary,
                    width: 2,
                  ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGender,
              isExpanded: true,
              dropdownColor: isDarkMode
                  ? AppColors.cardDark
                  : AppColors.whiteColor,
              hint: Row(
                children: [
                  Icon(
                    Iconsax.woman_copy,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark
                        : Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    locale.selectGender,
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.textSecondaryDark
                          : Colors.grey[400],
                    ),
                  ),
                ],
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
              ),
              items: genders.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Row(
                    children: [
                      Icon(
                        role == "male"
                            ? Icons.male_rounded
                            : Icons.female_rounded,
                        color: isDarkMode
                            ? AppColors.primaryLight
                            : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        role == "male" ? locale.male : locale.female,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDarkMode
                              ? AppColors.textPrimaryDark
                              : AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  // Handle Signup
  void _handleSignup() {
    final locale = AppLocalizations.of(context)!;

    if (_formKey.currentState!.validate()) {
      if (selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(locale.pleaseSelectGender),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(locale.pleaseSelectBirthDate),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }

    context.read<AuthBloc>().add(
      RegisterEvent(
        RegisterParams(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneNumberController.text,
          genderEn: selectedGender ?? '',
          dateOfBirth: selectedDate!.toIso8601String(),
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          //TODO: Change those
          city: '691cfbe9aad9af7504b0f29c',
          country: '691cfbe9aad9af7504b0f29c',
        ),
      ),
    );
  }

  Widget _buildDateOfBirth(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? AppColors.shadowDark
                : Colors.grey.withAlpha((0.5 * 255).toInt()),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      ),
      child: SfDateRangePicker(
        headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: isDarkMode
              ? AppColors.cardElevatedDark
              : AppColors.whiteColor,
          textStyle: TextStyle(
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: isDarkMode
            ? AppColors.cardElevatedDark
            : AppColors.whiteColor,
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: TextStyle(
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
          disabledDatesTextStyle: TextStyle(
            color: isDarkMode
                ? AppColors.textSecondaryDark.withAlpha(120)
                : AppColors.mediumGray.withAlpha(120),
          ),
        ),
        yearCellStyle: DateRangePickerYearCellStyle(
          textStyle: TextStyle(
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        selectionColor: AppColors.primary,
        todayHighlightColor: AppColors.primary,
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
      ),
    );
  }
}
