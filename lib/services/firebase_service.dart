// lib/services/firebase_service.dart
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:thuga/firebase_options.dart';

bool isFirebaseInitialized = false;

Future<void> initializeFirebase() async {
  try {
    if (Firebase.apps.isNotEmpty) {
      isFirebaseInitialized = true;
      return;
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      !kDebugMode,
    );

    FlutterError.onError = (details) {
      unawaited(
        FirebaseCrashlytics.instance.recordFlutterFatalError(details),
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: true,
        ),
      );
      return true;
    };

    isFirebaseInitialized = true;
    debugPrint('🟢 FIREBASE: initialized');
  } catch (error) {
    isFirebaseInitialized = false;
    debugPrint('🔴 FIREBASE INIT FAILED: $error');
  }
}

Future<void> safeCrashlyticsSetUserIdentifier(String userId) async {
  if (!isFirebaseInitialized) {
    return;
  }

  try {
    await FirebaseCrashlytics.instance.setUserIdentifier(userId);
  } catch (error) {
    debugPrint('🔴 CRASHLYTICS USER ID FAILED: $error');
  }
}
