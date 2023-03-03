import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SharedPref {

  SharedPref._();

  // get storage
  static final GetStorage box = GetStorage();

  // STORING KEYS
  static const String _currentLanguageKey = 'current_language';
  static const String _themeModeKey = 'theme_mode';

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void> setCurrentLanguage(String languageCode) => box.write(_currentLanguageKey, languageCode);
  static String getCurrentLocal() => box.read(_currentLanguageKey) ?? '';

  // /// set theme current type as light theme
  // static Future<void> setThemeIsLight(bool lightTheme) =>
  //     _sharedPreferences.setBool(_lightThemeKey, lightTheme);
  //
  // /// get if the current theme type is light
  // static bool getThemeIsLight() =>
  //     _sharedPreferences.getBool(_lightThemeKey) ?? true; // todo set the default theme (true for light, false for dark)
  //

}