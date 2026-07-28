// lib/src/auth/view/login_screen.dart
import 'package:flutter/material.dart';
import 'package:thuga/src/auth/view/mobile/login_mobile_screen.dart';
import 'package:thuga/src/auth/view/web/login_web_screen.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (context) => const LoginMobileScreen(),
      web: (context) => const LoginWebScreen(),
    );
  }
}
