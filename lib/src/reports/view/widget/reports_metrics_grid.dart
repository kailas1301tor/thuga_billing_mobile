// lib/src/reports/view/widget/reports_metrics_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
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
      childAspectRatio: 1.45,
      children: [
        // 1. Total Sales
        _buildMetricCard(
          context: context,
          title: 'Total Sales',
          value: '₹${summary?.totalSales.toStringAsFixed(0)}',
          icon: Icons.auto_graph_rounded,
          color: colors.primary,
          bgColor: colors.primary.withValues(alpha: 0.08),
        ),
        // 2. Total Bills
        _buildMetricCard(
          context: context,
          title: 'Total Bills',
          value: '${summary?.totalBills}',
          icon: Icons.receipt_long_rounded,
          color: colors.primaryText,
          bgColor: colors.inputBackground,
        ),
        // 3. Avg Bill Value
        _buildMetricCard(
          context: context,
          title: 'Avg. Bill Value',
          value: '₹${summary?.avgBillValue.toStringAsFixed(0)}',
          icon: Icons.analytics_outlined,
          color: Colors.blueAccent,
          bgColor: Colors.blueAccent.withValues(alpha: 0.08),
        ),
        // 4. Pending Bills
        _buildMetricCard(
          context: context,
          title: 'Pending Bills',
          value: '${summary?.pendingBills}',
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

  Widget _buildMetricCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    final colors = context.appColors;

    return CommonContainer(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      borderRadius: 20.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: FontPalette.base500(12, color: colors.secondaryText),
              ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: FontPalette.base700(20, color: colors.primaryText),
              ),
              2.verticalSpace,
              Text(
                'Updated just now',
                style: FontPalette.base400(10, color: colors.secondaryText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
