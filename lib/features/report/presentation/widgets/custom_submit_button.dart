import 'package:flutter/material.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    this.onTap,
    this.isEndable = true,
    this.isLoading = false,
  });
  final void Function()? onTap;
  final bool isLoading;
  final bool isEndable;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEndable && !isLoading ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isEndable ? const Color(0xFF00C853) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isLoading
            ? const LottieLoader()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.send_rounded,
                    size: 18,
                    color: isEndable ? Colors.white : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Submit Report",
                    style: TextStyle(
                      fontSize: 15,
                      color: isEndable ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
