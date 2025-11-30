import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_form.dart';
import 'package:stadium_eye/theme/app_colors.dart';

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
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Container(
                      // margin: const EdgeInsets.(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.green.shade400,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Add Report",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const ReportForm(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
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
