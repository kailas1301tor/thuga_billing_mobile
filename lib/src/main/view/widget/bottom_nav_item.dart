// lib/src/main/view/widget/bottom_nav_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                Container(
                  width: 28.w,
                  height: 3.h,
                  margin: EdgeInsets.only(bottom: 4.h),
                  decoration: BoxDecoration(
                    color: ColorPalette.primaryColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                )
              else
                SizedBox(height: 7.h),
              Icon(
                icon,
                size: 22.r,
                color: isSelected
                    ? ColorPalette.primaryColor
                    : ColorPalette.navInactive,
              ),
              2.verticalSpace,
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: FontPalette.base600(
                    10,
                    color: isSelected
                        ? ColorPalette.primaryColor
                        : ColorPalette.navInactive,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
