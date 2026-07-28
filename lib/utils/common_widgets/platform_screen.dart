// lib/utils/common_widgets/platform_screen.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Routes to [web] on browser, [mobile] on native apps.
class PlatformScreen extends StatelessWidget {
  const PlatformScreen({
    super.key,
    required this.mobile,
    required this.web,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder web;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return web(context);
    return mobile(context);
  }
}
