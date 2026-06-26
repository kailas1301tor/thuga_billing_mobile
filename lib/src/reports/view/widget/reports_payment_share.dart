// lib/src/reports/view/widget/reports_payment_share.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import '../../model/reports_model.dart';

class ReportsPaymentShare extends StatelessWidget {
  const ReportsPaymentShare({
    super.key,
    required this.shares,
  });

  final List<PaymentShareModel> shares;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    // Define colors for each payment method
    Color getMethodColor(String method) {
      switch (method.toUpperCase()) {
        case 'CASH':
          return colors.primary;
        case 'UPI':
          return const Color(0xFF8B5CF6); // Violet
        case 'CARD':
          return const Color(0xFF3B82F6); // Blue
        default:
          return colors.secondaryText;
      }
    }

    // Filter out shares that have 0 amount to build a clean distribution bar
    final validShares = shares.where((share) => share.amount > 0).toList();

    return CommonContainer(
      padding: EdgeInsets.all(16.r),
      borderRadius: 20.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Mode Share',
            style: FontPalette.base700(14, color: colors.primaryText),
          ),
          16.verticalSpace,

          // Horizontal Segmented Progress Bar
          if (validShares.isEmpty)
            Container(
              height: 12.h,
              decoration: BoxDecoration(
                color: colors.inputBackground,
                borderRadius: BorderRadius.circular(6.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'No transactions',
                style: FontPalette.base400(9, color: colors.secondaryText),
              ),
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: SizedBox(
                height: 12.h,
                child: Row(
                  children: validShares.map((share) {
                    final percentage = share.percentage;
                    return Expanded(
                      flex: (percentage * 100).round(),
                      child: Container(
                        color: getMethodColor(share.paymentMethod),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          16.verticalSpace,

          // Legends / Details Grid
          Column(
            children: shares.map((share) {
              final methodColor = getMethodColor(share.paymentMethod);
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10.r,
                          height: 10.r,
                          decoration: BoxDecoration(
                            color: methodColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        8.horizontalSpace,
                        Text(
                          share.paymentMethod,
                          style: FontPalette.base500(13, color: colors.primaryText),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '₹${share.amount.toStringAsFixed(0)}',
                          style: FontPalette.base600(13, color: colors.primaryText),
                        ),
                        8.horizontalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: methodColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            '${share.percentage.toStringAsFixed(0)}%',
                            style: FontPalette.base700(10, color: methodColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
