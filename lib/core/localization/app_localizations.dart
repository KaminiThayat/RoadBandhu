import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import 'languages/en_translations.dart';
import 'languages/hi_translations.dart';

class LanguageNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    _loadSavedLanguage();
    return const Locale('en');
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final langCode = prefs.getString(AppConstants.keyLanguage) ?? 'en';
      state = Locale(langCode);
    } catch (_) {}
  }

  Future<void> setLanguage(String languageCode) async {
    state = Locale(languageCode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyLanguage, languageCode);
    } catch (_) {}
  }

  bool get isHindi => state.languageCode == 'hi';
}

final languageProvider = NotifierProvider<LanguageNotifier, Locale>(LanguageNotifier.new);

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
    return localizations ?? AppLocalizations(const Locale('en'));
  }

  String translate(String key) {
    if (locale.languageCode == 'hi') {
      return hiTranslations[key] ?? enTranslations[key] ?? key;
    }
    return enTranslations[key] ?? key;
  }

  String get languageName => locale.languageCode == 'hi' ? 'हिंदी' : 'English';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

// Extension on BuildContext for quick access
extension LocalizationExtension on BuildContext {
  String tr(String key) => AppLocalizations.of(this).translate(key);
}
