import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_state.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_app_bar_for_my_report.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_card.dart';

import '../../../../constants/app_routes.dart';

// Filter enum
enum ReportFilter { all, submitted, drafts }

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  ReportFilter _selectedFilter = ReportFilter.all;

  // Sample data - replace with your actual data
  final List<Map<String, dynamic>> _allReports = [
    {
      'stadiumName': 'King Fahd International Stadium',
      'section': 'North Stand',
      'review': 'Excellent crowd management during the match.',
      'date': 'Nov 15',
      'isSubmitted': true,
      'photoCount': 3,
    },
    {
      'stadiumName': 'Prince Faisal bin Fahd Stadium',
      'section': 'East Stand',
      'review': 'Great visibility from this section.',
      'date': 'Nov 12',
      'isSubmitted': false,
      'photoCount': 2,
    },
    {
      'stadiumName': 'King Abdullah Sports City',
      'section': 'West Stand',
      'review': 'Security personnel were well-positioned.',
      'date': 'Nov 10',
      'isSubmitted': true,
      'photoCount': 5,
    },
    {
      'stadiumName': 'Al-Awwal Park',
      'section': 'South Stand',
      'review': 'Draft report in progress.',
      'date': 'Nov 8',
      'isSubmitted': false,
      'photoCount': 1,
    },
    {
      'stadiumName': 'King Fahd International Stadium',
      'section': 'North Stand',
      'review': 'Excellent crowd management during the match.',
      'date': 'Nov 15',
      'isSubmitted': true,
      'photoCount': 3,
    },
    {
      'stadiumName': 'Prince Faisal bin Fahd Stadium',
      'section': 'East Stand',
      'review': 'Great visibility from this section.',
      'date': 'Nov 12',
      'isSubmitted': false,
      'photoCount': 2,
    },
    {
      'stadiumName': 'King Abdullah Sports City',
      'section': 'West Stand',
      'review': 'Security personnel were well-positioned.',
      'date': 'Nov 10',
      'isSubmitted': true,
      'photoCount': 5,
    },
    {
      'stadiumName': 'Al-Awwal Park',
      'section': 'South Stand',
      'review': 'Draft report in progress.',
      'date': 'Nov 8',
      'isSubmitted': false,
      'photoCount': 1,
    },
  ];

  List<Map<String, dynamic>> get _filteredReports {
    switch (_selectedFilter) {
      case ReportFilter.all:
        return _allReports;
      case ReportFilter.submitted:
        return _allReports.where((r) => r['isSubmitted'] == true).toList();
      case ReportFilter.drafts:
        return _allReports.where((r) => r['isSubmitted'] == false).toList();
    }
  }

  int get _totalReports => _allReports.length;
  int get _submittedCount =>
      _allReports.where((r) => r['isSubmitted'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBarForMyReport(totalReports: 98, monthReports: 64),
          // Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  _buildFilterChip(
                    label: 'All Reports',
                    filter: ReportFilter.all,
                  ),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                    label: 'Submitted',
                    filter: ReportFilter.submitted,
                  ),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                    label: 'Drafts',
                    filter: ReportFilter.drafts,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final report = _filteredReports[index];
              return ReportCard(
                index: index,
                stadiumName: report['stadiumName'],
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.reportDetails,
                  arguments: report,
                ),
                section: report['section'],
                review: report['review'],
                date: report['date'],
                isSubmitted: report['isSubmitted'] == true
                    ? ReportFilter.submitted
                    : ReportFilter.drafts,
                photoCount: report['photoCount'],
              );
            }, childCount: _filteredReports.length),
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

  Widget _buildFilterChip({
    required String label,
    required ReportFilter filter,
  }) {
    final isSelected = _selectedFilter == filter;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF10B981) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF10B981)
                : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
