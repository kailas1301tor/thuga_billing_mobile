// lib/src/new_bill/view/new_bill_screen.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

import 'mobile/new_bill_mobile_screen.dart';
import 'web/new_bill_web_screen.dart';

class NewBillScreen extends StatelessWidget {
  const NewBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mobile browsers use the native mobile layout. The desktop web split
    // view (catalog + 400px cart) leaves no room for products on narrow widths.
    if (kIsWeb && ResponsiveBreakpoints.of(context).isMobile) {
      return const NewBillMobileScreen();
    }

    return PlatformScreen(
      mobile: (_) => const NewBillMobileScreen(),
      web: (_) => const NewBillWebScreen(),
    );
  }
}
