// lib/src/home/view/widget/home_greeting_row_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

class HomeGreetingRowWidget extends StatelessWidget {
  const HomeGreetingRowWidget({
    super.key,
    required this.greetingPrefix,
    required this.shopName,
  });

  final String greetingPrefix;
  final String shopName;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greetingPrefix 👋',
            style: FontPalette.base700(18, color: colors.primaryText),
          ),
          8.verticalSpace,
          Row(
            children: [
              Icon(
                Icons.storefront_outlined,
                size: 16.r,
                color: colors.primary,
              ),
              6.horizontalSpace,
              Flexible(
                child: Text(
                  shopName,
                  style: FontPalette.base500(
                    13,
                    color: colors.secondaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18.r,
                color: colors.secondaryText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
