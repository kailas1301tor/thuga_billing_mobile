// lib/utils/common_widgets/web/web_grid.dart
import 'package:flutter/material.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/helpers/web_responsive.dart';

/// Responsive grid for web — column count adapts to browser width.
class WebGrid extends StatelessWidget {
  const WebGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.minItemWidth,
    this.spacing = WebSpacing.md,
    this.runSpacing = WebSpacing.md,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;

  /// When set, fits as many columns as possible up to the breakpoint cap.
  final double? minItemWidth;
  final double spacing;
  final double runSpacing;

  int _columnCount(BuildContext context, double maxWidth) {
    final cap = webGridColumns(
      context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );

    if (minItemWidth == null) return cap;

    final fit = ((maxWidth + spacing) / (minItemWidth! + spacing)).floor();
    return fit.clamp(1, cap);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _columnCount(context, constraints.maxWidth);
        final itemWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children
              .map(
                (child) => SizedBox(
                  width: itemWidth,
                  child: child,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
