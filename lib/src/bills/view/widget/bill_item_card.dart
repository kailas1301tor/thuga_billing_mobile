// lib/src/bills/view/widget/bill_item_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/bills/model/bill_model.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

class BillItemCard extends StatelessWidget {
  const BillItemCard({super.key, required this.bill, this.onTap});

  final BillModel bill;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CommonContainer(
        onTap: onTap,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        borderRadius: 24.r,
        border: Border.all(color: colors.inputBorder, width: 1.w),
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon container
            CommonContainer(
              width: 48.r,
              height: 48.r,
              padding: EdgeInsets.zero,
              borderRadius: 100.r,
              color: ColorPalette.homeStatGreenBg,
              boxShadow: const [],
              child: Center(
                child: Icon(
                  Icons.receipt_long_outlined,
                  size: 22.r,
                  color: colors.primary,
                ),
              ),
            ),
            12.horizontalSpace,
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.billNumber,
                    style: FontPalette.base700(16, color: colors.primaryText),
                  ),
                  4.verticalSpace,
                  Text(
                    '${bill.timeLabel}  •  ${bill.customerLabel}',
                    style: FontPalette.base400(13, color: colors.secondaryText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  Text(
                    '${bill.itemsCount} ${bill.itemsCount == 1 ? "item" : "items"}',
                    style: FontPalette.base400(12, color: colors.secondaryText),
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
            // Price & Status Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  bill.amount.toCurrency(),
                  style: FontPalette.base700(16, color: colors.primary),
                ),
                6.verticalSpace,
                _StatusBadge(isPaid: bill.isPaid),
              ],
            ),
            8.horizontalSpace,
            // Chevron icon
            Icon(
              Icons.chevron_right_rounded,
              size: 20.r,
              color: ColorPalette.navInactive,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isPaid});

  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isPaid
            ? ColorPalette.homePaidBadgeBg
            : ColorPalette.formValidationErrorColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: isPaid
              ? ColorPalette.homePaidBadgeBorder
              : ColorPalette.formValidationErrorColor,
          width: 1.w,
        ),
      ),
      child: Text(
        isPaid ? 'Paid' : 'Pending',
        style: FontPalette.base600(
          11,
          color: isPaid
              ? ColorPalette.homePaidBadgeBorder
              : ColorPalette.formValidationErrorColor,
        ),
      ),
    );
  }
}
