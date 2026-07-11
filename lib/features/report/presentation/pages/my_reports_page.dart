// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  const MyReportsPage({super.key, this.fromNormalNav = false});
  final bool fromNormalNav;

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  ReportFilter _selectedFilter = ReportFilter.all;
  late final PagingController<int, TicketEntity> _pagingController;
  Completer<List<TicketEntity>>? _currentCompleter;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, TicketEntity>(
      getNextPageKey: (state) {
        // If last page is empty or has less than 20 items, it's the last page
        if (state.lastPageIsEmpty || (state.items?.length ?? 0) % 20 != 0) {
          return null;
        }
        return state.nextIntPageKey;
      },
      fetchPage: (pageKey) => _fetchPage(pageKey),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _currentCompleter?.completeError('Widget disposed');
    super.dispose();
  }

  Future<List<TicketEntity>> _fetchPage(int pageKey) async {
    _currentCompleter = Completer<List<TicketEntity>>();

    // Trigger the event to load reports with pagination and filter
    context.read<ReportsBloc>().add(
      LoadMyReportsEvent(
        page: pageKey,
        status: _selectedFilter == ReportFilter.all
            ? null
            : _selectedFilter.name,
      ),
    );

    return _currentCompleter!.future;
  }

  void _onFilterChanged(ReportFilter newFilter) {
    setState(() {
      _selectedFilter = newFilter;
    });
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: BlocListener<ReportsBloc, ReportsState>(
        listener: (context, state) {
          if (state is ReportsLoaded) {
            final items = state.reports.tickets;

            // Complete the future with the fetched items
            if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
              _currentCompleter!.complete(items);
              _currentCompleter = null;
            }
          } else if (state is ReportsError) {
            // Complete the future with an error
            if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
              _currentCompleter!.completeError(state.message);
              _currentCompleter = null;
            }
          }
        },
        child: PagingListener<int, TicketEntity>(
          controller: _pagingController,
          builder: (context, state, fetchNextPage) {
            return CustomScrollView(
              slivers: [
                CustomAppBarForMyReport(
                  showBackButton: widget.fromNormalNav,
                  totalReports: state.items?.length ?? 0,
                  // widget.totalReports,
                  monthReports: state.items?.length ?? 0,
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

                // Paged List
                PagedSliverList<int, TicketEntity>(
                  state: state,
                  fetchNextPage: fetchNextPage,
                  builderDelegate: PagedChildBuilderDelegate<TicketEntity>(
                    itemBuilder: (context, item, index) => ReportCard(
                      index: index,
                      stadiumName: item.stadium.stadiumName,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.reportDetails,
                        arguments: item,
                      ),
                      section: item.stadium.stadiumName,
                      review: item.observations,
                      date: item.createdAt.toIso8601String().substring(0, 10),
                      isSubmitted: ReportFilter.values.byName(item.status),
                      photoCount: item.ticketImages.length,
                    ),
                    firstPageErrorIndicatorBuilder: (context) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error?.toString() ?? locale.noData,
                              style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _pagingController.refresh(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.whiteColor,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ),
                    firstPageProgressIndicatorBuilder: (context) =>
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: LottieLoader(),
                            ),
                          ),
                        ),
                    newPageProgressIndicatorBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: LottieLoader(),
                        ),
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Failed to load more',
                              style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => fetchNextPage(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.whiteColor,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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
      onTap: () => _onFilterChanged(filter),
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
