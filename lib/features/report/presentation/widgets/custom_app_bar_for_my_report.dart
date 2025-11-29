import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';

import '../../../../theme/app_theme_consts.dart';

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
    return SliverAppBar(
      expandedHeight: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppThemeConsts.radius16lg),
          bottomRight: Radius.circular(AppThemeConsts.radius16lg),
        ),
      ),
      pinned: true,

      backgroundColor: const Color(0xFF00c267),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
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
            title: Opacity(
              opacity: shrinkPercentage > 0.5 ? 1.0 : 0.0,
              child: const Text(
                'My Reports',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF00c951), Color(0xFF00bd7e)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppThemeConsts.radius16lg),
                  bottomRight: Radius.circular(AppThemeConsts.radius16lg),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Opacity(
                        opacity: 1.0 - shrinkPercentage,
                        child: const Text(
                          'My Reports',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Opacity(
                        opacity: 1.0 - shrinkPercentage,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                'Total Reports',
                                totalReports.toString(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                'This Month',
                                monthReports.toString(),
                              ),
                            ),
                          ],
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
