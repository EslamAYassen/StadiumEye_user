// lib/features/matches/presentation/pages/matches_page.dart
import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

import '../../../../core/widgets/appbar_header/appbar_header.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.darkGray
            : AppColors.backgroundLight,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppbarHeader(isDarkMode: isDarkMode, title: "المباريات"),
              _buildDateSection(context, isDarkMode),
              const SizedBox(height: AppThemeConsts.padding16md),
              ..._getDummyMatches().map(
                (match) => _buildMatchCard(context, match, isDarkMode),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSection(BuildContext context, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
        vertical: AppThemeConsts.padding12sm,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.darkGray.withAlpha(((0.5 * 255) ~/ 1 * 255) ~/ 1)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: Border.all(
          color: isDarkMode
              ? AppColors.lightGray.withAlpha(((0.1 * 255) ~/ 1 * 255) ~/ 1)
              : AppColors.lightGray,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'الأسبوع السابع عشر',
            style: TextStyle(
              color: isDarkMode ? AppColors.whiteColor : AppColors.darkGray,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.primary.withAlpha((0.2 * 255) ~/ 1)
                  : AppColors.lightGreen,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withAlpha((0.3 * 255) ~/ 1),
              ),
            ),
            child: Text(
              'لم تبدأ',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.primary.withAlpha((0.9 * 255) ~/ 1)
                    : AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(
    BuildContext context,
    Map<String, dynamic> match,
    bool isDarkMode,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppThemeConsts.padding12sm),
      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.darkGray.withAlpha((0.5 * 255) ~/ 1)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: Border.all(
          color: isDarkMode
              ? AppColors.lightGray.withAlpha((0.1 * 255) ~/ 1)
              : AppColors.lightGray,
        ),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: AppColors.blackColor.withAlpha((0.05 * 255) ~/ 1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeam(
                match['teams']['home']['name'],
                match['teams']['home']['logo'],
                true,
                isDarkMode,
              ),
              _buildMatchScore(match, isDarkMode),
              _buildTeam(
                match['teams']['away']['name'],
                match['teams']['away']['logo'],
                false,
                isDarkMode,
              ),
            ],
          ),
          const SizedBox(height: AppThemeConsts.padding12sm),
          _buildMatchInfo(match, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildTeam(String name, String logo, bool isHome, bool isDarkMode) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.lightGray.withAlpha((0.1 * 255) ~/ 1)
                  : AppColors.lightGray,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode
                    ? AppColors.lightGray.withAlpha((0.2 * 255) ~/ 1)
                    : AppColors.lightGray,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                logo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.sports_soccer,
                    color: isDarkMode
                        ? AppColors.whiteColor.withAlpha((0.5 * 255) ~/ 1)
                        : AppColors.primary,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: AppThemeConsts.padding8xs),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isDarkMode ? AppColors.whiteColor : AppColors.darkGray,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchScore(Map<String, dynamic> match, bool isDarkMode) {
    final status = match['fixture']['status']['short'];
    final isLive = status == 'HT' || status == '1H' || status == '2H';
    final isNotStarted = status == 'NS' || status == 'TBD';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
        vertical: AppThemeConsts.padding8xs,
      ),
      child: Column(
        children: [
          if (isNotStarted)
            Column(
              children: [
                Text(
                  '-  -  -',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor.withAlpha((0.5 * 255) ~/ 1)
                        : AppColors.darkGray.withAlpha((0.5 * 255) ~/ 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  match['fixture']['date'].split('T')[1].substring(0, 5),
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor.withAlpha((0.7 * 255) ~/ 1)
                        : AppColors.darkGray,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${match['goals']['home'] ?? 0}',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.darkGray,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.whiteColor.withAlpha((0.5 * 255) ~/ 1)
                          : AppColors.darkGray.withAlpha((0.5 * 255) ~/ 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${match['goals']['away'] ?? 0}',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.darkGray,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (isLive)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.redColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${match['fixture']['status']['elapsed']}\'',
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMatchInfo(Map<String, dynamic> match, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding12sm,
        vertical: AppThemeConsts.padding8xs,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.primary.withAlpha((0.1 * 255) ~/ 1)
            : AppColors.lightGreen,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius8sm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 16,
            color: isDarkMode
                ? AppColors.primary.withAlpha((0.9 * 255) ~/ 1)
                : AppColors.primary,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              match['fixture']['venue']['name'],
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.primary.withAlpha((0.9 * 255) ~/ 1)
                    : AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getDummyMatches() {
    return [
      {
        "fixture": {
          "id": 239625,
          "date": "2020-02-06T16:00:00+00:00",
          "venue": {"name": "إستاد الملك فهد الدولي"},
          "status": {"short": "NS", "elapsed": null},
        },
        "teams": {
          "home": {
            "name": "إسطنبول باشاكشهير",
            "logo": "https://media.api-sports.io/football/teams/635.png",
          },
          "away": {
            "name": "غازي عنتاب بي بي كي",
            "logo": "https://media.api-sports.io/football/teams/3569.png",
          },
        },
        "goals": {"home": null, "away": null},
      },
      {
        "fixture": {
          "id": 239626,
          "date": "2020-02-06T14:30:00+00:00",
          "venue": {"name": "إستاد المدينة الرياضية"},
          "status": {"short": "HT", "elapsed": 45},
        },
        "teams": {
          "home": {
            "name": "الهلال",
            "logo": "https://media.api-sports.io/football/teams/2939.png",
          },
          "away": {
            "name": "النصر",
            "logo": "https://media.api-sports.io/football/teams/2933.png",
          },
        },
        "goals": {"home": 1, "away": 2},
      },
      {
        "fixture": {
          "id": 239627,
          "date": "2020-02-06T18:00:00+00:00",
          "venue": {"name": "ملعب الجوهرة"},
          "status": {"short": "NS", "elapsed": null},
        },
        "teams": {
          "home": {
            "name": "الاتحاد",
            "logo": "https://media.api-sports.io/football/teams/2932.png",
          },
          "away": {
            "name": "الأهلي",
            "logo": "https://media.api-sports.io/football/teams/2937.png",
          },
        },
        "goals": {"home": null, "away": null},
      },
      {
        "fixture": {
          "id": 239627,
          "date": "2020-02-06T18:00:00+00:00",
          "venue": {"name": "ملعب الجوهرة"},
          "status": {"short": "NS", "elapsed": null},
        },
        "teams": {
          "home": {
            "name": "الاتحاد",
            "logo": "https://media.api-sports.io/football/teams/2932.png",
          },
          "away": {
            "name": "الأهلي",
            "logo": "https://media.api-sports.io/football/teams/2937.png",
          },
        },
        "goals": {"home": null, "away": null},
      },
      {
        "fixture": {
          "id": 239627,
          "date": "2020-02-06T18:00:00+00:00",
          "venue": {"name": "ملعب الجوهرة"},
          "status": {"short": "NS", "elapsed": null},
        },
        "teams": {
          "home": {
            "name": "الاتحاد",
            "logo": "https://media.api-sports.io/football/teams/2932.png",
          },
          "away": {
            "name": "الأهلي",
            "logo": "https://media.api-sports.io/football/teams/2937.png",
          },
        },
        "goals": {"home": null, "away": null},
      },
      {
        "fixture": {
          "id": 239627,
          "date": "2020-02-06T18:00:00+00:00",
          "venue": {"name": "ملعب الجوهرة"},
          "status": {"short": "NS", "elapsed": null},
        },
        "teams": {
          "home": {
            "name": "الاتحاد",
            "logo": "https://media.api-sports.io/football/teams/2932.png",
          },
          "away": {
            "name": "الأهلي",
            "logo": "https://media.api-sports.io/football/teams/2937.png",
          },
        },
        "goals": {"home": null, "away": null},
      },
      {
        "fixture": {
          "id": 239627,
          "date": "2020-02-06T18:00:00+00:00",
          "venue": {"name": "ملعب الجوهرة"},
          "status": {"short": "NS", "elapsed": null},
        },
        "teams": {
          "home": {
            "name": "الاتحاد",
            "logo": "https://media.api-sports.io/football/teams/2932.png",
          },
          "away": {
            "name": "الأهلي",
            "logo": "https://media.api-sports.io/football/teams/2937.png",
          },
        },
        "goals": {"home": null, "away": null},
      },
    ];
  }
}
