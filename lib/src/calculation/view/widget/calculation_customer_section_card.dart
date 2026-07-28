// lib/src/calculation/view/widget/calculation_customer_section_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import '../../model/calculation_bill_model.dart';

class CalculationCustomerSectionCard extends StatelessWidget {
  const CalculationCustomerSectionCard({
    super.key,
    required this.section,
    required this.isExpanded,
    required this.subtotal,
    required this.onTap,
    required this.onRemove,
    required this.child,
  });

  final CalculationCustomerSectionModel section;
  final bool isExpanded;
  final double subtotal;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: CommonContainer(
        padding: EdgeInsets.zero,
        borderRadius: 14.r,
        border: Border.all(
          color: isExpanded ? colors.primary : colors.inputBorder,
          width: isExpanded ? 1.5.w : 1.w,
        ),
        color: colors.surface,
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      size: 20.r,
                      color: colors.primary,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.customerName,
                            style: FontPalette.base700(
                              14,
                              color: colors.primaryText,
                            ),
                          ),
                          Text(
                            '${section.items.length} items · ${subtotal.toCurrency()}',
                            style: FontPalette.base400(
                              11,
                              color: colors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onRemove,
                      icon: Icon(
                        Icons.close_rounded,
                        size: 20.r,
                        color: colors.errorText,
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: colors.secondaryText,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded) ...[
              Divider(height: 1.h, color: colors.inputBorder),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: child,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
