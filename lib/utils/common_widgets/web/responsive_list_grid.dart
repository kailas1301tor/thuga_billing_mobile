// lib/utils/common_widgets/web/responsive_list_grid.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/common_widgets/web/web_grid.dart';

/// List on mobile/native; responsive [WebGrid] on web for listing screens.
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

    return ListView(
      controller: controller,
      padding: padding,
      physics: effectivePhysics,
      children: [
        WebGrid(
          mobileColumns: mobileColumns,
          tabletColumns: tabletColumns,
          desktopColumns: desktopColumns,
          minItemWidth: minItemWidth,
          spacing: gridSpacing,
          runSpacing: gridSpacing,
          children: [
            for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
          ],
        ),
        if (isLoadingMore) loadingIndicator ?? const SizedBox.shrink(),
      ],
    );
  }
}
