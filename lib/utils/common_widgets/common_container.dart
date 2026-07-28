// /Users/wac/Documents/wac projects/tsuite/lib/utils/common_widgets/common_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:thuga/res/styles/color_palette.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.gradient,
    this.borderRadius,
    this.border,
    this.onTap,
    this.width,
    this.height,
    this.boxShadow,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Gradient? gradient;
  final double? borderRadius;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;

  BorderSide get _borderSide {
    if (border == null) return BorderSide.none;
    if (border is Border) return (border! as Border).top;
    return BorderSide.none;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadiusValue = (borderRadius ?? 20).r;
    final shape = SmoothRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadiusValue),
      side: _borderSide,
      smoothness: 2,
    );

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: ShapeDecoration(
        shape: shape,
        color: gradient == null ? (color ?? context.appColors.surface) : null,
        gradient: gradient,
        shadows:
            boxShadow ??
            [
              BoxShadow(
                color: ColorPalette.black.withValues(alpha: 0.04),
                blurRadius: 18.r,
                offset: Offset(0, 8.h),
              ),
            ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: shape,
          child: Padding(
            padding: padding ?? EdgeInsets.all(16.r),
            child: child,
          ),
        ),
      ),
    );
  }
}
