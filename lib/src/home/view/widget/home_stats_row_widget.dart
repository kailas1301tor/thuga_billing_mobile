// lib/src/home/view/widget/home_stats_row_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

class HomeStatsRowWidget extends StatelessWidget {
  const HomeStatsRowWidget({
    super.key,
    required this.billCount,
    required this.billCountDelta,
    required this.avgBillValue,
    required this.avgBillChangePercent,
    required this.bestSellerName,
    required this.bestSellerQty,
  });

  final int billCount;
  final int billCountDelta;
  final double avgBillValue;
  final double avgBillChangePercent;
  final String bestSellerName;
  final int bestSellerQty;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _StatCard(
              backgroundColor: ColorPalette.homeStatGreenBg,
              iconColor: colors.primary,
              icon: Icons.receipt_long_outlined,
              label: Strings.bills,
              value: '$billCount',
              delta: '+$billCountDelta ${Strings.vsYesterday}',
              deltaColor: colors.primary,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: _StatCard(
              backgroundColor: ColorPalette.homeStatOrangeBg,
              iconColor: ColorPalette.homeOrangeAccent,
              icon: Icons.star_rounded,
              label: Strings.avgBillValue,
              value: avgBillValue.toCurrency(),
              delta:
                  '+${avgBillChangePercent.toStringAsFixed(1)}% ${Strings.vsYesterday}',
              deltaColor: colors.primary,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: _StatCard(
              backgroundColor: ColorPalette.homeStatPurpleBg,
              iconColor: ColorPalette.homePurpleAccent,
              icon: Icons.show_chart_rounded,
              label: Strings.bestSeller,
              value: bestSellerName,
              delta: '$bestSellerQty ${Strings.sold}',
              deltaColor: ColorPalette.homePurpleAccent,
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.value,
    required this.delta,
    required this.deltaColor,
  });

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final String label;
  final String value;
  final String delta;
  final Color deltaColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CommonContainer(
      padding: EdgeInsets.all(12.r),
      borderRadius: 14.r,
      color: isDark ? colors.inputBackground : backgroundColor,
      border: Border.all(color: colors.inputBorder, width: 1.h),
      boxShadow: const [],
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            CommonContainer(
              width: 28.r,
              height: 28.r,
              padding: EdgeInsets.zero,
              borderRadius: 8.r,
              color: iconColor.withValues(alpha: 0.15),
              boxShadow: const [],
              child: Center(child: Icon(icon, size: 16.r, color: iconColor)),
            ),
          10.verticalSpace,
          Text(
            label,
            style: FontPalette.base400(10, color: colors.secondaryText),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          4.verticalSpace,
          Text(
            value,
            style: FontPalette.base700(14, color: colors.primaryText),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            delta,
            style: FontPalette.base500(9, color: deltaColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        ),
      ),
    );
  }
}
