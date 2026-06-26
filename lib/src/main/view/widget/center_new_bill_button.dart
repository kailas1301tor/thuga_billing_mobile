// lib/src/main/view/widget/center_new_bill_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';

class CenterNewBillButton extends StatelessWidget {
  const CenterNewBillButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: Offset(0, -20.h),
            child: GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Material(
                elevation: 6,
                shadowColor: ColorPalette.primaryColor.withValues(alpha: 0.25),
                shape: const CircleBorder(),
                color: ColorPalette.primaryColor,
                child: SizedBox(
                  width: 56.r,
                  height: 56.r,
                  child: Icon(Icons.add, size: 28.r, color: ColorPalette.white),
                ),
              ),
            ),
          ),
          // Text(
          //   Strings.navNewBill,
          //   style: FontPalette.base600(
          //     11,
          //     color: isSelected
          //         ? ColorPalette.primaryColor
          //         : ColorPalette.navInactive,
          //   ),
          // ),
        ],
      ),
    );
  }
}
