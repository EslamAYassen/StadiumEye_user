import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
import 'package:stadium_eye/features/settings/domain/repositories/settings_repository.dart';
import 'package:stadium_eye/utils/language.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsCubit({required this.settingsRepository}) : super(SettingsInitial());

  get isDarkMode => null;

  // Load settings from repository (e.g., SharedPreferences)
  Future<void> loadSettings() async {
    try {
      emit(SettingsLoading());

      final isDarkMode = await settingsRepository.getDarkMode();
      final notificationsEnabled = await settingsRepository
          .getNotificationsEnabled();
      final locale = await settingsRepository.getLocale();

      emit(
        SettingsLoaded(
          isDarkMode: isDarkMode,
          notificationsEnabled: notificationsEnabled,
          locale: AppLanguageExtension.fromCode(locale),
        ),
      );
    } catch (e) {
      emit(SettingsError('Failed to load settings: ${e.toString()}'));
    }
  }

  // Toggle dark mode
  Future<void> toggleDarkMode(bool value) async {
    if (state is SettingsLoaded) {
      try {
        await settingsRepository.saveDarkMode(value);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(isDarkMode: value));
      } catch (e) {
        emit(SettingsError('Failed to update dark mode: ${e.toString()}'));
      }
    }
  }

  // Toggle notifications
  Future<void> toggleNotifications(bool value) async {
    if (state is SettingsLoaded) {
      try {
        await settingsRepository.saveNotificationsEnabled(value);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(notificationsEnabled: value));
      } catch (e) {
        emit(SettingsError('Failed to update notifications: ${e.toString()}'));
      }
    }
  }

  // Change locale
  Future<void> changeLocale(String localeCode) async {
    if (state is SettingsLoaded) {
      try {
        await settingsRepository.saveLocale(localeCode);
        final currentState = state as SettingsLoaded;
        emit(
          currentState.copyWith(
            locale: AppLanguageExtension.fromCode(localeCode),
          ),
        );
      } catch (e) {
        emit(SettingsError('Failed to update locale: ${e.toString()}'));
      }
    }
  }

  // Reset settings to default
  Future<void> resetSettings() async {
    try {
      emit(SettingsLoading());
      await settingsRepository.clearSettings();
      emit(
        const SettingsLoaded(
          isDarkMode: false,
          notificationsEnabled: true,
          locale: AppLanguage.english,
        ),
      );
    } catch (e) {
      emit(SettingsError('Failed to reset settings: ${e.toString()}'));
    }
  }
}
