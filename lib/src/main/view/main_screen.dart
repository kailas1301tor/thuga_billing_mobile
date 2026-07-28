// lib/src/main/view/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import 'package:thuga/src/main/view/mobile/main_mobile_shell.dart';
import 'package:thuga/src/main/view/web/main_web_shell.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        ref.read(dropdownsProvider.notifier).fetchDropdowns();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (_) => MainMobileShell(navigationShell: widget.navigationShell),
      web: (_) => MainWebShell(navigationShell: widget.navigationShell),
    );
  }
}
