// lib/utils/routes/app_navigator.dart
import 'package:flutter/material.dart';

import 'package:vyapapp/utils/helpers/common_functions.dart';

/// Shared navigator key for app-wide navigation (logout, splash, auth).
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

void navigateAndClearStack(String route) {
  final navigator = appNavigatorKey.currentState;
  if (navigator == null) return;

  executeAfterFrame(() {
    navigator.pushNamedAndRemoveUntil(route, (_) => false);
  });
}
