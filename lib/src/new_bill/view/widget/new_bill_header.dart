// lib/src/new_bill/view/widget/new_bill_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

class NewBillHeader extends StatelessWidget implements PreferredSizeWidget {
  const NewBillHeader({super.key, required this.billNumber});

  final int billNumber;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SafeArea(
      bottom: false,
      child: Container(
        height: preferredSize.height,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Back button
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.r,
                color: colors.primaryText,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

            // Center: Title & Bill Number
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'New Bill',
                  style: FontPalette.base700(17, color: colors.primaryText),
                ),
                2.verticalSpace,
                Text(
                  '#$billNumber',
                  style: FontPalette.base500(12, color: colors.secondaryText),
                ),
              ],
            ),

            // Right: Empty placeholder to keep center title aligned
            SizedBox(width: 40.w),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
