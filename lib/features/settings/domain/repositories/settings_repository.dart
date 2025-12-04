abstract class SettingsRepository {
  Future<bool> getDarkMode();
  Future<bool> getNotificationsEnabled();
  Future<String> getLocale();

  Future<void> saveDarkMode(bool value);
  Future<void> saveNotificationsEnabled(bool value);
  Future<void> saveLocale(String locale);

  Future<void> clearSettings();
}
