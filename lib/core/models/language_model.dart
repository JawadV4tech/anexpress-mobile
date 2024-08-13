import 'package:flutter/material.dart';

class LanguageModel {
  final String languageTitle;
  final String flag;
  final String languageCode;
  final String countryCode;
  final Locale locale;
  LanguageModel({
    required this.languageTitle,
    required this.flag,
    required this.languageCode,
    required this.countryCode,
    required this.locale,
  });
}

List<LanguageModel> languages = [
  LanguageModel(
    languageTitle: "ENGLISH",
    flag: "🇺🇸",
    languageCode: "en",
    countryCode: "US",
    locale: const Locale('en', 'US'),
  ),
  LanguageModel(
    languageTitle: "Español",
    flag: "🇲🇽",
    languageCode: "es",
    countryCode: "MX",
    locale: const Locale('es', 'MX'),
  ),
];

List<Locale> getLocalesFromLanguageModels() {
  return languages.map((language) => language.locale).toList();
}

String getFlagFromLanguageTitle(String languageTitle) {
  String flag = "";

  for (var language in languages) {
    if (language.languageTitle == languageTitle) {
      flag = language.flag;
    }
  }

  return flag;
}

List<String> getLanguageNamesFromLanguageModels() {
  return languages.map((language) => language.languageTitle).toList();
}
