// lib/src/home/view/web/widget/home_web_stat_card.dart
import 'package:flutter/material.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';

class HomeWebStatCard extends StatelessWidget {
  const HomeWebStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.subtitle,
    this.accentColor,
    this.trendIsPositive = true,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? subtitle;
  final Color? accentColor;
  final bool trendIsPositive;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = accentColor ?? colors.primary;

    return Container(
      padding: const EdgeInsets.all(WebSpacing.cardPadding),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
              const Spacer(),
              if (subtitle != null)
                _TrendChip(
                  label: subtitle!,
                  isPositive: trendIsPositive,
                  accent: accent,
                ),
            ],
          ),
          const SizedBox(height: WebSpacing.md),
          Text(
            label,
            style: FontPalette.base400(13, color: colors.secondaryText),
          ),
          const SizedBox(height: WebSpacing.xs),
          Text(
            value,
            style: FontPalette.base700(22, color: colors.primaryText),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _TrendChip extends StatelessWidget {
  const _TrendChip({
    required this.label,
    required this.isPositive,
    required this.accent,
  });

  final String label;
  final bool isPositive;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isPositive ? accent : ColorPalette.formValidationErrorColor)
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: FontPalette.base600(
          11,
          color: isPositive ? accent : ColorPalette.formValidationErrorColor,
        ),
      ),
    );
  }
}
