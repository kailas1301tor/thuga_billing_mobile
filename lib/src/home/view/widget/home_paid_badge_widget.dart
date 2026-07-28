// lib/src/home/view/widget/home_paid_badge_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';

class HomePaidBadgeWidget extends StatelessWidget {
  const HomePaidBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      borderRadius: 20.r,
      color: ColorPalette.homePaidBadgeBg,
      border: Border.all(color: ColorPalette.homePaidBadgeBorder, width: 1),
      boxShadow: const [],
      child: Text(
        Strings.paid,
        style: FontPalette.base600(11, color: ColorPalette.primaryColor),
      ),
    );
  }
}
