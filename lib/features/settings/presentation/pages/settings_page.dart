// settings_page.dart (Updated to use Cubit)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:stadium_eye/features/settings/presentation/widgets/setting_card.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient background
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF00C853), Color(0xFF00E676)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                child: Row(
                  children: [
                    // Back button
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
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
                        color: Color(0xFF00C853),
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
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(state.message),
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),

                          // Appearance Section
                          const Text(
                            'Appearance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF424242),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Dark Mode Card
                          SettingCard(
                            // context,
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
                              activeColor: const Color(0xFF00C853),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Language Section
                          const Text(
                            'Language & Region',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF424242),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Locale Card
                          SettingCard(
                            // context,
                            icon: Icons.language_outlined,
                            title: 'Language',
                            subtitle: state.locale.displayName,
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey[400],
                            ),
                            onTap: () =>
                                _showLocaleDialog(context, state.locale),
                          ),

                          const SizedBox(height: 24),

                          // Notifications Section
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF424242),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Notifications Card
                          SettingCard(
                            // context,
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
                              activeColor: const Color(0xFF00C853),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(child: Text('Unknown state'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocaleDialog(BuildContext context, AppLanguage currentLocale) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Select Language'),
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
    String locale,
    AppLanguage currentLocale,
  ) {
    final isSelected = currentLocale.displayName == locale;
    return ListTile(
      title: Text(locale),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF00C853))
          : null,
      onTap: () {
        context.read<SettingsCubit>().changeLocale(locale);
        Navigator.pop(context);
      },
    );
  }
}
