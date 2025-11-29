import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_state.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_app_bar_for_my_report.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_card.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBarForMyReport(
            totalReports: 3,
            monthReports: 3,
            // onBackPressed: () {},
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return const ReportCard(
                stadiumName: "King Fahd International Stadium",
                section: "North Stand",
                review:
                    "Excellent crowd management during the match. Security personnel were well-positioned.",
                date: "Nov 15",
              );
            }, childCount: 20),
          ),
        ],
      ),
      //  BlocBuilder<ReportBloc, ReportState>(
      //   builder: (_, state) {
      //     if (state is ReportLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (state is ReportLoaded) {
      //       return ListView.builder(
      //         itemCount: state.reports.length,
      //         itemBuilder: (_, i) {
      //           final r = state.reports[i];
      //           return ListTile(
      //             title: Text(r.title),
      //             subtitle: Text(r.description),
      //           );
      //         },
      //       );
      //     }
      //     return const Center(
      //       child: ReportCard(
      //         stadiumName: 'King Fahd International Stadium',
      //         section: 'North Stand',
      //         review:
      //             'Excellent crowd management during the match. Security personnel were well-positioned.',
      //         photoCount: 1,
      //         date: 'Nov 15',
      //         isSubmitted: true,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
