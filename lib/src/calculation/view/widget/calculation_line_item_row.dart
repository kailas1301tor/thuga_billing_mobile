// lib/src/calculation/view/widget/calculation_line_item_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

import '../../model/calculation_bill_model.dart';

class CalculationLineItemRow extends StatelessWidget {
  const CalculationLineItemRow({
    super.key,
    required this.item,
    required this.lineTotal,
    required this.onDecrement,
    required this.onIncrement,
  });

  final CalculationLineItemModel item;
  final double lineTotal;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: FontPalette.base600(13, color: colors.primaryText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.categoryName,
                  style: FontPalette.base400(11, color: colors.secondaryText),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDecrement,
            icon: Icon(Icons.remove_circle_outline, size: 22.r),
            color: colors.secondaryText,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
          ),
          Text(
            '${item.quantity}',
            style: FontPalette.base700(14, color: colors.primaryText),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: Icon(Icons.add_circle_outline, size: 22.r),
            color: colors.primary,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
          ),
          SizedBox(
            width: 72.w,
            child: Text(
              lineTotal.toCurrency(),
              textAlign: TextAlign.end,
              style: FontPalette.base700(13, color: colors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
