import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stadium_eye/features/auth/presentation/bloc/auth_event.dart';
import 'package:stadium_eye/features/auth/presentation/view/widget/signup_text.dart';
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthRegistrationSuccess) {
              return Center(
                child: OtpTextField(
                  numberOfFields: 4,
                  borderColor: Colors.lightGreen,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    BlocProvider.of<AuthBloc>(context).add(
                      VerifyEmailEvent(
                        email: _emailController.text,
                        code: verificationCode,
                      ),
                    );
                  },
                ),
              );
            }
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SignupText(),
                  const SizedBox(height: 30),

                  // First Name
                  buildTextField(
                    controller: _firstNameController,
                    label: "First Name",
                    hint: "Ahmed",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your First name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Second Name
                  buildTextField(
                    controller: _lastNameController,
                    label: "Last Name",
                    hint: "Al-Salem",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email
                  buildTextField(
                    controller: _emailController,
                    label: "Email",
                    hint: "your.email@example.com",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Phone
                  buildTextField(
                    controller: _phoneNumberController,
                    label: "Phone",
                    hint: "01xxx",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  buildGenderDropdown(),
                  const SizedBox(height: 20),

                  const Text(
                    "Date of Birth",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF022C0C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildDateOfBirth(),
                  const SizedBox(height: 20),

                  // Password
                  buildPasswordField(
                    controller: _passwordController,
                    label: "Password",
                    isHidden: hidePassword,
                    toggle: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password
                  buildPasswordField(
                    controller: _confirmPasswordController,
                    label: "Confirm Password",
                    isHidden: hideConfirmPassword,
                    toggle: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
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
                          backgroundColor: const Color(0xFF00C853),
                          foregroundColor: Colors.white,
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
                            : const Text(
                                "Create Account",
                                style: TextStyle(
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
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.login),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF00C853),
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
                        "Already have unverified account? ",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter your email"),
                              ),
                            );
                            return;
                          }
                          Navigator.pushNamed(
                            context,
                            AppRoutes.otp,
                            arguments: _emailController.text,
                          );
                        },
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                            color: Color(0xFF00C853),
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
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF022C0C),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF00C853)),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
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
              borderSide: const BorderSide(color: Color(0xFF00C853), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 2),
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
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF022C0C),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isHidden,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF00C853),
            ),
            hintText: "••••••••",
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
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
              borderSide: const BorderSide(color: Color(0xFF00C853), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isHidden
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey[600],
              ),
              onPressed: toggle,
            ),
          ),
        ),
      ],
    );
  }

  // Gender Dropdown Widget
  Widget buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF022C0C),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(15),
            border: selectedGender == null
                ? Border.all(color: Colors.transparent)
                : Border.all(color: const Color(0xFF00C853), width: 2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGender,
              isExpanded: true,
              hint: Row(
                children: [
                  const Icon(Icons.badge_outlined, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    "Select Gender",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00C853)),
              items: genders.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.badge,
                        color: Color(0xFF00C853),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        role,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF022C0C),
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
    if (_formKey.currentState!.validate()) {
      if (selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a Gender'),
            backgroundColor: Colors.red,
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

  Widget _buildDateOfBirth() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.5 * 255).toInt()),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      ),
      child: SfDateRangePicker(
        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.whiteColor,
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
      ),
    );
  }
}
