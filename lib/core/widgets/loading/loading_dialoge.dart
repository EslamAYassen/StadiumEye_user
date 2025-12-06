import 'package:flutter/material.dart';

import 'lottie_loading.dart';

class LoadingDialoge extends StatelessWidget {
  const LoadingDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      //TODO: fix this shit Abdou
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),

        constraints: const BoxConstraints(
          minWidth: 120,
          maxWidth: 120,
          minHeight: 120,
          maxHeight: 120,
        ),
        child: const Center(child: LottieLoader()),
      ),
    );
  }
}
