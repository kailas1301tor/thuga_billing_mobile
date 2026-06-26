// /Users/wac/Documents/wac projects/tsuite/lib/utils/common_widgets/common_otp_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';

class CommonOtpField extends StatelessWidget {
  const CommonOtpField({
    super.key,
    this.controller,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
  });

  final TextEditingController? controller;
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final pinTheme = PinTheme(
      width: 62.w,
      height: 62.w,
      textStyle: FontPalette.base600(20, color: colors.primaryText),
      decoration: BoxDecoration(
        color: colors.inputBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colors.inputBorder),
      ),
    );

    return Pinput(
      controller: controller,
      length: length,
      defaultPinTheme: pinTheme,
      focusedPinTheme: pinTheme.copyDecorationWith(
        border: Border.all(color: colors.accent),
      ),
      submittedPinTheme: pinTheme,
      onChanged: onChanged,
      onCompleted: onCompleted,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
