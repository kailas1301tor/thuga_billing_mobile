// lib/utils/common_widgets/web/responsive_list_grid.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/helpers/web_responsive.dart';

/// List on mobile/native; lazy responsive grid on web for listing screens.
///
/// Web uses a row-based [ListView] so cards keep their natural height instead
/// of stretching to fill a fixed-aspect grid cell.
class ResponsiveListGrid extends StatelessWidget {
  const ResponsiveListGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.physics,
    this.isLoadingMore = false,
    this.loadingIndicator,
    this.mobileColumns = 2,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.minItemWidth = 280,
    this.gridSpacing = WebSpacing.md,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool isLoadingMore;
  final Widget? loadingIndicator;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double minItemWidth;
  final double gridSpacing;

  int _columnCount(BuildContext context, double maxWidth) {
    final cap = webGridColumns(
      context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );

    final fit = ((maxWidth + gridSpacing) / (minItemWidth + gridSpacing)).floor();
    return fit.clamp(1, cap);
  }

  @override
  Widget build(BuildContext context) {
    final effectivePhysics = physics ?? const AlwaysScrollableScrollPhysics();

    if (!kIsWeb) {
      return ListView.builder(
        controller: controller,
        padding: padding,
        physics: effectivePhysics,
        itemCount: itemCount + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (isLoadingMore && index == itemCount) {
            return loadingIndicator ?? const SizedBox.shrink();
          }
          return itemBuilder(context, index);
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _columnCount(context, constraints.maxWidth);
        final totalSlots = itemCount + (isLoadingMore ? 1 : 0);

        if (columns == 1) {
          return ListView.builder(
            controller: controller,
            padding: padding,
            physics: effectivePhysics,
            itemCount: totalSlots,
            itemBuilder: (context, index) {
              if (isLoadingMore && index == itemCount) {
                return loadingIndicator ?? const SizedBox.shrink();
              }
              return itemBuilder(context, index);
            },
          );
        }

        final rowCount = (totalSlots + columns - 1) ~/ columns;

        return ListView.builder(
          controller: controller,
          padding: padding,
          physics: effectivePhysics,
          itemCount: rowCount,
          itemBuilder: (context, rowIndex) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex < rowCount - 1 ? gridSpacing : 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(columns, (columnIndex) {
                  final index = rowIndex * columns + columnIndex;
                  if (index >= totalSlots) {
                    return Expanded(child: SizedBox(width: gridSpacing));
                  }

                  final child = isLoadingMore && index == itemCount
                      ? (loadingIndicator ?? const SizedBox.shrink())
                      : itemBuilder(context, index);

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: columnIndex < columns - 1 ? gridSpacing : 0,
                      ),
                      child: child,
                    ),
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
