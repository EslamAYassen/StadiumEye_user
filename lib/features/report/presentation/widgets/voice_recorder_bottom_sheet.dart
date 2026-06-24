import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';

/// A modal bottom sheet that lets the user record a voice note using the
/// device microphone.
///
/// Shows it via:
/// ```dart
/// final path = await showModalBottomSheet<String>(
///   context: context,
///   isScrollControlled: true,
///   backgroundColor: Colors.transparent,
///   builder: (context) => const VoiceRecorderBottomSheet(),
/// );
/// ```
/// Returns the local file path of the saved recording, or `null` if the
/// user cancelled.
class VoiceRecorderBottomSheet extends StatefulWidget {
  const VoiceRecorderBottomSheet({super.key});

  @override
  State<VoiceRecorderBottomSheet> createState() =>
      _VoiceRecorderBottomSheetState();
}

class _VoiceRecorderBottomSheetState extends State<VoiceRecorderBottomSheet>
    with SingleTickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();
  late final AnimationController _pulseController;

  bool _isRecording = false;
  bool _isInitializing = false;
  Duration _duration = Duration.zero;
  Timer? _timer;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  String get _formattedDuration {
    final minutes = _duration.inMinutes.remainder(60).toString().padLeft(
      2,
      '0',
    );
    final seconds = _duration.inSeconds.remainder(60).toString().padLeft(
      2,
      '0',
    );
    return '$minutes:$seconds';
  }

  Future<void> _startRecording() async {
    setState(() {
      _isInitializing = true;
      _errorMessage = null;
    });

    try {
      final hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        if (!mounted) return;
        setState(() {
          _isInitializing = false;
          _errorMessage =
              AppLocalizations.of(context)!.microphonePermissionRequired;
        });
        return;
      }

      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/voice_note_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(const RecordConfig(), path: filePath);

      if (!mounted) return;
      setState(() {
        _isRecording = true;
        _isInitializing = false;
        _duration = Duration.zero;
      });

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() => _duration += const Duration(seconds: 1));
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isInitializing = false;
        _errorMessage =
            '${AppLocalizations.of(context)!.operationFailed}: $e';
      });
    }
  }

  Future<void> _stopAndSave() async {
    _timer?.cancel();
    final path = await _audioRecorder.stop();
    if (!mounted) return;
    Navigator.pop(context, path);
  }

  Future<void> _cancel() async {
    _timer?.cancel();
    if (_isRecording) {
      await _audioRecorder.stop();
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final locale = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.only(
        left: AppThemeConsts.padding16md,
        right: AppThemeConsts.padding16md,
        top: AppThemeConsts.padding24lg,
        bottom:
            MediaQuery.of(context).viewInsets.bottom +
            AppThemeConsts.padding24lg,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppThemeConsts.radius16lg),
          topRight: Radius.circular(AppThemeConsts.radius16lg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.borderDark : AppColors.lightGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            locale.recordVoiceNote,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isRecording ? locale.recording : locale.tapToRecord,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: _isInitializing
                ? null
                : (_isRecording ? _stopAndSave : _startRecording),
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final scale = _isRecording
                    ? 1.0 + (_pulseController.value * 0.18)
                    : 1.0;
                final activeColor = _isRecording
                    ? AppColors.error
                    : AppColors.primary;

                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor,
                      boxShadow: [
                        BoxShadow(
                          color: activeColor.withAlpha(_isRecording ? 110 : 70),
                          blurRadius: 24,
                          spreadRadius: _isRecording ? 8 : 4,
                        ),
                      ],
                    ),
                    child: _isInitializing
                        ? const Padding(
                            padding: EdgeInsets.all(26.0),
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Icon(
                            _isRecording
                                ? Icons.stop_rounded
                                : Iconsax.microphone_copy,
                            color: AppColors.whiteColor,
                            size: 36,
                          ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _formattedDuration,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.error, fontSize: 13),
            ),
          ],
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _cancel,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppThemeConsts.radius12md,
                      ),
                    ),
                  ),
                  child: Text(
                    locale.cancel,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (_isRecording) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _stopAndSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppThemeConsts.radius12md,
                        ),
                      ),
                    ),
                    child: Text(
                      locale.done,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
