// lib/src/calculation/view/widget/calculation_category_chips.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

import '../../model/calculation_catalog_model.dart';

class CalculationCategoryChips extends StatelessWidget {
  const CalculationCategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  final List<CalculationCategoryModel> categories;
  final int selectedCategoryId;
  final void Function(String name, int id) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = selectedCategoryId == cat.id;
          return Padding(
            padding: EdgeInsets.only(right: 6.w),
            child: GestureDetector(
              onTap: () => onCategorySelected(cat.name, cat.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorPalette.primaryColor
                      : colors.surface,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: isSelected
                        ? ColorPalette.primaryColor
                        : colors.inputBorder,
                    width: 1.w,
                  ),
                ),
                child: Text(
                  cat.name,
                  style: FontPalette.base600(
                    12,
                    color: isSelected ? ColorPalette.white : colors.primaryText,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
