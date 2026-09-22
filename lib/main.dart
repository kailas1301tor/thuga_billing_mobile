import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuga/res/l10n/app_language.dart';
import 'package:thuga/res/l10n/locale_catalog.dart';
import 'package:thuga/res/l10n/locale_notifier.dart';
import 'package:thuga/services/firebase_service.dart';
import 'package:thuga/src/root/thuga_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await LocaleCatalog.instance.ensureLoaded();
  final prefs = await SharedPreferences.getInstance();
  LocaleCatalog.instance.setLanguage(
    AppLanguage.fromCode(prefs.getString(kAppLanguagePrefKey)),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: ThugaApp()));
}
