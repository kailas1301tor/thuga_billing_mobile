// lib/src/main/view/web/main_web_shell.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thuga/utils/common_widgets/web/web_app_shell.dart';
import 'package:thuga/utils/routes/route_constants.dart';

class MainWebShell extends StatelessWidget {
  const MainWebShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return WebAppShell(
      navigationShell: navigationShell,
      onNewBill: () => context.push(RouteConstants.routeNewBill),
    );
  }
}
