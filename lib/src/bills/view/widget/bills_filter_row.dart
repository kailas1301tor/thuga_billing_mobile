// lib/src/bills/view/widget/bills_filter_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_bottom_sheet.dart';

import 'bills_filter_sheet.dart';

class BillsFilterRow extends StatelessWidget {
  const BillsFilterRow({
    super.key,
    required this.selectedDate,
    required this.selectedStatus,
    required this.selectedPayment,
    required this.onDateChanged,
    required this.onStatusChanged,
    required this.onPaymentChanged,
    required this.onClearPressed,
  });

  final String selectedDate;
  final String selectedStatus;
  final String selectedPayment;
  final ValueChanged<String> onDateChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onPaymentChanged;
  final VoidCallback onClearPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final isDateActive = selectedDate != 'All Time' && selectedDate != 'All';
    final isStatusActive = selectedStatus != 'All';
    final isPaymentActive = selectedPayment != 'All';
    final isClearActive = isDateActive || isStatusActive || isPaymentActive;

    int activeCount = 0;
    if (isDateActive) activeCount++;
    if (isStatusActive) activeCount++;
    if (isPaymentActive) activeCount++;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // 1. Filters main button
          _buildMainFilterButton(context, activeCount, colors),
          8.horizontalSpace,

          // 2. Active filter tags (scrollable horizontally)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (isDateActive) ...[
                    _buildActiveTag(
                      text: selectedDate,
                      onClear: () => onDateChanged('All Time'),
                      colors: colors,
                    ),
                    6.horizontalSpace,
                  ],
                  if (isStatusActive) ...[
                    _buildActiveTag(
                      text: selectedStatus,
                      onClear: () => onStatusChanged('All'),
                      colors: colors,
                    ),
                    6.horizontalSpace,
                  ],
                  if (isPaymentActive) ...[
                    _buildActiveTag(
                      text: selectedPayment,
                      onClear: () => onPaymentChanged('All'),
                      colors: colors,
                    ),
                    6.horizontalSpace,
                  ],
                ],
              ),
            ),
          ),

          // 3. Clear all button
          if (isClearActive) ...[
            8.horizontalSpace,
            GestureDetector(
              onTap: onClearPressed,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Clear',
                    style: FontPalette.base600(
                      12,
                      color: colors.primary,
                    ),
                  ),
                  2.horizontalSpace,
                  Icon(
                    Icons.restart_alt_rounded,
                    size: 14.r,
                    color: colors.primary,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _openFiltersSheet(BuildContext context) {
    CommonBottomSheet.show(
      context: context,
      title: 'Filters',
      isScrollControlled: true,
      child: BillsFilterSheet(
        initialDateRange: selectedDate,
        initialStatus: selectedStatus,
        initialPayment: selectedPayment,
        onApply: (date, status, payment) {
          onDateChanged(date);
          onStatusChanged(status);
          onPaymentChanged(payment);
        },
      ),
    );
  }

  Widget _buildMainFilterButton(BuildContext context, int activeCount, AppColors colors) {
    final hasActive = activeCount > 0;
    return InkWell(
      onTap: () => _openFiltersSheet(context),
      borderRadius: BorderRadius.circular(100.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: hasActive ? colors.primary.withValues(alpha: 0.1) : colors.surface,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: hasActive ? colors.primary : colors.inputBorder,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_list_rounded,
              size: 14.r,
              color: hasActive ? colors.primary : colors.secondaryText,
            ),
            6.horizontalSpace,
            Text(
              hasActive ? 'Filters ($activeCount)' : 'Filters',
              style: FontPalette.base600(
                12,
                color: hasActive ? colors.primary : colors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTag({
    required String text,
    required VoidCallback onClear,
    required AppColors colors,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 4.h, 6.w, 4.h),
      decoration: BoxDecoration(
        color: colors.inputBackground,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: colors.inputBorder,
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: FontPalette.base500(11, color: colors.primaryText),
          ),
          4.horizontalSpace,
          GestureDetector(
            onTap: onClear,
            child: Icon(
              Icons.close_rounded,
              size: 12.r,
              color: colors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
