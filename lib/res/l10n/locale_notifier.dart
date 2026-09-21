// lib/res/l10n/locale_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuga/res/l10n/app_language.dart';
import 'package:thuga/res/l10n/locale_catalog.dart';

part 'locale_notifier.g.dart';

const kAppLanguagePrefKey = 'pref_app_language';

@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Future<AppLanguage> build() async {
    await LocaleCatalog.instance.ensureLoaded();
    final prefs = await SharedPreferences.getInstance();
    final language = AppLanguage.fromCode(prefs.getString(kAppLanguagePrefKey));
    LocaleCatalog.instance.setLanguage(language);
    return language;
  }

  Future<void> setLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAppLanguagePrefKey, language.code);
    LocaleCatalog.instance.setLanguage(language);
    state = AsyncData(language);
  }
}
