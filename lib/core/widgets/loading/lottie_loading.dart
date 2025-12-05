import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stadium_eye/constants/app_consts.dart';

class LottieLoader extends StatelessWidget {
  const LottieLoader({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Lottie.asset(AppConsts.lottieLoading, height: 100.0, width: 100.0),
  );
}
