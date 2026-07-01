// lib/src/bills/view/widget/bill_item_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/bills/model/bill_model.dart';
import 'package:vyapapp/src/main/notifier/dropdowns_notifier.dart';
import 'package:vyapapp/src/main/model/dropdown_model.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

class BillItemCard extends ConsumerWidget {
  const BillItemCard({super.key, required this.bill, this.onTap});

  final BillModel bill;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    final customers = ref.watch(
      dropdownsNotifierProvider.select((s) => s.data.customers),
    );
    final customerLabel = bill.customerId != null
        ? customers
            .firstWhere(
              (c) => c.id == bill.customerId,
              orElse: () => DropdownCustomerModel(
                id: bill.customerId!,
                name: 'Customer #${bill.customerId}',
              ),
            )
            .name
        : 'Walk-in Customer';

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
                    bill.orderNumber,
                    style: FontPalette.base700(16, color: colors.primaryText),
                  ),
                  4.verticalSpace,
                  Text(
                    bill.dateString,
                    style: FontPalette.base400(13, color: colors.secondaryText),
                  ),
                  4.verticalSpace,
                  Text(
                    customerLabel,
                    style: FontPalette.base500(13, color: colors.primaryText),
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      Text(
                        bill.paymentMethod,
                        style: FontPalette.base400(12, color: colors.secondaryText),
                      ),
                      8.horizontalSpace,
                      _StatusBadge(status: bill.paymentStatus),
                    ],
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  bill.totalAmount.toCurrency(),
                  style: FontPalette.base700(16, color: colors.primary),
                ),
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
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isPaid = status.toLowerCase() == 'paid';
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
        status,
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
