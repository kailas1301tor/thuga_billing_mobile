// /Users/wac/Documents/wac projects/tsuite/lib/utils/common_widgets/common_shimmer_box.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vyapapp/res/styles/color_palette.dart';

class CommonShimmerBox extends StatelessWidget {
  const CommonShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? context.appColors.inputBackground,
      highlightColor: highlightColor ?? ColorPalette.white,
      child: Container(
        width: width,
        height: height ?? 16.h,
        decoration: BoxDecoration(
          color: context.appColors.inputBackground,
          borderRadius: BorderRadius.circular((borderRadius ?? 12).r),
        ),
      ),
    );
  }
}


class CommonLatestShimmer extends StatelessWidget {
  final Widget child;
  const CommonLatestShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 235, 238, 237),
            Color.fromARGB(255, 235, 238, 237),
            Color.fromARGB(255, 235, 238, 237),
          ],
          stops: [0.5, 0.5, 0.5],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }
}

class CustomShimmerWidget extends StatelessWidget {
  final Widget child;
  const CustomShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 161, 162, 162),
            Color.fromARGB(255, 176, 178, 178),
            Color.fromARGB(255, 168, 170, 170),
          ],
          stops: [0.5, 0.5, 0.5],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }
}

