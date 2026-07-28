// lib/src/auth/view/register_screen.dart
import 'package:flutter/material.dart';
import 'package:thuga/src/auth/view/mobile/register_mobile_screen.dart';
import 'package:thuga/src/auth/view/web/register_web_screen.dart';
import 'package:thuga/utils/common_widgets/platform_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScreen(
      mobile: (context) => const RegisterMobileScreen(),
      web: (context) => const RegisterWebScreen(),
    );
  }
}
