import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/report/domain/entities/report_entity.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_state.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Report")),

      body: BlocConsumer<ReportBloc, ReportState>(
        listener: (_, state) {
          if (state is ReportCreated) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Report created")));
            Navigator.pop(context);
          }
        },
        builder: (_, state) {
          if (state is ReportLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: "Description"),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    final report = ReportEntity(
                      stadiumId: "uuid-stadium-123",
                      ticketType: "Issue",
                      title: titleCtrl.text,
                      description: descCtrl.text,
                      priority: "High",
                      visibility: "Public",
                      location: {"section": "A", "row": "5", "seat": "12"},
                      manualEntry: {"name": "Ahmed", "email": "a@ex.com"},
                    );

                    context.read<ReportBloc>().add(CreateReportEvent(report));
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
