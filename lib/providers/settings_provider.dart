import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode;
  Locale _locale;

  SettingsProvider({
    required ThemeMode initialTheme,
    required Locale initialLocale,
  }) : _themeMode = initialTheme,
       _locale = initialLocale;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  Future<void> updateTheme(ThemeMode newTheme) async {
    if (newTheme == _themeMode) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', newTheme.index);
    _themeMode = newTheme;
    notifyListeners();
  }

  Future<void> updateLocale(String newLocale) async {
    if (newLocale == _locale.languageCode) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLocale);
    _locale = Locale(newLocale);
    notifyListeners();
  }
} 