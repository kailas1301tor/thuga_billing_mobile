// lib/res/l10n/app_language.dart
import 'package:flutter/material.dart';

enum AppLanguage {
  english,
  malayalam;

  String get code => switch (this) {
    AppLanguage.english => 'en',
    AppLanguage.malayalam => 'ml',
  };

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String? code) {
    return switch (code) {
      'ml' => AppLanguage.malayalam,
      _ => AppLanguage.english,
    };
  }
}
