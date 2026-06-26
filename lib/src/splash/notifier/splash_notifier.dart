// lib/src/splash/notifier/splash_notifier.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/data/local/sembast_services.dart';
import 'package:vyapapp/services/token_service.dart';
import 'package:vyapapp/utils/routes/route_constants.dart';
import 'package:vyapapp/res/constants/app_constants.dart';

import '../state/splash_state.dart';

part 'splash_notifier.g.dart';

@Riverpod(keepAlive: false)
class SplashNotifier extends _$SplashNotifier {
  @override
  SplashState build() => const SplashState();

  Future<void> initialize(BuildContext context) async {
    if (state.status != SplashStatus.idle) return;

    state = state.copyWith(status: SplashStatus.checking);
    debugPrint('🔵 ACTION: splash initialize called');

    // Initialize Sembast Database
    try {
      await ref.read(sembastServicesProvider).initialize();
      debugPrint('🟢 Sembast database initialized successfully');
    } catch (e) {
      debugPrint('🔴 Sembast initialization error: $e');
    }

    var route = RouteConstants.routeLoginScreen;

    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      String? accessToken;
      try {
        accessToken = await ref
            .read(tokenServiceProvider)
            .getAccessToken()
            .timeout(const Duration(seconds: 2));
      } on TimeoutException catch (e) {
        debugPrint('🔴 SPLASH ERROR: token read timed out: $e');
        accessToken = null;
      } catch (e) {
        debugPrint('🔴 SPLASH ERROR: token read failed: $e');
        accessToken = null;
      }

      final hasSession = accessToken != null && accessToken.isNotEmpty;
      if (hasSession) {
        AppConstants.accessToken = accessToken;
      }

      debugPrint('🔍 SPLASH TOKEN READ: value="$accessToken"');
      debugPrint(
        '🔍 SPLASH TOKEN: isNull=${accessToken == null}, isEmpty=${accessToken?.isEmpty}, hasSession=$hasSession',
      );

      route = hasSession
          ? RouteConstants.routeHomeScreen
          : RouteConstants.routeLoginScreen;

      debugPrint(
        hasSession
            ? '🟢 SPLASH: session found, navigating to home'
            : '🟡 SPLASH: no session, navigating to login',
      );
    } catch (e) {
      debugPrint('🔴 SPLASH ERROR: initialize failed: $e');
      route = RouteConstants.routeLoginScreen;
    } finally {
      state = state.copyWith(status: SplashStatus.done, pendingRoute: route);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
      }
    }
  }
}
