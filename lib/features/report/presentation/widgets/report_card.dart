import 'package:flutter/material.dart';

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
    this.isSubmitted = ReportFilter.drafts,
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
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                const BoxShadow(
                  color: Color.fromARGB(20, 0, 0, 0),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                              color: Color(0xFF10B981),
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (widget.isSubmitted == ReportFilter.submitted) ...[
                        _statCard(
                          const Color(0xFFD1FAE5),
                          const Color(0xFF10B981),
                          const Color(0xFF10B981),
                          'Submitted',
                          Icons.check_circle_rounded,
                        ),
                      ] else ...[
                        _statCard(
                          const Color.fromARGB(255, 248, 250, 209),
                          const Color.fromARGB(255, 225, 215, 21),
                          const Color.fromARGB(255, 185, 176, 16),
                          'Draft',
                          Icons.drafts_rounded,
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
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B7280),
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
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4B5563),
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
                                  color: const Color(0xFFE5E7EB),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.image,
                                  size: 18,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '+${widget.photoCount}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
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
                        child: const Divider(
                          thickness: 0.8,
                          color: Color.fromARGB(150, 229, 231, 235),
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
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.date,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF9CA3AF),
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
                                          color: Color(0xFF10B981),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 16,
                                        color: Color(0xFF10B981),
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
