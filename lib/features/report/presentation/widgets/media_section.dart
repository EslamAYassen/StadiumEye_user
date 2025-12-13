import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class MediaSection extends StatefulWidget {
  final Function(List<String> imagePaths) onImagesChanged;
  final Function(List<String> videoPaths) onVideosChanged;
  final Function(List<String> voicePaths) onVoicesChanged;

  const MediaSection({
    super.key,
    required this.onImagesChanged,
    required this.onVideosChanged,
    required this.onVoicesChanged,
  });

  @override
  State<MediaSection> createState() => _MediaSectionState();
}

class _MediaSectionState extends State<MediaSection> {
  final ImagePicker _imagePicker = ImagePicker();

  final List<File> _selectedImages = [];
  final List<File> _selectedVideos = [];
  final List<File> _selectedVoices = [];

  // Pick multiple images
  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images.map((xFile) => File(xFile.path)));
        });
        _notifyImagesChanged();
      }
    } catch (e) {
      _showError('Failed to pick images: $e');
    }
  }

  // Pick image from camera
  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          _selectedImages.add(File(photo.path));
        });
        _notifyImagesChanged();
      }
    } catch (e) {
      _showError('Failed to take photo: $e');
    }
  }

  // Pick videos
  Future<void> _pickVideos() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _selectedVideos.addAll(result.paths.map((p) => File(p!)));
        });
        _notifyVideosChanged();
      }
    } catch (e) {
      _showError('Failed to pick videos: $e');
    }
  }

  // Pick audio/voice files
  Future<void> _pickVoices() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _selectedVoices.addAll(result.paths.map((p) => File(p!)));
        });
        _notifyVoicesChanged();
      }
    } catch (e) {
      _showError('Failed to pick audio: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    _notifyImagesChanged();
  }

  void _removeVideo(int index) {
    setState(() {
      _selectedVideos.removeAt(index);
    });
    _notifyVideosChanged();
  }

  void _removeVoice(int index) {
    setState(() {
      _selectedVoices.removeAt(index);
    });
    _notifyVoicesChanged();
  }

  void _notifyImagesChanged() {
    widget.onImagesChanged(_selectedImages.map((f) => f.path).toList());
  }

  void _notifyVideosChanged() {
    widget.onVideosChanged(_selectedVideos.map((f) => f.path).toList());
  }

  void _notifyVoicesChanged() {
    widget.onVoicesChanged(_selectedVoices.map((f) => f.path).toList());
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  void _showImagePicker() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppThemeConsts.radius16lg),
            topRight: Radius.circular(AppThemeConsts.radius16lg),
          ),
        ),
        padding: const EdgeInsets.all(AppThemeConsts.padding16md),
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
            const SizedBox(height: 20),
            Text(
              'Choose Image Source',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ImageSourceButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    _takePhoto();
                  },
                ),
                _ImageSourceButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImages();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Media Attachments',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),

        // Upload Buttons
        Row(
          children: [
            Expanded(
              child: _MediaButton(
                icon: Icons.photo_camera,
                label: 'Photos',
                count: _selectedImages.length,
                color: AppColors.primary,
                onTap: _showImagePicker,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MediaButton(
                icon: Icons.videocam,
                label: 'Videos',
                count: _selectedVideos.length,
                color: AppColors.info,
                onTap: _pickVideos,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MediaButton(
                icon: Icons.mic,
                label: 'Voice',
                count: _selectedVoices.length,
                color: AppColors.warning,
                onTap: _pickVoices,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Images Preview
        if (_selectedImages.isNotEmpty) ...[
          const SizedBox(height: 8),
          _ImagePreviewGrid(images: _selectedImages, onRemove: _removeImage),
        ],

        // Videos Preview
        if (_selectedVideos.isNotEmpty) ...[
          const SizedBox(height: 16),
          _FilePreviewList(
            title: 'Videos',
            files: _selectedVideos,
            icon: Icons.videocam,
            color: AppColors.info,
            onRemove: _removeVideo,
          ),
        ],

        // Voice Preview
        if (_selectedVoices.isNotEmpty) ...[
          const SizedBox(height: 16),
          _FilePreviewList(
            title: 'Voice Recordings',
            files: _selectedVoices,
            icon: Icons.mic,
            color: AppColors.warning,
            onRemove: _removeVoice,
          ),
        ],
      ],
    );
  }
}

// Media Upload Button
class _MediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color color;
  final VoidCallback onTap;

  const _MediaButton({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withAlpha((255 * 0.1).toInt()),
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Icon(icon, color: color, size: 32),
                if (count > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Image Source Button
class _ImageSourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(AppThemeConsts.padding16md),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.cardElevatedDark : AppColors.lightGray,
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          border: Border.all(color: AppColors.primary),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Add these to media_section.dart

// Image Preview Grid
class _ImagePreviewGrid extends StatelessWidget {
  final List<File> images;
  final Function(int) onRemove;

  const _ImagePreviewGrid({required this.images, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.photo, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Images (${images.length})',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return _ImagePreviewCard(
              image: images[index],
              onRemove: () => onRemove(index),
            );
          },
        ),
      ],
    );
  }
}

// Image Preview Card
class _ImagePreviewCard extends StatelessWidget {
  final File image;
  final VoidCallback onRemove;

  const _ImagePreviewCard({required this.image, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          child: Image.file(
            image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.whiteColor,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// File Preview List (for videos and audio)
class _FilePreviewList extends StatelessWidget {
  final String title;
  final List<File> files;
  final IconData icon;
  final Color color;
  final Function(int) onRemove;

  const _FilePreviewList({
    required this.title,
    required this.files,
    required this.icon,
    required this.color,
    required this.onRemove,
  });

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              '$title (${files.length})',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...files.asMap().entries.map((entry) {
          final index = entry.key;
          final file = entry.value;
          final fileName = path.basename(file.path);
          final fileSize = file.lengthSync();

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(AppThemeConsts.padding12sm),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
              border: Border.all(
                color: isDarkMode
                    ? AppColors.borderDark
                    : color.withAlpha((0.3 * 255).toInt()),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppThemeConsts.padding8xs),
                  decoration: BoxDecoration(
                    color: color.withAlpha((0.1 * 255).toInt()),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatFileSize(fileSize),
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
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.error),
                  onPressed: () => onRemove(index),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
