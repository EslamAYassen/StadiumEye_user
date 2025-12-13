// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/constants/app_consts.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/report/presentation/widgets/custom_app_bar_for_my_report.dart';
import 'package:stadium_eye/features/report/presentation/widgets/report_card.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../constants/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/ticket_entity.dart';
import '../bloc/report_bloc.dart';
import '../bloc/report_event.dart';
import '../bloc/report_state.dart';

// Filter enum
enum ReportFilter { all, open, inProgress, resolved, closed, rejected }

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          CustomAppBarForMyReport(
            totalReports: widget.totalReports,
            monthReports: 0,
          ),
          // Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppThemeConsts.padding16md,
                vertical: AppThemeConsts.padding16md,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(
                      label: locale.allReports,
                      filter: ReportFilter.all,
                    ),
                    const SizedBox(width: 12),
                    _buildFilterChip(
                      label: locale.closed,
                      filter: ReportFilter.closed,
                    ),
                    const SizedBox(width: 12),
                    _buildFilterChip(
                      label: locale.inProgress,
                      filter: ReportFilter.inProgress,
                    ),
                    const SizedBox(width: 12),
                    _buildFilterChip(
                      label: locale.open,
                      filter: ReportFilter.open,
                    ),
                    const SizedBox(width: 12),
                    _buildFilterChip(
                      label: locale.rejected,
                      filter: ReportFilter.rejected,
                    ),
                    const SizedBox(width: 12),
                    _buildFilterChip(
                      label: locale.resolved,
                      filter: ReportFilter.resolved,
                    ),
                  ],
                ),
              ),
            ),
          ),

          BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          width: 100,
                          height: 100,
                          AppConsts.noDataImage,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          locale.noData,
                          style: TextStyle(
                            color: isDarkMode
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                        ),
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

              return SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(height: 100, width: 100, AppConsts.noDataImage),
                    const SizedBox(height: 20),
                    Text(
                      locale.noData,
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
          color: isSelected
              ? AppColors.primary
              : (isDarkMode ? AppColors.cardDark : AppColors.whiteColor),
          borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDarkMode ? AppColors.borderDark : AppColors.borderLight),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(76),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColors.whiteColor
                : (isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.mediumGray),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
