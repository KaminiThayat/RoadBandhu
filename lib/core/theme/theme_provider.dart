import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _loadSavedTheme();
    return ThemeMode.light;
  }

  Future<void> _loadSavedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(AppConstants.keyIsDarkMode) ?? false;
      state = isDark ? ThemeMode.dark : ThemeMode.light;
    } catch (_) {}
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newMode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyIsDarkMode, newMode == ThemeMode.dark);
    } catch (_) {}
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyIsDarkMode, mode == ThemeMode.dark);
    } catch (_) {}
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);
