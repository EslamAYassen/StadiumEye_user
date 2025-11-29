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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Media",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),

        /// Upload Photo Button (Green highlight)
        // DottedBorder(
        //   // animation: ,
        //   options: const OvalDottedBorderOptions(
        //     color: Colors.green,
        //     dashPattern: [6, 4],

        //     strokeWidth: 1.5,
        //   ),
        //   child: InkWell(
        //     onHover: (value) => color = Colors.green,
        //     borderRadius: BorderRadius.circular(16),
        //     onTap: widget.onPhotoUpload,
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(vertical: 18),
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //         color: Colors.green.shade50,
        //         borderRadius: BorderRadius.circular(16),
        //       ),
        //       child: const Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(Icons.camera_alt_outlined, color: Colors.grey),
        //           SizedBox(width: 10),
        //           Text("Upload Photo", style: TextStyle(fontSize: 15)),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 14),

        /// Upload Video Button
        _mediaButton(
          icon: Icons.videocam_outlined,
          label: "Upload Video",
          onPressed: widget.onVideoUpload,
        ),

        const SizedBox(height: 14),

        /// Record Voice Note Button
        _mediaButton(
          icon: Icons.mic_none_rounded,
          label: "Record Voice Note",
          onPressed: widget.onVoiceRecord,
        ),

        const SizedBox(height: 20),

        /// Disabled Submit Button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.send_rounded, size: 18, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                "Submit Report",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mediaButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color color = Colors.white,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        onPressed();
        setState(() {
          color = Colors.green;
        });
      },
      onHover: (value) => setState(() {
        debugPrint("Hovering");
      }),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 5],
          strokeWidth: 1,
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
    );
  }
}
