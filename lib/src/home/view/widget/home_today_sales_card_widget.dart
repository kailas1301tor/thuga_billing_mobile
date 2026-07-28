// lib/src/home/view/widget/home_today_sales_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/helpers/extensions.dart';

class HomeTodaySalesCardWidget extends StatelessWidget {
  const HomeTodaySalesCardWidget({
    super.key,
    required this.todaySales,
    required this.salesChangePercent,
  });

  final double todaySales;
  final double salesChangePercent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      child: CommonContainer(
        padding: EdgeInsets.all(20.r),
        borderRadius: 16.r,
        gradient: ColorPalette.primaryGradient,
        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.r),
        boxShadow: const [],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.todaysSales,
              style: FontPalette.base500(13, color: ColorPalette.white),
            ),
            8.verticalSpace,
            Text(
              todaySales.toCurrency(),
              style: FontPalette.base700(32, color: ColorPalette.white),
            ),
            16.verticalSpace,
            CommonContainer(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 6.h,
              ),
              borderRadius: 20.r,
              color: ColorPalette.white.withValues(alpha: 0.2),
              boxShadow: const [],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    salesChangePercent < 0
                        ? Icons.trending_down_rounded
                        : Icons.trending_up_rounded,
                    size: 14.r,
                    color: ColorPalette.white,
                  ),
                  4.horizontalSpace,
                  Text(
                    '${salesChangePercent >= 0 ? '+' : ''}${salesChangePercent.toStringAsFixed(1)}%',
                    style: FontPalette.base600(
                      12,
                      color: ColorPalette.white,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    Strings.vsYesterday,
                    style: FontPalette.base400(
                      12,
                      color: ColorPalette.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
