// lib/src/bills/view/widget/bill_summary_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/src/bills/model/bill_model.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import 'bill_payment_status_action.dart';

/// Collapsed bill summary content — used inside [BillItemCard] and [BillSummaryCard].
class BillSummaryContent extends StatelessWidget {
  const BillSummaryContent({super.key, required this.bill});

  final BillModel bill;

  String get _customerLabel => bill.customerName?.isNotEmpty == true
      ? bill.customerName!
      : Strings.walkInCustomer;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasBalance = bill.balance > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: ColorPalette.homeStatGreenBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.receipt_long_outlined,
                  size: 20.r,
                  color: colors.primary,
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.orderNumber,
                    style: FontPalette.base700(15, color: colors.primaryText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  2.verticalSpace,
                  Text(
                    bill.dateString,
                    style: FontPalette.base400(12, color: colors.secondaryText),
                  ),
                  if (billShowsPaidDate(bill.paymentStatus, bill.paidDate)) ...[
                    2.verticalSpace,
                    Text(
                      '${Strings.paidOn}: ${bill.paidDate}',
                      style: FontPalette.base500(11, color: colors.primary),
                    ),
                  ],
                ],
              ),
            ),
            8.horizontalSpace,
            Text(
              bill.totalAmount.toCurrency(),
              style: FontPalette.base700(16, color: colors.primary),
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          children: [
            Icon(
              Icons.person_outline_rounded,
              size: 16.r,
              color: colors.secondaryText,
            ),
            4.horizontalSpace,
            Expanded(
              child: Text(
                _customerLabel,
                style: FontPalette.base500(13, color: colors.primaryText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            8.horizontalSpace,
            BillPaymentMethodChip(method: bill.paymentMethod, colors: colors),
            6.horizontalSpace,
            BillStatusBadge(status: bill.paymentStatus),
            if (hasBalance) ...[
              6.horizontalSpace,
              BillBalanceBadge(balance: bill.balance),
            ],
          ],
        ),
      ],
    );
  }
}

/// Tappable bill summary card for dashboard and list previews.
class BillSummaryCard extends StatelessWidget {
  const BillSummaryCard({
    super.key,
    required this.bill,
    this.onTap,
  });

  final BillModel bill;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return CommonContainer(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      borderRadius: 16.r,
      border: Border.all(color: colors.inputBorder, width: 1.w),
      color: colors.surface,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      child: BillSummaryContent(bill: bill),
    );
  }
}

class BillPaymentMethodChip extends StatelessWidget {
  const BillPaymentMethodChip({
    super.key,
    required this.method,
    required this.colors,
  });

  final String method;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colors.inputBackground,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: colors.inputBorder, width: 1.w),
      ),
      child: Text(
        method,
        style: FontPalette.base500(10, color: colors.secondaryText),
      ),
    );
  }
}

class BillStatusBadge extends StatelessWidget {
  const BillStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isPaid = status.toLowerCase() == 'paid';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
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
        status,
        style: FontPalette.base600(
          10,
          color: isPaid
              ? ColorPalette.homePaidBadgeBorder
              : ColorPalette.formValidationErrorColor,
        ),
      ),
    );
  }
}

class BillBalanceBadge extends StatelessWidget {
  const BillBalanceBadge({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ColorPalette.homeStatOrangeBg,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: ColorPalette.homeOrangeAccent,
          width: 1.w,
        ),
      ),
      child: Text(
        'Due ${balance.toCurrency()}',
        style: FontPalette.base600(10, color: ColorPalette.homeOrangeAccent),
      ),
    );
  }
}
