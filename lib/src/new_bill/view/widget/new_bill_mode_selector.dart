// lib/src/new_bill/view/widget/new_bill_mode_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';

class NewBillModeSelector extends StatelessWidget {
  const NewBillModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  final int selectedMode;
  final ValueChanged<int> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 36.h,
        decoration: BoxDecoration(
          color: colors.inputBackground,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: colors.inputBorder, width: 1.w),
        ),
        padding: EdgeInsets.all(3.r),
        child: Row(
          children: [
            _buildSegment(0, 'Quick Tap', colors),
            _buildSegment(1, 'Amount Entry', colors),
          ],
        ),
      ),
    );
  }

  Widget _buildSegment(int index, String label, AppColors colors) {
    final isSelected = selectedMode == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onModeChanged(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? ColorPalette.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(100.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: FontPalette.base600(
              12,
              color: isSelected ? Colors.white : colors.secondaryText,
            ),
          ),
        ),
      ),
    );
  }
}
