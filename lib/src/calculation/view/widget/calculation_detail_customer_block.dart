// lib/src/calculation/view/widget/calculation_detail_customer_block.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import '../../model/calculation_bill_model.dart';

class CalculationDetailCustomerBlock extends StatelessWidget {
  const CalculationDetailCustomerBlock({
    super.key,
    required this.section,
    required this.prices,
  });

  final CalculationCustomerSectionModel section;
  final Map<int, double> prices;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final subtotal = section.items.fold<double>(
      0,
      (sum, item) => sum + item.quantity * (prices[item.productId] ?? 0),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CommonContainer(
        padding: EdgeInsets.all(16.w),
        borderRadius: 16.r,
        border: Border.all(color: colors.inputBorder, width: 1.w),
        color: colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              section.customerName.toUpperCase(),
              style: FontPalette.base700(14, color: colors.primaryText),
            ),
            12.verticalSpace,
            ...section.items.map((item) {
              final price = prices[item.productId];
              final lineTotal = price != null ? item.quantity * price : null;
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.productName,
                        style: FontPalette.base500(13, color: colors.primaryText),
                      ),
                    ),
                    Text(
                      '${item.quantity}',
                      style: FontPalette.base600(13, color: colors.secondaryText),
                    ),
                    16.horizontalSpace,
                    SizedBox(
                      width: 72.w,
                      child: Text(
                        lineTotal != null
                            ? lineTotal.toCurrency()
                            : Strings.productUnavailable,
                        textAlign: TextAlign.end,
                        style: FontPalette.base600(
                          13,
                          color: lineTotal != null
                              ? colors.primaryText
                              : colors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Divider(color: colors.inputBorder, height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.customerSubtotal,
                  style: FontPalette.base600(13, color: colors.secondaryText),
                ),
                Text(
                  subtotal.toCurrency(),
                  style: FontPalette.base700(14, color: colors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
