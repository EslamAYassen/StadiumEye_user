import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';
import '../../../../utils/media_url_resolver.dart';
import '../../domain/entities/ticket_detection_entity.dart';
import 'detection_overlay_painter.dart';

class AiDetectionImageCard extends StatefulWidget {
  const AiDetectionImageCard({super.key, required this.ticketDetection});

  final TicketDetectionEntity ticketDetection;

  @override
  State<AiDetectionImageCard> createState() => _AiDetectionImageCardState();
}

class _AiDetectionImageCardState extends State<AiDetectionImageCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  int? _highlightedIndex;

  ui.Image? _decodedImage;
  final _imageStreamListenerHolder = <ImageStreamListener>[];
  ImageStream? _imageStream;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    _resolveImageSize();
  }

  void _resolveImageSize() {
    final url = MediaUrlResolver.resolve(widget.ticketDetection.url);
    final provider = NetworkImage(url);
    _imageStream = provider.resolve(const ImageConfiguration());
    final listener = ImageStreamListener((info, _) {
      if (mounted) {
        setState(() => _decodedImage = info.image);
      }
    });
    _imageStreamListenerHolder.add(listener);
    _imageStream!.addListener(listener);
  }

  @override
  void dispose() {
    if (_imageStream != null && _imageStreamListenerHolder.isNotEmpty) {
      _imageStream!.removeListener(_imageStreamListenerHolder.first);
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;
    final url = MediaUrlResolver.resolve(widget.ticketDetection.url);
    final detections = widget.ticketDetection.detections;

    return FadeTransition(
      opacity: _fade,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppThemeConsts.padding16md),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: model type + detection count badge
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppThemeConsts.padding16md,
                AppThemeConsts.padding12sm,
                AppThemeConsts.padding16md,
                AppThemeConsts.padding8xs,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.model_training_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _modelTypeLabel(widget.ticketDetection.modelType, locale),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withAlpha((0.12 * 255).toInt()),
                      borderRadius: BorderRadius.circular(
                        AppThemeConsts.radius8sm,
                      ),
                    ),
                    child: Text(
                      locale.detectionsFound(detections.length),
                      style: const TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Image + bounding-box overlay
            AspectRatio(
              aspectRatio: _decodedImage != null
                  ? _decodedImage!.width / _decodedImage!.height
                  : 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    url,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                      progress.expectedTotalBytes!
                                : null,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: isDarkMode
                          ? AppColors.cardElevatedDark
                          : AppColors.lightGray,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.mediumGray,
                        size: 40,
                      ),
                    ),
                  ),
                  if (_decodedImage != null && detections.isNotEmpty)
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return Opacity(
                            opacity: _fade.value,
                            child: CustomPaint(
                              painter: DetectionOverlayPainter(
                                detections: detections,
                                imageWidth: _decodedImage!.width.toDouble(),
                                imageHeight: _decodedImage!.height.toDouble(),
                                highlightedIndex: _highlightedIndex,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Detection chips (tap to highlight on image)
            if (detections.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(detections.length, (index) {
                    final d = detections[index];
                    final isSelected = _highlightedIndex == index;
                    final color = _colorForClass(d.className);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _highlightedIndex = isSelected ? null : index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color
                              : color.withAlpha((0.12 * 255).toInt()),
                          borderRadius: BorderRadius.circular(
                            AppThemeConsts.radius8sm,
                          ),
                          border: Border.all(color: color, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.whiteColor
                                    : color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${_classLabel(d.className, locale)} · ${(d.confidence * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppColors.whiteColor
                                    : (isDarkMode
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _colorForClass(String className) {
    switch (className.toUpperCase()) {
      case 'GRAFFITI':
        return AppColors.warning;
      case 'GARBAGE':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  String _classLabel(String className, AppLocalizations locale) {
    switch (className.toUpperCase()) {
      case 'GRAFFITI':
        return locale.detectionClassGraffiti;
      case 'GARBAGE':
        return locale.detectionClassGarbage;
      default:
        return className;
    }
  }

  String _modelTypeLabel(String modelType, AppLocalizations locale) {
    switch (modelType) {
      case 'visualPollution':
        return locale.modelTypeVisualPollution;
      case 'safety':
        return locale.modelTypeSafety;
      default:
        return modelType;
    }
  }
}
