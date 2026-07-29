// lib/utils/common_widgets/thuga_logo.dart
import 'package:flutter/material.dart';
import 'package:thuga/res/constants/assets.dart';

class ThugaLogo extends StatelessWidget {
  const ThugaLogo({
    super.key,
    required this.size,
    this.borderRadius,
  });

  final double size;
  final double? borderRadius;

  static String assetForSize(double size) {
    return size <= 52 ? Assets.pngThugaLogo96 : Assets.pngThugaLogo144;
  }

  static int cacheSizeFor(double size, BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return (size * devicePixelRatio).ceil().clamp(48, 288);
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size * 0.2;
    final cacheSize = cacheSizeFor(size, context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        assetForSize(size),
        width: size,
        height: size,
        fit: BoxFit.cover,
        cacheWidth: cacheSize,
        cacheHeight: cacheSize,
        filterQuality: FilterQuality.low,
        gaplessPlayback: true,
      ),
    );
  }
}
