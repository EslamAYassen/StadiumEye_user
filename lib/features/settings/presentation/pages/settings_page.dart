// settings_page.dart (Theme Updated)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:stadium_eye/features/settings/presentation/widgets/setting_card.dart';
import 'package:stadium_eye/theme/app_colors.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';
import 'package:stadium_eye/utils/language.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient background
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [AppColors.primaryDark, AppColors.primary]
                      : [AppColors.primary, AppColors.gradientStart],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppThemeConsts.radius24xl),
                  bottomRight: Radius.circular(AppThemeConsts.radius24xl),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppThemeConsts.padding16md,
                  AppThemeConsts.padding16md,
                  AppThemeConsts.padding16md,
                  40,
                ),
                child: Row(
                  children: [
                    // Back button
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.2 * 255).toInt()),
                        borderRadius: BorderRadius.circular(
                          AppThemeConsts.radius16lg,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),

            // Settings content
            Expanded(
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  if (state is SettingsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is SettingsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppColors.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<SettingsCubit>().loadSettings();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SettingsLoaded) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(AppThemeConsts.padding16md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),

                          // Appearance Section
                          Text(
                            'Appearance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Dark Mode Card
                          SettingCard(
                            icon: Icons.dark_mode_outlined,
                            title: 'Dark Mode',
                            subtitle: 'Switch between light and dark theme',
                            trailing: Switch(
                              value: state.isDarkMode,
                              onChanged: (value) {
                                context.read<SettingsCubit>().toggleDarkMode(
                                  value,
                                );
                              },
                              activeThumbColor: AppColors.primary,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Language Section
                          Text(
                            'Language & Region',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Locale Card
                          SettingCard(
                            icon: Icons.language_outlined,
                            title: 'Language',
                            subtitle: state.locale.displayName,
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: isDarkMode
                                  ? AppColors.textSecondaryDark
                                  : AppColors.mediumGray,
                            ),
                            onTap: () =>
                                _showLocaleDialog(context, state.locale),
                          ),

                          const SizedBox(height: 24),

                          // Notifications Section
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Notifications Card
                          SettingCard(
                            icon: Icons.notifications_outlined,
                            title: 'Push Notifications',
                            subtitle: state.notificationsEnabled
                                ? 'Receive updates and alerts'
                                : 'Notifications disabled',
                            trailing: Switch(
                              value: state.notificationsEnabled,
                              onChanged: (value) {
                                context
                                    .read<SettingsCubit>()
                                    .toggleNotifications(value);
                              },
                              activeThumbColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(
                    child: Text(
                      'Unknown state',
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocaleDialog(BuildContext context, AppLanguage currentLocale) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: isDarkMode
              ? AppColors.cardDark
              : AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          ),
          title: Text(
            'Select Language',
            style: TextStyle(
              color: isDarkMode
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLocaleOption(context, 'English', currentLocale),
              _buildLocaleOption(context, 'Arabic', currentLocale),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocaleOption(
    BuildContext context,
    String localeName,
    AppLanguage currentLocale,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isSelected = currentLocale.displayName == localeName;

    return ListTile(
      title: Text(
        localeName,
        style: TextStyle(
          color: isDarkMode
              ? AppColors.textPrimaryDark
              : AppColors.textPrimaryLight,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : null,
      onTap: () {
        context.read<SettingsCubit>().changeLocale(
          AppLanguageExtension.fromName(localeName).code,
        );
        Navigator.pop(context);
      },
    );
  }
}
