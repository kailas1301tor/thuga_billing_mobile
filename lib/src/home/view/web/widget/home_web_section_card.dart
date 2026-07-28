// lib/src/home/view/web/widget/home_web_section_card.dart
import 'package:flutter/material.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';

class HomeWebSectionCard extends StatelessWidget {
  const HomeWebSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.action,
    this.maxContentHeight,
  });

  final String title;
  final Widget child;
  final Widget? action;
  final double? maxContentHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    Widget content = child;
    if (maxContentHeight != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxContentHeight!),
        child: SingleChildScrollView(child: child),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(WebSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: FontPalette.base700(16, color: colors.primaryText),
                ),
              ),
              ?action,
            ],
          ),
          const SizedBox(height: WebSpacing.md),
          content,
        ],
      ),
    );
  }
}
