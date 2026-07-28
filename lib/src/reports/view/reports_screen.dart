// lib/src/reports/view/reports_screen.dart
import 'package:flutter/material.dart';
import 'package:thuga/src/reports/view/mobile/reports_mobile_screen.dart';
import 'package:thuga/src/reports/view/web/reports_web_screen.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (context) => const ReportsMobileScreen(),
      web: (context) => const ReportsWebScreen(),
    );
  }
}
