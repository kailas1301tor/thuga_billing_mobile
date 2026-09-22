// lib/src/bills/view/widget/bills_filter_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/common_functions.dart';
import 'package:thuga/utils/helpers/date_range_labels.dart';

class BillsFilterRow extends StatelessWidget {
  const BillsFilterRow({
    super.key,
    required this.startDate,
    required this.endDate,
    this.selectedPreset,
    required this.selectedStatus,
    required this.onDateRangeChanged,
    required this.onPresetChanged,
    required this.onStatusChanged,
  });

  final DateTime startDate;
  final DateTime endDate;
  final String? selectedPreset;
  final String selectedStatus;
  final void Function(DateTime start, DateTime end) onDateRangeChanged;
  final ValueChanged<String> onPresetChanged;
  final ValueChanged<String> onStatusChanged;

  static const List<String> _datePresets = [
    DateRangeIds.today,
    DateRangeIds.yesterday,
    DateRangeIds.thisWeek,
    DateRangeIds.thisMonth,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Date Preset Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _datePresets.map((preset) {
                final isSelected = selectedPreset == preset;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: ChoiceChip(
                    label: Text(localizedDateRangeLabel(preset)),
                    selected: isSelected,
                    onSelected: (_) => onPresetChanged(preset),
                    selectedColor: colors.primary,
                    checkmarkColor: Colors.white,
                    showCheckmark: false,
                    backgroundColor: colors.inputBackground,
                    labelStyle: FontPalette.base700(
                      12,
                      color: isSelected ? Colors.white : colors.primaryText,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color: isSelected ? colors.primary : colors.inputBorder,
                        width: 1.w,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          8.verticalSpace,

          // 2. Custom Date Range Selector
          GestureDetector(
            onTap: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                initialDateRange: DateTimeRange(
                  start: startDate,
                  end: endDate,
                ),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: colors.primary,
                            onPrimary: Colors.white,
                            surface: colors.surface,
                            onSurface: colors.primaryText,
                          ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                onDateRangeChanged(picked.start, picked.end);
              }
            },
            child: CommonContainer(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              borderRadius: 14.r,
              border: Border.all(color: colors.inputBorder, width: 1.w),
              color: colors.surface,
              child: Row(
                children: [
                  Icon(
                    Icons.date_range_rounded,
                    color: colors.primary,
                    size: 18.r,
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Text(
                      '${formatDate(startDate, pattern: 'dd MMM yyyy')} - ${formatDate(endDate, pattern: 'dd MMM yyyy')}',
                      style: FontPalette.base600(13, color: colors.primaryText),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: colors.secondaryText,
                    size: 22.r,
                  ),
                ],
              ),
            ),
          ),
          8.verticalSpace,

          // 3. Status Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatusChip(
                  label: Strings.all,
                  value: 'All',
                  isSelected: selectedStatus == 'All',
                  colors: colors,
                ),
                8.horizontalSpace,
                _buildStatusChip(
                  label: Strings.paid,
                  value: 'Paid',
                  isSelected: selectedStatus == 'Paid',
                  colors: colors,
                ),
                8.horizontalSpace,
                _buildStatusChip(
                  label: Strings.unpaid,
                  value: 'Unpaid',
                  isSelected: selectedStatus == 'Unpaid',
                  colors: colors,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip({
    required String label,
    required String value,
    required bool isSelected,
    required AppColors colors,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onStatusChanged(value),
      selectedColor: colors.primary,
      checkmarkColor: Colors.white,
      showCheckmark: false,
      backgroundColor: colors.inputBackground,
      labelStyle: FontPalette.base700(
        12,
        color: isSelected ? Colors.white : colors.primaryText,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: isSelected ? colors.primary : colors.inputBorder,
          width: 1.w,
        ),
      ),
    );
  }
}
