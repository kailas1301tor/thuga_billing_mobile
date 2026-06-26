// lib/src/main/view/widget/bottom_nav_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70.w,
        height: 56.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              Container(
                width: 28.w,
                height: 3.h,
                margin: EdgeInsets.only(bottom: 6.h),
                decoration: BoxDecoration(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              )
            else
              SizedBox(height: 9.h),
            Icon(
              icon,
              size: 24.r,
              color: isSelected
                  ? ColorPalette.primaryColor
                  : ColorPalette.navInactive,
            ),
            4.verticalSpace,
            Text(
              label,
              style: FontPalette.base600(
                11,
                color: isSelected
                    ? ColorPalette.primaryColor
                    : ColorPalette.navInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
