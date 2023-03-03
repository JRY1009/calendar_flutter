import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:www/storage/shared_pref.dart';

import 'lang/en_translation.dart';
import 'lang/zh_cn_translation.dart';

class LanguageService extends Translations {
  // prevent creating instance
  LanguageService._();

  static LanguageService? _instance;

  static LanguageService getInstance() {
    _instance ??= LanguageService._();
    return _instance!;
  }

  static Locale? systemLocale;
  static Locale? currentLocale;
  static Locale defaultLocale = supportedLanguages['zh_CN']!;

  // supported languages
  static Map<String,Locale> supportedLanguages = {
    'en' : const Locale('en'),
    'zh_CN' : const Locale('zh', 'CN'),
  };

  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'zh_CN': zhCN,
  };

  static isLanguageSupported(String languageCode) => supportedLanguages.keys.contains(languageCode);

  static bool isLocaleSupported(Locale locale) {
    for (var supportedLocale in supportedLanguages.values) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  static updateLanguage(String languageCode) async {
    if(!isLanguageSupported(languageCode)) {
      return;
    }
    
    await SharedPref.setCurrentLanguage(languageCode);
    LanguageService.currentLocale = supportedLanguages[languageCode]!;
    Get.updateLocale(supportedLanguages[languageCode]!);
  }

  /// get current locale
  static Locale? getLocale () {
    String langCode = SharedPref.getCurrentLocal();
    if (langCode.isEmpty){
      return null;
    }
    return LanguageService.supportedLanguages[langCode]!;
  }
}
