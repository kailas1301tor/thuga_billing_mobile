// lib/src/new_bill/view/new_bill_screen.dart
import 'package:flutter/material.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

import 'mobile/new_bill_mobile_screen.dart';
import 'web/new_bill_web_screen.dart';

class NewBillScreen extends StatelessWidget {
  const NewBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (_) => const NewBillMobileScreen(),
      web: (_) => const NewBillWebScreen(),
    );
  }
}
