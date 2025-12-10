import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_dropdown.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_submit_button.dart';
import 'package:stadium_eye/features/report/presentation/widgets/media_section.dart';

import '../bloc/report_bloc.dart';
import '../bloc/report_state.dart';
import 'custom_text_field.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _observationsCtrl = TextEditingController();
  final _challengesCtrl = TextEditingController();
  final _lessonsCtrl = TextEditingController();
  // String _stadiumCtrl = "King Fahd Stadium";
  // String _areaCtrl = "North Stand";

  final _formKey = GlobalKey<FormState>();
  String? selectedArea;
  String? selectedStadium;
  @override
  void initState() {
    context.read<ReportsBloc>().add(const LoadStadiumsEvent());
    super.initState();
  }

  @override
  void dispose() {
    _observationsCtrl.dispose();
    _challengesCtrl.dispose();
    _lessonsCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              //! Location
              const Text(
                "Location *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              if (state is StadiumsLoaded) ...[
                buildForStadiumDropdown(
                  state.stadiums.stadiums.map((e) => e.stadiumName).toList(),
                  "Stadium",
                  "Select stadium",
                ),
              ] else if (state is ReportsLoading) ...[
                const Center(child: LottieLoader()),
              ] else if (state is ReportsError) ...[
                Center(child: Text(state.message)),
              ],

              const SizedBox(height: 26),

              //! Area
              const Text(
                "Area *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              if (state is StadiumsLoaded) ...[
                buildForAreaDropdown(
                  state.stadiums.stadiums.map((e) => e.cityId).toList(),
                  "Area",
                  "Select Area",
                ),
              ] else if (state is ReportsLoading) ...[
                const Center(child: LottieLoader()),
              ] else if (state is ReportsError) ...[
                Center(child: Text(state.message)),
              ],

              const SizedBox(height: 26),

              //! Observations
              const Text(
                "Observations *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                validator: (value) => value!.isEmpty ? "Required" : null,
                keyboardType: .text,
                controller: _observationsCtrl,
                hint: "Describe your observations here...",
                maxLines: 5,
              ),
              const SizedBox(height: 26),

              //! Challenges
              const Text(
                "Challenges",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                keyboardType: .text,
                hint: "Any challenges faced...",
                controller: _challengesCtrl,
                maxLines: 4,
              ),
              const SizedBox(height: 26),

              //! Lessons Learned
              const Text(
                "Lessons Learned",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                keyboardType: .text,
                hint: "Key takeaways...",
                controller: _lessonsCtrl,
                maxLines: 4,
              ),
              const SizedBox(height: 26),
              //! Media Section
              MediaSection(
                onPhotoUpload: () {},
                onVideoUpload: () {},
                onVoiceRecord: () {},
              ),
              const SizedBox(height: 26),
              const CustomSubmitButton(),
            ],
          ),
        );
      },
    );
  }

  //TODO: move this to a separate file it's duplicated in [/signup_card.dart]
  Widget buildForAreaDropdown(List<String> items, String title, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
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
            border: selectedArea == null
                ? Border.all(color: Colors.transparent)
                : Border.all(color: const Color(0xFF00C853), width: 2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedArea,
              isExpanded: true,
              hint: Row(
                children: [
                  const Icon(Icons.badge_outlined, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(hint, style: TextStyle(color: Colors.grey[400])),
                ],
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00C853)),
              items: items.map((role) {
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
                  selectedArea = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  //TODO: move this to a separate file it's duplicated in [/signup_card.dart]
  Widget buildForStadiumDropdown(
    List<String> items,
    String title,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
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
            border: selectedStadium == null
                ? Border.all(color: Colors.transparent)
                : Border.all(color: const Color(0xFF00C853), width: 2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedStadium,
              isExpanded: true,
              hint: Row(
                children: [
                  const Icon(Icons.badge_outlined, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(hint, style: TextStyle(color: Colors.grey[400])),
                ],
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00C853)),
              items: items.map((role) {
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
                  selectedStadium = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
