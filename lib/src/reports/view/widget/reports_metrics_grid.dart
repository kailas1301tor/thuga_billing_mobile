// lib/src/reports/view/widget/reports_metrics_grid.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/utils/helpers/web_responsive.dart';

import '../../model/reports_model.dart';

class ReportsMetricsGrid extends StatelessWidget {
  const ReportsMetricsGrid({super.key, this.summary});

  final ReportSummaryModel? summary;

  @override
  Widget build(BuildContext context) {
    final metrics = _metrics(context);
    final columns = kIsWeb
        ? webGridColumns(context, mobile: 2, tablet: 2, desktop: 4)
        : 2;
    final spacing = kIsWeb ? WebSpacing.md : 12.w;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: metrics
              .map(
                (metric) => SizedBox(
                  width: itemWidth,
                  child: _MetricCard(metric: metric),
                ),
              )
              .toList(),
        );
      },
    );
  }

  List<_MetricData> _metrics(BuildContext context) {
    final colors = context.appColors;

    return [
      _MetricData(
        title: 'Total Sales',
        value: summary != null ? summary!.totalSales.toCurrency() : '—',
        icon: Icons.auto_graph_rounded,
        color: colors.primary,
        bgColor: colors.primary.withValues(alpha: 0.08),
      ),
      _MetricData(
        title: 'Total Bills',
        value: '${summary?.totalBills ?? 0}',
        icon: Icons.receipt_long_rounded,
        color: colors.primaryText,
        bgColor: colors.inputBackground,
      ),
      _MetricData(
        title: 'Avg. Bill Value',
        value: summary != null ? summary!.avgBillValue.toCurrency() : '—',
        icon: Icons.analytics_outlined,
        color: Colors.blueAccent,
        bgColor: Colors.blueAccent.withValues(alpha: 0.08),
      ),
      _MetricData(
        title: 'Pending Bills',
        value: '${summary?.pendingBills ?? 0}',
        icon: Icons.pending_actions_rounded,
        color: (summary?.pendingBills ?? 0) > 0
            ? colors.errorText
            : colors.secondaryText,
        bgColor: (summary?.pendingBills ?? 0) > 0
            ? colors.errorText.withValues(alpha: 0.08)
            : colors.inputBackground,
      ),
    ];
  }
}

class _MetricData {
  const _MetricData({
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
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final _MetricData metric;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final horizontalPadding = kIsWeb ? WebSpacing.md : 14.w;
    final verticalPadding = kIsWeb ? WebSpacing.sm : 12.h;
    final iconSize = kIsWeb ? 16.0 : 16.r;
    final iconPadding = kIsWeb ? 6.0 : 6.r;
    final radius = kIsWeb ? WebSpacing.cardRadius : 20.r;

    return CommonContainer(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      borderRadius: radius,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(iconPadding),
            decoration: BoxDecoration(
              color: metric.bgColor,
              borderRadius: BorderRadius.circular(kIsWeb ? 8 : 8.r),
            ),
            child: Icon(metric.icon, size: iconSize, color: metric.color),
          ),
          SizedBox(width: kIsWeb ? WebSpacing.sm : 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  metric.title,
                  style: FontPalette.base500(12, color: colors.secondaryText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: kIsWeb ? 4 : 4.h),
                Text(
                  metric.value,
                  style: FontPalette.base700(
                    kIsWeb ? 18 : 20,
                    color: colors.primaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
