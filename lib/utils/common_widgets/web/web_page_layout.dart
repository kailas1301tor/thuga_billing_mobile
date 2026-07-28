// lib/utils/common_widgets/web/web_page_layout.dart
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/helpers/web_breakpoints.dart';
import 'package:thuga/utils/helpers/web_responsive.dart';

/// Standard page wrapper for web screens — max width, responsive padding.
class WebPageLayout extends StatelessWidget {
  const WebPageLayout({
    super.key,
    this.title,
    this.actions = const [],
    required this.child,
    this.maxWidth = WebBreakpoints.maxContentWidth,
  });

  final String? title;
  final List<Widget> actions;
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final padding = webPagePadding(context);

    return ColoredBox(
      color: colors.background,
      child: MaxWidthBox(
        maxWidth: maxWidth,
        child: CustomScrollView(
          slivers: [
            if (title != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    padding,
                    WebSpacing.lg,
                    padding,
                    WebSpacing.md,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title!,
                          style: FontPalette.base700(
                            24,
                            color: colors.primaryText,
                          ),
                        ),
                      ),
                      ...actions,
                    ],
                  ),
                ),
              ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                padding,
                title == null ? padding : 0,
                padding,
                WebSpacing.xxl,
              ),
              sliver: SliverToBoxAdapter(child: child),
            ),
          ],
        ),
      ),
    );
  }
}
