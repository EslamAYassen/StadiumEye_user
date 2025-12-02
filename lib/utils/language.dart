enum AppLanguage { english, arabic }

extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case .english:
        return "en";
      case .arabic:
        return "ar";
    }
  }

  String get displayName {
    switch (this) {
      case .english:
        return "English";
      case .arabic:
        return "Arabic";
    }
  }

  static AppLanguage fromCode(String code) {
    switch (code.toLowerCase()) {
      case "en":
        return AppLanguage.english;
      case "ar":
        return AppLanguage.arabic;
      default:
        throw ArgumentError('Invalid language code: $code');
    }
  }

  static AppLanguage fromName(String string) {
    switch (string) {
      case "English":
        return AppLanguage.english;
      case "Arabic":
        return AppLanguage.arabic;
      default:
        throw ArgumentError('Invalid language string: $string');
    }
  }
}
