// lib/utils/common_widgets/common_dialog_box.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';

class CommonDialogBox extends StatelessWidget {
  const CommonDialogBox({
    super.key,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.isLoadingPrimary = false,
    this.autoPop = true,
  });

  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool isLoadingPrimary;
  final bool autoPop;

  static const double _maxDialogWidth = 400;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    required String primaryLabel,
    required VoidCallback onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool autoPop = true,
  }) {
    return showDialog<T>(
      context: context,
      builder: (_) => CommonDialogBox(
        title: title,
        message: message,
        primaryLabel: primaryLabel,
        onPrimary: onPrimary,
        secondaryLabel: secondaryLabel,
        onSecondary: onSecondary,
        autoPop: autoPop,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final horizontalInset = kIsWeb ? 24.0 : 24.w;
    final contentPadding = kIsWeb ? 24.0 : 24.r;
    final buttonWidth = kIsWeb ? 120.0 : 128.w;
    final buttonHeight = kIsWeb ? 44.0 : 48.h;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: horizontalInset),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kIsWeb ? 16 : 24.r),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxDialogWidth),
        child: Padding(
          padding: EdgeInsets.all(contentPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: FontPalette.base700(20, color: colors.primaryText),
              ),
              SizedBox(height: kIsWeb ? 12 : 12.h),
              Text(
                message,
                textAlign: TextAlign.start,
                style: FontPalette.base400(14, color: colors.secondaryText),
              ),
              SizedBox(height: kIsWeb ? 24 : 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (secondaryLabel != null) ...[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onSecondary?.call();
                      },
                      child: Text(
                        secondaryLabel ?? Strings.cancel,
                        style: FontPalette.base600(
                          14,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                    SizedBox(width: kIsWeb ? 8 : 8.w),
                  ],
                  PrimaryButton(
                    width: buttonWidth,
                    height: buttonHeight,
                    text: primaryLabel,
                    isLoading: isLoadingPrimary,
                    onPressed: () {
                      if (autoPop) Navigator.of(context).pop();
                      onPrimary();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
