// lib/utils/common_widgets/common_progress_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';

class CommonProgressBar extends StatelessWidget {
  const CommonProgressBar({
    super.key,
    required this.value,
    required this.fillColor,
    this.trackColor,
    this.height,
  });

  final double value;
  final Color fillColor;
  final Color? trackColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final barHeight = height ?? 6.h;
    final clampedValue = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(barHeight),
      child: SizedBox(
        height: barHeight,
        child: LinearProgressIndicator(
          value: clampedValue,
          backgroundColor: trackColor ?? ColorPalette.fF0F0F0,
          valueColor: AlwaysStoppedAnimation<Color>(fillColor),
          minHeight: barHeight,
        ),
      ),
    );
  }
}
