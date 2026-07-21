// lib/src/bills/view/widget/bill_item_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/bills/model/bill_model.dart';
import 'package:vyapapp/src/bills/notifier/bills_notifier.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

import 'bill_payment_status_action.dart';
import 'bill_summary_card.dart';

class BillItemCard extends ConsumerWidget {
  const BillItemCard({super.key, required this.bill, this.onTap});

  final BillModel bill;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final customerLabel = bill.customerName?.isNotEmpty == true
        ? bill.customerName!
        : Strings.walkInCustomer;
    final hasBalance = bill.balance > 0;
    final isUpdating = ref.watch(
      billsNotifierProvider.select((s) => s.updatingBillId == bill.id),
    );
    final notifier = ref.read(billsNotifierProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CommonContainer(
        padding: EdgeInsets.zero,
        borderRadius: 20.r,
        border: Border.all(color: colors.inputBorder, width: 1.w),
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 6.h,
            ),
            childrenPadding: EdgeInsets.zero,
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            collapsedShape:
                const RoundedRectangleBorder(side: BorderSide.none),
            trailing: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22.r,
              color: colors.secondaryText,
            ),
            title: BillSummaryContent(bill: bill),
            children: [
              _ExpandedDetails(
                bill: bill,
                customerLabel: customerLabel,
                hasBalance: hasBalance,
                colors: colors,
                isUpdating: isUpdating,
                onMarkPaid: () => notifier.markBillAsPaid(bill.id),
                onMarkUnpaid: () => notifier.markBillAsUnpaid(bill.id),
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandedDetails extends StatelessWidget {
  const _ExpandedDetails({
    required this.bill,
    required this.customerLabel,
    required this.hasBalance,
    required this.colors,
    required this.isUpdating,
    required this.onMarkPaid,
    required this.onMarkUnpaid,
    this.onTap,
  });

  final BillModel bill;
  final String customerLabel;
  final bool hasBalance;
  final AppColors colors;
  final bool isUpdating;
  final VoidCallback onMarkPaid;
  final VoidCallback onMarkUnpaid;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: colors.inputBorder,
          height: 1.h,
          indent: 16.w,
          endIndent: 16.w,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          child: Column(
            children: [
              _DetailRow(
                label: Strings.totalAmount,
                value: bill.totalAmount.toCurrency(),
                valueColor: colors.primaryText,
                colors: colors,
              ),
              if (bill.discountAmount > 0) ...[
                8.verticalSpace,
                _DetailRow(
                  label: Strings.discount,
                  value: '- ${bill.discountAmount.toCurrency()}',
                  valueColor: ColorPalette.homeOrangeAccent,
                  colors: colors,
                ),
              ],
              8.verticalSpace,
              _DetailRow(
                label: Strings.paidAmount,
                value: bill.paidAmount.toCurrency(),
                valueColor: colors.primary,
                colors: colors,
              ),
              if (hasBalance) ...[
                8.verticalSpace,
                _DetailRow(
                  label: Strings.balanceDue,
                  value: bill.balance.toCurrency(),
                  valueColor: ColorPalette.formValidationErrorColor,
                  colors: colors,
                  isBold: true,
                ),
              ],
              if (billShowsPaidDate(bill.paymentStatus, bill.paidDate)) ...[
                8.verticalSpace,
                _DetailRow(
                  label: Strings.paidOn,
                  value: bill.paidDate!,
                  valueColor: colors.primaryText,
                  colors: colors,
                ),
              ],
              if (bill.customerPhone?.isNotEmpty == true) ...[
                8.verticalSpace,
                _DetailRow(
                  label: Strings.phone,
                  value: bill.customerPhone!,
                  valueColor: colors.primaryText,
                  colors: colors,
                ),
              ],
              14.verticalSpace,
              BillPaymentStatusAction(
                paymentStatus: bill.paymentStatus,
                isLoading: isUpdating,
                onMarkPaid: onMarkPaid,
                onMarkUnpaid: onMarkUnpaid,
              ),
              10.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 38.h,
                child: OutlinedButton.icon(
                  onPressed: onTap,
                  icon: Icon(Icons.visibility_outlined, size: 16.r),
                  label: Text(
                    Strings.viewFullDetails,
                    style: FontPalette.base600(13, color: colors.primary),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.primary,
                    side: BorderSide(color: colors.primary, width: 1.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.colors,
    this.isBold = false,
  });

  final String label;
  final String value;
  final Color valueColor;
  final AppColors colors;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FontPalette.base400(13, color: colors.secondaryText),
        ),
        Text(
          value,
          style: isBold
              ? FontPalette.base700(13, color: valueColor)
              : FontPalette.base500(13, color: valueColor),
        ),
      ],
    );
  }
}
