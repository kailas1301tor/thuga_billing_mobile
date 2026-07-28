// lib/src/home/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:thuga/src/home/view/mobile/home_mobile_screen.dart';
import 'package:thuga/src/home/view/web/home_web_screen.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (context) => const HomeMobileScreen(),
      web: (context) => const HomeWebScreen(),
    );
  }
}
