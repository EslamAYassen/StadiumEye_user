import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/pages/add_report_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddReportPage()),
            );
          },
          child: const Text("Add Report"),
        ),
      ),
    );
  }
}
