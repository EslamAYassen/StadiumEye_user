import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_dropdown.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_submit_button.dart';
import 'package:stadium_eye/features/report/presentation/widgets/media_section.dart';

import 'custom_text_field.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _observationsCtrl = TextEditingController();
  final _challengesCtrl = TextEditingController();
  String _stadiumCtrl = "King Fahd Stadium";
  String _areaCtrl = "North Stand";
  final List<String> _stadiums = [
    "King Fahd Stadium",
    "Al Janoub Stadium",
    "Education City Stadium",
  ];
  final List<String> _areas = [
    "North Stand",
    "South Stand",
    "East Stand",
    "West Stand",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
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
        CustomDropdown(
          title: "Select Stadium",
          value: _stadiumCtrl,
          stadiums: _stadiums,
          onChanged: (String? value) => setState(() {
            _stadiumCtrl = value ?? _stadiums[0];
          }),
          initText: "Select Stadium",
          icon: Icons.stadium_outlined,
        ),
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
        CustomDropdown(
          title: "Select Area",
          value: _areaCtrl,
          stadiums: _areas,
          onChanged: (String? value) => setState(() {
            _areaCtrl = value ?? _areas[0];
          }),
          initText: "Select Area",
          icon: Icons.area_chart,
        ),
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
          controller: _challengesCtrl,
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
    );
  }
}
