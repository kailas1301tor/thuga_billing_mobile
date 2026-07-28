// lib/src/bills/view/bills_screen.dart
import 'package:flutter/material.dart';
import 'package:thuga/src/bills/view/mobile/bills_mobile_screen.dart';
import 'package:thuga/src/bills/view/web/bills_web_screen.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (context) => const BillsMobileScreen(),
      web: (context) => const BillsWebScreen(),
    );
  }
}
