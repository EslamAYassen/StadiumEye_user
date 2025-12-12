// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/constants/app_consts.dart';
// import 'package:skeletonizer/skeletonizer.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_app_bar_for_my_report.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_card.dart';

import '../../../../constants/app_routes.dart';
import '../../domain/entities/ticket_entity.dart';
import '../bloc/report_bloc.dart';
import '../bloc/report_event.dart';
import '../bloc/report_state.dart';

// Filter enum
enum ReportFilter { all, open, inProgress, resolved, closed, rejected }

// extension ReportFilterExtension on ReportFilter {
//   String get label => toString().split('.').last;
//   ReportFilter get fromName => ReportFilter.values.byName(label);
// }

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
      body: CustomScrollView(
        slivers: [
          CustomAppBarForMyReport(
            totalReports: widget.totalReports,
            monthReports: 0,
          ),
          // Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    _buildFilterChip(label: 'Open', filter: ReportFilter.open),
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

          BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              // if (state is ReportsLoading) {
              //   return const SliverToBoxAdapter(
              //     child: Center(child: LottieLoader()),
              //   );
              // }
              if (state is ReportsLoading) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: LottieLoader(),
                      ),
                    ),
                  ),
                );
              }
              if (state is ReportsLoaded) {
                final List<TicketEntity> filterdTickets =
                    _selectedFilter == ReportFilter.all
                    ? state.reports.tickets
                    : state.reports.tickets
                          .where(
                            (element) => element.status == _selectedFilter.name,
                          )
                          .toList();
                if (filterdTickets.isEmpty) {
                  return SliverToBoxAdapter(
                    //TODO: add NO data
                    child: Column(
                      children: [
                        Image.asset(AppConsts.noDataImage),
                        const SizedBox(height: 20),
                        const Text("No Data"),
                      ],
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ReportCard(
                      index: index,
                      stadiumName: filterdTickets[index].stadium.stadiumName,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.reportDetails,
                        arguments: filterdTickets[index],
                      ),
                      section: filterdTickets[index].stadium.stadiumName,
                      review: filterdTickets[index].observations,
                      date: filterdTickets[index].createdAt
                          .toIso8601String()
                          .substring(0, 10),
                      isSubmitted: ReportFilter.values.byName(
                        filterdTickets[index].status,
                      ),
                      photoCount: filterdTickets[index].ticketImages.length,
                    );
                  }, childCount: filterdTickets.length),
                );
              }
              //TODO: add NO data
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    Image.asset(AppConsts.noDataImage),
                    const SizedBox(height: 20),
                    const Text("No Data"),
                  ],
                ),
              );
            },
          ),
        ],
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
