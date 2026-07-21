// lib/src/home/view/widget/home_section_empty_text.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

class HomeSectionEmptyText extends StatelessWidget {
  const HomeSectionEmptyText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          style: FontPalette.base400(13, color: colors.secondaryText),
        ),
      ),
    );
  }
}
