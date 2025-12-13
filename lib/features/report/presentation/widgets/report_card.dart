import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../pages/my_reports_page.dart';

class ReportCard extends StatefulWidget {
  final String stadiumName;
  final String section;
  final String review;
  final int photoCount;
  final String date;
  final ReportFilter isSubmitted;
  final int index;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.stadiumName,
    required this.onTap,
    required this.section,
    required this.review,
    this.photoCount = 1,
    required this.date,
    this.isSubmitted = ReportFilter.all,
    this.index = 0,
  });

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600 + (widget.index * 100)),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(AppThemeConsts.padding16md),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? AppColors.shadowDark
                      : AppColors.shadowLight,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppThemeConsts.padding16md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with stadium name and status
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween(begin: 0.0, end: 1.0),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 600),
                          tween: Tween(begin: 0.0, end: 1.0),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(-20 * (1 - value), 0),
                                child: Text(
                                  widget.stadiumName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (widget.isSubmitted == ReportFilter.resolved) ...[
                        _statCard(
                          AppColors.successLight,
                          AppColors.success,
                          AppColors.successDark,
                          'Resolved',
                          Icons.check_rounded,
                        ),
                      ] else if (widget.isSubmitted == ReportFilter.closed) ...[
                        _statCard(
                          AppColors.warningLight,
                          AppColors.warning,
                          AppColors.warningDark,
                          'Closed',
                          Icons.close_rounded,
                        ),
                      ] else if (widget.isSubmitted ==
                          ReportFilter.inProgress) ...[
                        _statCard(
                          AppColors.infoLight,
                          AppColors.info,
                          AppColors.infoDark,
                          'In Progress',
                          Icons.timelapse_rounded,
                        ),
                      ] else if (widget.isSubmitted == ReportFilter.open) ...[
                        _statCard(
                          AppColors.successLight,
                          AppColors.success,
                          AppColors.primary,
                          'Open',
                          Icons.file_open_rounded,
                        ),
                      ] else if (widget.isSubmitted ==
                          ReportFilter.rejected) ...[
                        _statCard(
                          AppColors.errorLight,
                          AppColors.error,
                          AppColors.errorDark,
                          'Rejected',
                          Icons.close_rounded,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Section name
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 700),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 10 * (1 - value)),
                            child: Text(
                              widget.section,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? AppColors.textSecondaryDark
                                    : AppColors.mediumGray,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Review text
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 10 * (1 - value)),
                            child: Text(
                              widget.review,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode
                                    ? AppColors.textSecondaryDark
                                    : AppColors.mediumGray,
                                height: 1.5,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Photo indicator
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 900),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.cardElevatedDark
                                      : AppColors.lightGray,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  Icons.image,
                                  size: 18,
                                  color: isDarkMode
                                      ? AppColors.textSecondaryDark
                                      : AppColors.mediumGray,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '+${widget.photoCount}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode
                                      ? AppColors.textSecondaryDark
                                      : AppColors.mediumGray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Divider(
                          thickness: 0.8,
                          color: isDarkMode
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Footer with date and view details
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1100),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 10 * (1 - value)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                      color: isDarkMode
                                          ? AppColors.textSecondaryDark
                                          : AppColors.mediumGray,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.date,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode
                                            ? AppColors.textSecondaryDark
                                            : AppColors.mediumGray,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: widget.onTap,
                                  child: const Row(
                                    children: [
                                      Text(
                                        'View Details',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 16,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard(
    Color containerColor,
    Color iconColor,
    Color textColor,
    String text,
    IconData icon,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 16),
                const SizedBox(width: 4),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
