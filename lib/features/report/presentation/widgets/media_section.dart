import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class MediaSection extends StatefulWidget {
  final VoidCallback onPhotoUpload;
  final VoidCallback onVideoUpload;
  final VoidCallback onVoiceRecord;

  const MediaSection({
    super.key,
    required this.onPhotoUpload,
    required this.onVideoUpload,
    required this.onVoiceRecord,
  });

  @override
  State<MediaSection> createState() => _MediaSectionState();
}

class _MediaSectionState extends State<MediaSection> {
  Color _photoBtnColor = Colors.grey;
  Color _videoBtnColor = Colors.grey;
  Color _voiceBtnColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        _mediaButton(
          color: _photoBtnColor,
          icon: Icons.camera_alt_outlined,
          label: "Upload Photo",

          onPressed: () {
            widget.onPhotoUpload();
            setState(() {
              _photoBtnColor == Colors.green
                  ? _photoBtnColor = Colors.grey
                  : _photoBtnColor = Colors.green;
            });
          },
        ),

        const SizedBox(height: 14),

        /// Upload Video Button
        _mediaButton(
          color: _videoBtnColor,
          icon: Icons.videocam_outlined,
          label: "Upload Video",

          onPressed: () {
            widget.onVideoUpload();
            setState(() {
              _videoBtnColor == Colors.green
                  ? _videoBtnColor = Colors.grey
                  : _videoBtnColor = Colors.green;
            });
          },
        ),

        const SizedBox(height: 14),

        /// Record Voice Note Button
        _mediaButton(
          color: _voiceBtnColor,
          icon: Icons.mic_none_rounded,
          label: "Record Voice Note",
          onPressed: () {
            widget.onVoiceRecord();
            setState(() {
              _voiceBtnColor == Colors.green
                  ? _voiceBtnColor = Colors.grey
                  : _voiceBtnColor = Colors.green;
            });
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _mediaButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color color = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        hoverColor: const Color(0xFFf0fcf4),
        highlightColor: const Color(0xFFf0fcf4),
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,

        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            dashPattern: [6, 3],
            strokeWidth: 1.5,
            radius: const Radius.circular(16),
            color: color,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.grey),
                const SizedBox(width: 10),
                Text(label, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
