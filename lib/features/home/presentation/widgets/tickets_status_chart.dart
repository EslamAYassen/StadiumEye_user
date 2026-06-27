import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/report/domain/entities/ticket_entity.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_state.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

/// Animated donut chart that breaks down the user's tickets by status
/// (Open / In Progress / Resolved / Closed / Rejected).
///
/// Reuses the [ReportsBloc] that is already provided/loaded on the Home
/// page, so it stays in sync with [RecentActivitySection] and friends
/// without firing any extra network calls.
class TicketsStatusChart extends StatefulWidget {
  const TicketsStatusChart({super.key});

  @override
  State<TicketsStatusChart> createState() => _TicketsStatusChartState();
}

class _TicketsStatusChartState extends State<TicketsStatusChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, int> _countByStatus(List<TicketEntity> tickets) {
    final counts = <String, int>{
      'open': 0,
      'inProgress': 0,
      'resolved': 0,
      'closed': 0,
      'rejected': 0,
    };

    for (final ticket in tickets) {
      if (counts.containsKey(ticket.status)) {
        counts[ticket.status] = counts[ticket.status]! + 1;
      }
    }

    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius24xl),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading) {
            return _buildHeader(
              isDarkMode,
              locale,
              child: const SizedBox(
                height: 180,
                child: Center(
                  child: SizedBox(height: 70, width: 70, child: LottieLoader()),
                ),
              ),
            );
          }

          final tickets = state is ReportsLoaded
              ? state.reports.tickets
              : <TicketEntity>[];
          final counts = _countByStatus(tickets);

          final segments = <_StatusSegment>[
            _StatusSegment(
              label: locale.open,
              count: counts['open']!,
              color: AppColors.success,
            ),
            _StatusSegment(
              label: locale.inProgress,
              count: counts['inProgress']!,
              color: AppColors.info,
            ),
            _StatusSegment(
              label: locale.resolved,
              count: counts['resolved']!,
              color: AppColors.primary,
            ),
            _StatusSegment(
              label: locale.closed,
              count: counts['closed']!,
              color: AppColors.warning,
            ),
            _StatusSegment(
              label: locale.rejected,
              count: counts['rejected']!,
              color: AppColors.error,
            ),
          ].where((segment) => segment.count > 0).toList();

          final total = segments.fold<int>(0, (sum, s) => sum + s.count);

          return _buildHeader(
            isDarkMode,
            locale,
            child: total == 0
                ? _buildEmptyState(isDarkMode, locale)
                : _buildChartRow(isDarkMode, locale, segments, total),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
    bool isDarkMode,
    AppLocalizations locale, {
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.primaryDark.withAlpha(76)
                    : AppColors.lightGreen,
                borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
              ),
              child: const Icon(
                Iconsax.chart_1_copy,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              locale.ticketsOverview,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        child,
      ],
    );
  }

  Widget _buildEmptyState(bool isDarkMode, AppLocalizations locale) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 26),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.pie_chart_outline,
              size: 46,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
            const SizedBox(height: 10),
            Text(
              locale.noData,
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartRow(
    bool isDarkMode,
    AppLocalizations locale,
    List<_StatusSegment> segments,
    int total,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SizedBox(
              width: 130,
              height: 130,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(130, 130),
                    painter: _DonutChartPainter(
                      values: segments.map((s) => s.count.toDouble()).toList(),
                      colors: segments.map((s) => s.color).toList(),
                      animationValue: _animation.value,
                      backgroundColor: isDarkMode
                          ? AppColors.cardElevatedDark
                          : AppColors.lightGray,
                    ),
                  ),
                  TweenAnimationBuilder<int>(
                    duration: const Duration(milliseconds: 1100),
                    curve: Curves.easeOutCubic,
                    tween: IntTween(begin: 0, end: total),
                    builder: (context, value, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$value',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          Text(
                            locale.totalReports,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: isDarkMode
                                  ? AppColors.textSecondaryDark
                                  : AppColors.mediumGray,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: segments.asMap().entries.map((entry) {
              final index = entry.key;
              final segment = entry.value;

              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 500 + index * 120),
                curve: Curves.easeOut,
                tween: Tween(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(20 * (1 - value), 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: segment.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                segment.label,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDarkMode
                                      ? AppColors.textSecondaryDark
                                      : AppColors.mediumGray,
                                ),
                              ),
                            ),
                            Text(
                              '${segment.count}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _StatusSegment {
  final String label;
  final int count;
  final Color color;

  _StatusSegment({
    required this.label,
    required this.count,
    required this.color,
  });
}

class _DonutChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final double animationValue;
  final Color backgroundColor;
  final double strokeWidth;

  _DonutChartPainter({
    required this.values,
    required this.colors,
    required this.animationValue,
    required this.backgroundColor,
    this.strokeWidth = 16,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        (size.width < size.height ? size.width : size.height) / 2 -
        strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background track
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, 0, 2 * pi, false, bgPaint);

    final total = values.fold<double>(0, (a, b) => a + b);
    if (total == 0) return;

    double startAngle = -pi / 2;
    for (int i = 0; i < values.length; i++) {
      final sweep = (values[i] / total) * 2 * pi * animationValue;
      final segmentPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, startAngle, sweep, false, segmentPaint);
      startAngle += (values[i] / total) * 2 * pi;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.values != values ||
        oldDelegate.colors != colors;
  }
}
