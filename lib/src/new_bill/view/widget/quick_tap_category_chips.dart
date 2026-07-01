// lib/src/new_bill/view/widget/quick_tap_category_chips.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../notifier/new_bill_notifier.dart';

class QuickTapCategoryChips extends ConsumerWidget {
  const QuickTapCategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final String selectedCategory;
  final void Function(String name, int id) onCategorySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    // Watch categories from state
    final categoriesData = ref.watch(
      newBillNotifierProvider.select((s) => s.categories),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: categoriesData.map((cat) {
          final isSelected = selectedCategory == cat.name;
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
                    11,
                    color: isSelected ? Colors.white : colors.secondaryText,
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
