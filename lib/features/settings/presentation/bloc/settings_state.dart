part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {
  const SettingsState();

  // @override
  // List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final AppLanguage locale;

  const SettingsLoaded({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.locale,
  });

  // @override
  // List<Object> get props => [isDarkMode, notificationsEnabled, locale];

  SettingsLoaded copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    AppLanguage? locale,
  }) {
    return SettingsLoaded(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locale: locale ?? this.locale,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  // @override
  // List<Object> get props => [message];
}
