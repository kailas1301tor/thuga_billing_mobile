// lib/src/bills/view/widget/bill_payment_status_action.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';

class BillPaymentStatusAction extends StatelessWidget {
  const BillPaymentStatusAction({
    super.key,
    required this.paymentStatus,
    required this.isLoading,
    required this.onMarkPaid,
    required this.onMarkUnpaid,
  });

  final String paymentStatus;
  final bool isLoading;
  final VoidCallback onMarkPaid;
  final VoidCallback onMarkUnpaid;

  bool get _isPaid => paymentStatus.toLowerCase() == Strings.paid.toLowerCase();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    if (_isPaid) {
      return SizedBox(
        width: double.infinity,
        height: 38.h,
        child: OutlinedButton.icon(
          onPressed: isLoading ? null : onMarkUnpaid,
          icon: isLoading
              ? SizedBox(
                  width: 16.r,
                  height: 16.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: colors.primary,
                  ),
                )
              : Icon(Icons.money_off_outlined, size: 16.r),
          label: Text(
            Strings.markAsUnpaid,
            style: FontPalette.base600(13, color: colors.primaryText),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.primaryText,
            side: BorderSide(color: colors.inputBorder, width: 1.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      );
    }

    return PrimaryButton(
      height: 38,
      text: Strings.markAsPaid,
      radius: 12,
      isLoading: isLoading,
      prefixIcon: Icon(Icons.check_circle_outline_rounded, size: 18.r),
      onPressed: isLoading ? null : onMarkPaid,
    );
  }
}

bool billShowsPaidDate(String paymentStatus, String? paidDate) {
  return paymentStatus.toLowerCase() == Strings.paid.toLowerCase() &&
      paidDate?.trim().isNotEmpty == true;
}
