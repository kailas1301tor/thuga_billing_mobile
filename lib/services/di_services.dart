// lib/services/di_services.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/data/local/sembast_services.dart';
import 'package:thuga/data/remote/network_services.dart';
import 'package:thuga/services/token_service.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/src/printer/service/printer_service.dart';
import 'package:thuga/src/splash/notifier/splash_notifier.dart';

/// Invalidates all [@Riverpod(keepAlive: true)] providers.
///
/// Add new keepAlive providers here when created.
/// Call after clearing tokens on logout so the next session starts fresh.
void disposeProviders(ProviderContainer container) {
  container.invalidate(splashProvider);
  container.invalidate(dropdownsProvider);
  container.invalidate(printerProvider);
  container.invalidate(printerServiceProvider);
  container.invalidate(printerCrashlyticsServiceProvider);
  container.invalidate(networkServicesProvider);
  container.invalidate(sembastServicesProvider);
  container.invalidate(tokenServiceProvider);
  container.invalidate(accessTokenProvider);
}
