import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/report/domain/entities/report_entity.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_state.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_form.dart';

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
    return const Scaffold(
      backgroundColor: Color(0xFFf5fcf8),
      body: Padding(padding: EdgeInsets.all(20.0), child: ReportForm()),
    );
    // Scaffold(
    //   body: BlocProvider(
    //     create: (_) => context.read<ReportBloc>(),
    //     child: BlocConsumer<ReportBloc, ReportState>(
    //       listener: (_, state) {
    //         if (state is ReportCreated) {
    //           ScaffoldMessenger.of(
    //             context,
    //           ).showSnackBar(const SnackBar(content: Text("Report created")));
    //           Navigator.pop(context);
    //         }
    //       },
    //       builder: (_, state) {
    //         if (state is ReportLoading) {
    //           return const Center(child: CircularProgressIndicator());
    //         }

    //         return Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Column(
    //             children: [
    //               const ReportForm(),
    //               const SizedBox(height: 20),

    //               ElevatedButton(
    //                 onPressed: () {
    //                   final report = ReportEntity(
    //                     stadiumId: "uuid-stadium-123",
    //                     ticketType: "Issue",
    //                     title: titleCtrl.text,
    //                     description: descCtrl.text,
    //                     priority: "High",
    //                     visibility: "Public",
    //                     location: {"section": "A", "row": "5", "seat": "12"},
    //                     manualEntry: {"name": "Ahmed", "email": "a@ex.com"},
    //                   );

    //                   context.read<ReportBloc>().add(CreateReportEvent(report));
    //                 },
    //                 child: const Text("Submit"),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
