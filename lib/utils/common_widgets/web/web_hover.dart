// lib/utils/common_widgets/web/web_hover.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';

/// Web-only interactive surface with hover cursor and subtle highlight.
class WebHoverCard extends StatefulWidget {
  const WebHoverCard({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius = WebSpacing.cardRadius,
    this.padding,
  });

  final Widget child;
  final VoidCallback onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  State<WebHoverCard> createState() => _WebHoverCardState();
}

class _WebHoverCardState extends State<WebHoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: _hovered ? colors.inputBackground : colors.surface,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _hovered
                  ? colors.primary.withValues(alpha: 0.3)
                  : colors.inputBorder,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
