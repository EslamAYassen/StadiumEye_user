import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _observationsCtrl = TextEditingController();
  final _challengesCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          keyboardType: .text,
          labelText: 'Observations *',
          controller: _observationsCtrl,
          hint: "Describe your observations here...",
          maxLines: 5,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          keyboardType: .text,
          labelText: 'Challenges *',
          hint: "Any challenges faced...",
          controller: _challengesCtrl,
          maxLines: 5,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle form submission
          },
          child: const Text('Submit Report'),
        ),
      ],
    );
  }
}
