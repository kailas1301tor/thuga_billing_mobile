// lib/firebase_options.dart
// Generated manually from android/app/google-services.json.
// Run `flutterfire configure --project=thuga-billing` to refresh iOS values.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => ios,
      TargetPlatform.windows => throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for windows.',
      ),
      TargetPlatform.linux => throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for linux.',
      ),
      TargetPlatform.fuchsia => throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for fuchsia.',
      ),
    };
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8mR25lcm2eY6pK5INAsA5uemdP2drBkk',
    appId: '1:914040002853:android:588c02acb73cc971a3a2cc',
    messagingSenderId: '914040002853',
    projectId: 'thuga-billing',
    storageBucket: 'thuga-billing.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8mR25lcm2eY6pK5INAsA5uemdP2drBkk',
    appId: '1:914040002853:ios:588c02acb73cc971a3a2cc',
    messagingSenderId: '914040002853',
    projectId: 'thuga-billing',
    storageBucket: 'thuga-billing.firebasestorage.app',
    iosBundleId: 'com.thuga.billing',
  );
}
