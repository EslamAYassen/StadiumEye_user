import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';
import '../../domain/entities/text_detection_entity.dart';
import '../../domain/entities/ticket_entity.dart';

class TextAnalysisSection extends StatefulWidget {
  const TextAnalysisSection({super.key, required this.ticket});

  final TicketEntity ticket;

  @override
  State<TextAnalysisSection> createState() => _TextAnalysisSectionState();
}

class _TextAnalysisSectionState extends State<TextAnalysisSection>
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
    final textDetection = widget.ticket.textDetection;

    // Nothing to show if the ticket has no textDetection data at all.
    if (textDetection == null) {
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
          margin: const EdgeInsets.fromLTRB(
            AppThemeConsts.padding16md,
            0,
            AppThemeConsts.padding16md,
            AppThemeConsts.padding16md,
          ),
          padding: const EdgeInsets.all(AppThemeConsts.padding16md),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
            border: Border.all(
              color: AppColors.info.withAlpha((0.25 * 255).toInt()),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(isDarkMode, locale),
              const SizedBox(height: AppThemeConsts.padding16md),
              _buildBody(context, isDarkMode, locale, textDetection),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode, AppLocalizations locale) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
          decoration: BoxDecoration(
            color: AppColors.info.withAlpha((0.14 * 255).toInt()),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          ),
          child: const Icon(
            Icons.text_snippet_rounded,
            color: AppColors.info,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.textAnalysis,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              Text(
                locale.textAnalysisSubtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool isDarkMode,
    AppLocalizations locale,
    TextDetectionEntity textDetection,
  ) {
    if (textDetection.isFailed) {
      return _StatusBanner(
        icon: Icons.error_outline_rounded,
        color: AppColors.error,
        text: textDetection.error ?? locale.textAnalysisFailed,
        isDarkMode: isDarkMode,
      );
    }

    if (textDetection.isInProgress) {
      return _StatusBanner(
        icon: Icons.hourglass_top_rounded,
        color: AppColors.warning,
        text: textDetection.status == TextDetectionStatus.processing
            ? locale.textAnalysisProcessing
            : locale.textAnalysisPending,
        isDarkMode: isDarkMode,
        showSpinner: textDetection.status == TextDetectionStatus.processing,
      );
    }

    if (!textDetection.hasContent) {
      return _StatusBanner(
        icon: Icons.info_outline_rounded,
        color: AppColors.mediumGray,
        text: locale.textAnalysisNoContent,
        isDarkMode: isDarkMode,
      );
    }

    final classification = textDetection.classification;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (classification != null && !classification.isEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (classification.category != null)
                _ClassificationChip(
                  label: locale.textAnalysisCategory,
                  value: classification.category!,
                  color: AppColors.info,
                  isDarkMode: isDarkMode,
                ),
              if (classification.severity != null)
                _ClassificationChip(
                  label: locale.textAnalysisSeverity,
                  value: classification.severity!,
                  color: _severityColor(classification.severity!),
                  isDarkMode: isDarkMode,
                ),
              if (classification.priority != null)
                _ClassificationChip(
                  label: locale.textAnalysisPriority,
                  value: classification.priority!,
                  color: AppColors.warning,
                  isDarkMode: isDarkMode,
                ),
              if (classification.department != null)
                _ClassificationChip(
                  label: locale.textAnalysisDepartment,
                  value: classification.department!,
                  color: AppColors.primary,
                  isDarkMode: isDarkMode,
                ),
              if (classification.persona != null)
                _ClassificationChip(
                  label: locale.textAnalysisPersona,
                  value: classification.persona!,
                  color: AppColors.success,
                  isDarkMode: isDarkMode,
                ),
              if (classification.interaction != null)
                _ClassificationChip(
                  label: locale.textAnalysisInteraction,
                  value: classification.interaction!,
                  color: AppColors.info,
                  isDarkMode: isDarkMode,
                ),
              if (classification.location != null)
                _ClassificationChip(
                  label: locale.textAnalysisLocation,
                  value: classification.location!,
                  color: AppColors.mediumGray,
                  isDarkMode: isDarkMode,
                ),
            ],
          ),
        if (textDetection.summary != null &&
            textDetection.summary!.trim().isNotEmpty) ...[
          const SizedBox(height: AppThemeConsts.padding16md),
          _buildTextBlock(
            isDarkMode,
            locale.textAnalysisSummary,
            textDetection.summary!,
            Icons.summarize_rounded,
          ),
        ],
        if (textDetection.extractedText != null &&
            textDetection.extractedText!.trim().isNotEmpty) ...[
          const SizedBox(height: AppThemeConsts.padding16md),
          _buildTextBlock(
            isDarkMode,
            locale.textAnalysisExtractedText,
            textDetection.extractedText!,
            Icons.article_outlined,
          ),
        ],
      ],
    );
  }

  Widget _buildTextBlock(
    bool isDarkMode,
    String title,
    String content,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.cardElevatedDark
            : AppColors.veryLightGray,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.info),
              const SizedBox(width: 6),
              Text(
                title,
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
          const SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
          ),
        ],
      ),
    );
  }

  Color _severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
      case 'critical':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.info;
    }
  }
}

class _ClassificationChip extends StatelessWidget {
  const _ClassificationChip({
    required this.label,
    required this.value,
    required this.color,
    required this.isDarkMode,
  });

  final String label;
  final String value;
  final Color color;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha((0.12 * 255).toInt()),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius8sm),
        border: Border.all(color: color.withAlpha((0.4 * 255).toInt())),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({
    required this.icon,
    required this.color,
    required this.text,
    required this.isDarkMode,
    this.showSpinner = false,
  });

  final IconData icon;
  final Color color;
  final String text;
  final bool isDarkMode;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      ),
      child: Row(
        children: [
          if (showSpinner)
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: color),
            )
          else
            Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
