// lib/utils/helpers/web_responsive.dart
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/helpers/web_breakpoints.dart';

int webGridColumns(
  BuildContext context, {
  int mobile = 1,
  int tablet = 2,
  int desktop = 3,
}) {
  return ResponsiveValue<int>(
    context,
    defaultValue: mobile,
    conditionalValues: [
      Condition.largerThan(name: WebBreakpoints.desktop, value: desktop),
      Condition.largerThan(name: WebBreakpoints.tablet, value: tablet),
    ],
  ).value;
}

double webPagePadding(BuildContext context) {
  return ResponsiveValue<double>(
    context,
    defaultValue: WebSpacing.md,
    conditionalValues: [
      Condition.largerThan(name: WebBreakpoints.tablet, value: WebSpacing.lg),
      Condition.largerThan(
        name: WebBreakpoints.desktop,
        value: WebSpacing.pagePadding,
      ),
    ],
  ).value;
}

bool webIsMobileBrowser(BuildContext context) =>
    ResponsiveBreakpoints.of(context).isMobile;

bool webIsTabletBrowser(BuildContext context) =>
    ResponsiveBreakpoints.of(context).isTablet;

bool webIsDesktopBrowser(BuildContext context) =>
    ResponsiveBreakpoints.of(context).isDesktop;
