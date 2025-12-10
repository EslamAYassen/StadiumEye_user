// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_app_bar_for_my_report.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_card.dart';

import '../../../../constants/app_routes.dart';
import '../bloc/report_bloc.dart';
import '../bloc/report_event.dart';
import '../bloc/report_state.dart';

// Filter enum
enum ReportFilter { all, open, inProgress, resolved, closed, rejected }

extension ReportFilterExtension on ReportFilter {
  String get label => toString().split('.').last;
  ReportFilter get fromName => ReportFilter.values.byName(label);
}

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key, required this.totalReports});
  final int totalReports;

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  ReportFilter _selectedFilter = ReportFilter.all;
  @override
  void initState() {
    context.read<ReportsBloc>().add(const LoadMyReportsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              CustomAppBarForMyReport(
                totalReports: widget.totalReports,
                monthReports: 0,
              ),
              // Filter Chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(
                          label: 'All Reports',
                          filter: ReportFilter.all,
                        ),
                        const SizedBox(width: 12),
                        _buildFilterChip(
                          label: 'Closed',
                          filter: ReportFilter.closed,
                        ),
                        const SizedBox(width: 12),
                        _buildFilterChip(
                          label: 'In Progress',
                          filter: ReportFilter.inProgress,
                        ),
                        const SizedBox(width: 12),
                        _buildFilterChip(
                          label: 'Open',
                          filter: ReportFilter.open,
                        ),
                        const SizedBox(width: 12),
                        _buildFilterChip(
                          label: 'Rejected',
                          filter: ReportFilter.rejected,
                        ),
                        const SizedBox(width: 12),
                        _buildFilterChip(
                          label: 'Resolved',
                          filter: ReportFilter.resolved,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (state is ReportsLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ReportCard(
                          index: index,
                          stadiumName: "",
                          onTap: () {},
                          section: "",
                          review: "",
                          date: "",
                          photoCount: 0,
                        ),
                      );
                    }
                    if (state is ReportsLoaded) {
                      return Skeletonizer(
                        enabled: state is ReportsLoading,
                        child: ReportCard(
                          index: index,
                          stadiumName:
                              state.reports.tickets[index].stadium.stadiumName,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.reportDetails,
                            arguments: state.reports.tickets[index],
                          ),
                          section:
                              state.reports.tickets[index].stadium.stadiumName,
                          review: state.reports.tickets[index].observations,
                          date: state.reports.tickets[index].createdAt
                              .toIso8601String(),
                          isSubmitted: ReportFilter.values.byName(
                            state.reports.tickets[index].status,
                          ),
                          photoCount:
                              state.reports.tickets[index].ticketImages.length,
                        ),
                      );
                    }
                    //TODO: add NO data
                    return const Center(child: const Text("NO Data"));
                  },
                  childCount: state is ReportsLoaded
                      ? state.reports.tickets.length
                      : 0,
                ),
              ),
            ],
          );
        },
      ),
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
                  const BoxShadow(
                    color: Color.fromARGB(77, 16, 185, 129),
                    blurRadius: 8,
                    offset: Offset(0, 2),
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
