// lib/utils/helpers/web_breakpoints.dart
import 'package:responsive_framework/responsive_framework.dart';

/// Shared breakpoint names aligned with [ResponsiveBreakpoints.builder] in ThugaApp.
abstract final class WebBreakpoints {
  static const String mobile = MOBILE;
  static const String tablet = TABLET;
  static const String desktop = DESKTOP;

  static const double mobileMax = 599;
  static const double tabletMax = 1023;
  static const double maxContentWidth = 1200;
  static const double sidebarWidth = 240;
  static const double railWidth = 72;
}
