// lib/res/l10n/locale_catalog.dart
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:thuga/res/l10n/app_language.dart';

/// In-memory translation catalog. Both EN and ML maps are loaded once;
/// language switches only swap the active map pointer.
class LocaleCatalog {
  LocaleCatalog._();

  static final LocaleCatalog instance = LocaleCatalog._();

  static const _enAsset = 'assets/l10n/en.json';
  static const _mlAsset = 'assets/l10n/ml.json';

  Map<String, String> _en = const {};
  Map<String, String> _ml = const {};
  Map<String, String> _active = const {};
  AppLanguage _language = AppLanguage.english;
  bool _loaded = false;

  AppLanguage get language => _language;
  bool get isLoaded => _loaded;

  Future<void> ensureLoaded() async {
    if (_loaded) return;

    final results = await Future.wait([
      rootBundle.loadString(_enAsset),
      rootBundle.loadString(_mlAsset),
    ]);

    _en = _parseMap(results[0]);
    _ml = _parseMap(results[1]);
    _active = _en;
    _loaded = true;
  }

  void setLanguage(AppLanguage language) {
    _language = language;
    _active = language == AppLanguage.malayalam ? _ml : _en;
  }

  String t(String key, {String? fallback}) {
    return _active[key] ?? _en[key] ?? fallback ?? key;
  }

  String tParams(String key, Map<String, String> params) {
    var value = t(key);
    for (final entry in params.entries) {
      value = value.replaceAll('{${entry.key}}', entry.value);
    }
    return value;
  }

  Map<String, String> _parseMap(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return const {};
    return decoded.map(
      (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
    );
  }
}
