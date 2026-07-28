// lib/src/settings/view/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:thuga/src/settings/view/mobile/settings_mobile_screen.dart';
import 'package:thuga/src/settings/view/web/settings_web_screen.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (context) => const SettingsMobileScreen(),
      web: (context) => const SettingsWebScreen(),
    );
  }
}
