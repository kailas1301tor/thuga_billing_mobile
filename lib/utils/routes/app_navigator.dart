// lib/utils/routes/app_navigator.dart
import 'package:go_router/go_router.dart';
import 'package:thuga/utils/helpers/common_functions.dart';
import 'package:thuga/utils/routes/app_router.dart';

import 'package:flutter/material.dart';

/// Shared navigator key for app-wide navigation (logout, splash, auth).
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

void navigateAndClearStack(String route) {
  executeAfterFrame(() {
    appRouter.go(route);
  });
}
