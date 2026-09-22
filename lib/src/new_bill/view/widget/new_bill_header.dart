// lib/src/new_bill/view/widget/new_bill_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';

class NewBillHeader extends StatelessWidget implements PreferredSizeWidget {
  const NewBillHeader({
    super.key,
    required this.billNumber,
    this.onScanTap,
  });

  final int billNumber;
  final VoidCallback? onScanTap;

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

            // Right: Barcode Scanner button (or placeholder)
            if (onScanTap != null)
              IconButton(
                onPressed: onScanTap,
                icon: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 24.r,
                  color: colors.primary,
                ),
                tooltip: Strings.scanBarcode,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            else
              SizedBox(width: 40.w),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
