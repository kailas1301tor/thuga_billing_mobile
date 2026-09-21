import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../res/styles/color_palette.dart';

class AnimatedScanLine extends StatelessWidget {
  final Animation<double> animation;
  final double cutOutWidth;
  final double cutOutHeight;
  final bool isScanned;

  const AnimatedScanLine({
    super.key,
    required this.animation,
    required this.cutOutWidth,
    required this.cutOutHeight,
    required this.isScanned,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double scanLeft = (screenWidth - cutOutWidth) / 2;
    double scanTop = (screenHeight - cutOutHeight) / 2;
    double scanBottom = scanTop + cutOutHeight;

    const travelReductionFactor = 0.75;
    double reducedTravelDistance =
        (scanBottom - scanTop) * travelReductionFactor;
    double offsetCenter =
        scanTop + (scanBottom - scanTop) * (1 - travelReductionFactor) / 2;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final topPosition =
            isScanned
                ? offsetCenter + reducedTravelDistance / 2
                : offsetCenter + reducedTravelDistance * animation.value;

        return Positioned(
          left: scanLeft + 10.w,
          right: scanLeft + 10.w,
          top: topPosition,
          child: Container(
            width: cutOutWidth - 20.w,
            height: 2.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              gradient: LinearGradient(
                colors: [
                  ColorPalette.primaryColor.withValues(alpha: 0.3),
                  ColorPalette.primaryColor,
                  ColorPalette.primaryColor,
                  ColorPalette.primaryColor.withValues(alpha: 0.3),
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorPalette.primaryColor.withValues(
                    alpha: 0.3,
                  ),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
