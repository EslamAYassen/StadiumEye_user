import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_state.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Reports")),

      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (_, state) {
          if (state is ReportLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ReportLoaded) {
            return ListView.builder(
              itemCount: state.reports.length,
              itemBuilder: (_, i) {
                final r = state.reports[i];
                return ListTile(
                  title: Text(r.title),
                  subtitle: Text(r.description),
                );
              },
            );
          }

          return Center(
            child: ElevatedButton(
              child: const Text("Load Reports"),
              onPressed: () {
                context.read<ReportBloc>().add(GetMyReportsEvent());
              },
            ),
          );
        },
      ),
    );
  }
}
