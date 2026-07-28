// lib/src/calculation/view/widget/calculation_bill_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import '../../model/calculation_bill_model.dart';

class CalculationBillCard extends StatelessWidget {
  const CalculationBillCard({
    super.key,
    required this.summary,
    required this.onTap,
    required this.onDelete,
  });

  final CalculationBillSummaryModel summary;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bill = summary.bill;
    final updated = bill.updatedAt;
    final dateLabel =
        '${updated.day.toString().padLeft(2, '0')}/${updated.month.toString().padLeft(2, '0')}/${updated.year}';

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CommonContainer(
        onTap: onTap,
        padding: EdgeInsets.all(16.w),
        borderRadius: 16.r,
        border: Border.all(color: colors.inputBorder, width: 1.w),
        color: colors.surface,
        child: Row(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: ColorPalette.homeStatGreenBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 22.r,
                color: colors.primary,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.name,
                    style: FontPalette.base700(15, color: colors.primaryText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  Text(
                    '${bill.customerCount} customers · ${bill.itemCount} items · $dateLabel',
                    style: FontPalette.base400(12, color: colors.secondaryText),
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  summary.grandTotal.toCurrency(),
                  style: FontPalette.base700(15, color: colors.primary),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 20.r,
                    color: colors.errorText,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
