import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class CustomAppBarForMyReport extends StatelessWidget {
  final int totalReports;
  final int monthReports;
  final VoidCallback? onBackPressed;

  const CustomAppBarForMyReport({
    super.key,
    this.totalReports = 3,
    this.monthReports = 3,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppThemeConsts.radius16lg),
          bottomRight: Radius.circular(AppThemeConsts.radius16lg),
        ),
      ),
      pinned: true,
      backgroundColor: isDarkMode ? AppColors.surfaceDark : AppColors.primary,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(61),
            borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.whiteColor,
            ),
            onPressed: onBackPressed ?? () => Navigator.pop(context),
          ),
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double top = constraints.biggest.height;
          final double collapsedHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final double expandedHeight = 280;
          final double shrinkOffset = expandedHeight - top;
          final double shrinkPercentage =
              (shrinkOffset / (expandedHeight - collapsedHeight)).clamp(
                0.0,
                1.0,
              );

          return FlexibleSpaceBar(
            centerTitle: true,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: shrinkPercentage > 0.5 ? 1.0 : 0.0,
              child: const Text(
                'My Reports',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [AppColors.primaryDark, AppColors.primary]
                      : [AppColors.gradientStart, AppColors.gradientEnd],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppThemeConsts.radius16lg),
                  bottomRight: Radius.circular(AppThemeConsts.radius16lg),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppThemeConsts.padding16md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: 1.0 - shrinkPercentage,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 300),
                          offset: Offset(0, shrinkPercentage * 0.2),
                          child: const Text(
                            'My Reports',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: 1.0 - shrinkPercentage,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: 1.0 - (shrinkPercentage * 0.1),
                          child: Row(
                            children: [
                              Expanded(
                                child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 800),
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(-50 * (1 - value), 0),
                                      child: Opacity(
                                        opacity: value,
                                        child: _buildStatCard(
                                          'Total Reports',
                                          totalReports.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 800),
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(50 * (1 - value), 0),
                                      child: Opacity(
                                        opacity: value,
                                        child: _buildStatCard(
                                          'This Month',
                                          monthReports.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(38),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        border: Border.all(color: Colors.white.withAlpha(51), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor.withAlpha(230),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<int>(
            duration: const Duration(milliseconds: 1200),
            tween: IntTween(begin: 0, end: int.parse(value)),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              return Text(
                animatedValue.toString(),
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
