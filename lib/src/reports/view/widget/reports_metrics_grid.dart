// lib/src/reports/view/widget/reports_metrics_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import '../../model/reports_model.dart';

class ReportsMetricsGrid extends StatelessWidget {
  const ReportsMetricsGrid({super.key, this.summary});

  final ReportSummaryModel? summary;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.15,
      children: [
        _MetricCard(
          title: Strings.totalSales,
          value: summary != null ? summary!.totalSales.toCurrency() : '—',
          icon: Icons.auto_graph_rounded,
          color: colors.primary,
          bgColor: colors.primary.withValues(alpha: 0.08),
        ),
        _MetricCard(
          title: Strings.totalBills,
          value: '${summary?.totalBills ?? 0}',
          icon: Icons.receipt_long_rounded,
          color: colors.primaryText,
          bgColor: colors.inputBackground,
        ),
        _MetricCard(
          title: Strings.avgBillValue,
          value: summary != null ? summary!.avgBillValue.toCurrency() : '—',
          icon: Icons.analytics_outlined,
          color: Colors.blueAccent,
          bgColor: Colors.blueAccent.withValues(alpha: 0.08),
        ),
        _MetricCard(
          title: Strings.pendingBills,
          value: '${summary?.pendingBills ?? 0}',
          icon: Icons.pending_actions_rounded,
          color: (summary?.pendingBills ?? 0) > 0
              ? colors.errorText
              : colors.secondaryText,
          bgColor: (summary?.pendingBills ?? 0) > 0
              ? colors.errorText.withValues(alpha: 0.08)
              : colors.inputBackground,
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ClipRect(
      child: CommonContainer(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
        borderRadius: 20.r,
        border: Border.all(color: colors.inputBorder, width: 1.w),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: FontPalette.base500(
                            11,
                            color: colors.secondaryText,
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(icon, size: 16.r, color: color),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontPalette.base700(20, color: colors.primaryText),
                  ),
                  2.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.updatedJustNow,
                        maxLines: 1,
                        style: FontPalette.base400(
                          10,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
