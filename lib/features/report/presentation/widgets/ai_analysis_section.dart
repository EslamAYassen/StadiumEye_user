import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';
import '../../domain/entities/ticket_entity.dart';
import 'ai_detection_image_card.dart';

class AiAnalysisSection extends StatefulWidget {
  const AiAnalysisSection({super.key, required this.ticket});

  final TicketEntity ticket;

  @override
  State<AiAnalysisSection> createState() => _AiAnalysisSectionState();
}

class _AiAnalysisSectionState extends State<AiAnalysisSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;

    // Only render this section at all for AI-mode reports.
    if (ticket.mode != 'ai') {
      return const SizedBox.shrink();
    }

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(AppThemeConsts.padding16md),
          padding: const EdgeInsets.all(AppThemeConsts.padding16md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      AppColors.cardDark,
                      AppColors.cardElevatedDark,
                    ]
                  : [
                      AppColors.whiteColor,
                      AppColors.veryLightGreen,
                    ],
            ),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
            border: Border.all(
              color: AppColors.primary.withAlpha((0.25 * 255).toInt()),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, isDarkMode, locale),
              const SizedBox(height: AppThemeConsts.padding16md),
              if (ticket.hasAiDetections) ...[
                _buildSummaryStats(context, isDarkMode, locale),
                const SizedBox(height: AppThemeConsts.padding16md),
                Text(
                  locale.analyzedMedia,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: AppThemeConsts.padding12sm),
                ...ticket.ticketDetections.map(
                  (td) => AiDetectionImageCard(ticketDetection: td),
                ),
                if (ticket.recommendations.isNotEmpty)
                  _buildRecommendations(context, isDarkMode, locale),
              ] else
                _buildEmptyState(context, isDarkMode, locale),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations locale,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha((0.35 * 255).toInt()),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.whiteColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.aiAnalysis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              Text(
                locale.aiAnalysisSubtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((0.12 * 255).toInt()),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius8sm),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.memory_rounded, size: 14, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                locale.aiPoweredReport,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryStats(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations locale,
  ) {
    return Row(
      children: [
        Expanded(
          child: _StatChip(
            icon: Icons.report_problem_rounded,
            label: locale.totalIssuesDetected,
            value: '${widget.ticket.totalDetectionsCount}',
            color: AppColors.error,
            isDarkMode: isDarkMode,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatChip(
            icon: Icons.image_rounded,
            label: locale.analyzedMedia,
            value: '${widget.ticket.ticketDetections.length}',
            color: AppColors.info,
            isDarkMode: isDarkMode,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendations(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations locale,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: AppThemeConsts.padding8xs),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppThemeConsts.padding16md),
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColors.primaryDark.withAlpha((0.15 * 255).toInt())
              : AppColors.lightGreen,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_rounded, color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  locale.aiRecommendations,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...widget.ticket.recommendations.map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.circle,
                        size: 5,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        r,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations locale,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.successDark.withAlpha((0.12 * 255).toInt())
            : AppColors.successLight,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_rounded,
              color: AppColors.whiteColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            locale.noDetectionsFound,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            locale.noDetectionsFoundDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDarkMode,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardElevatedDark : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: Border.all(color: color.withAlpha((0.3 * 255).toInt())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
          ),
        ],
      ),
    );
  }
}
