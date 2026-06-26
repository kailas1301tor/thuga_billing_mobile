// lib/src/bills/view/widget/bills_filter_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';

class BillsFilterSheet extends StatefulWidget {
  const BillsFilterSheet({
    super.key,
    required this.initialDateRange,
    required this.initialStatus,
    required this.initialPayment,
    required this.onApply,
  });

  final String initialDateRange;
  final String initialStatus;
  final String initialPayment;
  final void Function(String dateFilter, String statusFilter, String paymentFilter) onApply;

  @override
  State<BillsFilterSheet> createState() => _BillsFilterSheetState();
}

class _BillsFilterSheetState extends State<BillsFilterSheet> {
  late String localDate;
  late String localStatus;
  late String localPayment;

  @override
  void initState() {
    super.initState();
    localDate = widget.initialDateRange;
    localStatus = widget.initialStatus;
    localPayment = widget.initialPayment;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Date Range
          _buildChoiceSection(
            title: 'Date Range',
            options: const ['Today', 'Yesterday', 'This Week', 'All Time'],
            selectedValue: localDate,
            onChanged: (val) => setState(() => localDate = val),
          ),
          20.verticalSpace,

          // 2. Status
          _buildChoiceSection(
            title: 'Status',
            options: const ['All', 'Paid', 'Pending'],
            selectedValue: localStatus,
            onChanged: (val) => setState(() => localStatus = val),
          ),
          20.verticalSpace,

          // 3. Payment Method
          _buildChoiceSection(
            title: 'Payment Method',
            options: const ['All', 'Cash', 'Card', 'UPI'],
            selectedValue: localPayment,
            onChanged: (val) => setState(() => localPayment = val),
          ),
          24.verticalSpace,

          // 4. Action Row
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      localDate = 'All Time';
                      localStatus = 'All';
                      localPayment = 'All';
                    });
                  },
                  child: Text(
                    'Reset All',
                    style: FontPalette.base600(15, color: colors.errorText),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  text: 'Apply Filters',
                  radius: 12,
                  onPressed: () {
                    widget.onApply(localDate, localStatus, localPayment);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceSection({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onChanged,
  }) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontPalette.base700(13, color: colors.secondaryText),
        ),
        10.verticalSpace,
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: options.map((opt) {
            final isSelected = opt.toLowerCase() == selectedValue.toLowerCase();
            return InkWell(
              onTap: () => onChanged(opt),
              borderRadius: BorderRadius.circular(100.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary.withValues(alpha: 0.1) : colors.surface,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: isSelected ? colors.primary : colors.inputBorder,
                    width: 1.w,
                  ),
                ),
                child: Text(
                  opt,
                  style: FontPalette.base600(
                    13,
                    color: isSelected ? colors.primary : colors.primaryText,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
