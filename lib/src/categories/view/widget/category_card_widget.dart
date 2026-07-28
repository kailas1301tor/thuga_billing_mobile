// lib/src/categories/view/widget/category_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/common_widgets/common_nav_bar_button.dart';
import 'package:thuga/src/categories/model/category_model.dart';
import 'package:thuga/utils/helpers/date_formatter.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  final CategoryModel category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final dateStr = category.createdAt != null
        ? formatDate(category.createdAt!)
        : 'Unknown Date';

    return CommonContainer(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: colors.surface,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: FontPalette.base600(15, color: colors.primaryText),
                ),
                4.verticalSpace,
                Text(
                  'Created: $dateStr',
                  style: FontPalette.base400(12, color: colors.secondaryText),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CommonNavBarButton(
                icon: Icon(
                  Icons.edit_rounded,
                  size: 18.r,
                  color: colors.primary,
                ),
                onTap: onEdit,
              ),
              8.verticalSpace,
              CommonNavBarButton(
                icon: Icon(
                  Icons.delete_rounded,
                  size: 18.r,
                  color: colors.errorText,
                ),
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
