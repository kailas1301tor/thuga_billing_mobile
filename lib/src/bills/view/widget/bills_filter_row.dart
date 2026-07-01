// lib/src/bills/view/widget/bills_filter_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

class BillsFilterRow extends StatelessWidget {
  const BillsFilterRow({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  final String selectedDate;
  final ValueChanged<String> onDateChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final options = const ['Today', 'Yesterday', 'This Week', 'All Time'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options.map((opt) {
            final isSelected = opt.toLowerCase() == selectedDate.toLowerCase();
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ChoiceChip(
                label: Text(opt),
                selected: isSelected,
                onSelected: (_) => onDateChanged(opt),
                selectedColor: colors.primary,
                checkmarkColor: Colors.white,
                showCheckmark: false,
                backgroundColor: colors.inputBackground,
                labelStyle: FontPalette.base700(
                  12,
                  color: isSelected ? Colors.white : colors.primaryText,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  side: BorderSide(
                    color: isSelected ? colors.primary : colors.inputBorder,
                    width: 1.w,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
