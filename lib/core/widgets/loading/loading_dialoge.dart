import 'package:flutter/material.dart';

import 'lottie_loading.dart';

class LoadingDialoge extends StatelessWidget {
  const LoadingDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(20),
      child: const LottieLoader(),
    );
  }
}
