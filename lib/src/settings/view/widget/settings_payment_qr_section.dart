// lib/src/settings/view/widget/settings_payment_qr_section.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:tuple/tuple.dart';
import '../../notifier/settings_notifier.dart';

class SettingsPaymentQrSection extends ConsumerWidget {
  const SettingsPaymentQrSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(settingsProvider.notifier);
    final qrData = ref.watch(
      settingsProvider.select(
        (s) => Tuple2(s.selectedQrPath, s.companyDetails?.qrCode),
      ),
    );
    final selectedQrPath = qrData.item1;
    final remoteQrUrl = qrData.item2;
    final hasLocal = selectedQrPath != null && selectedQrPath.isNotEmpty;
    final hasRemote = remoteQrUrl != null && remoteQrUrl.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Strings.paymentQrSectionTitle,
          style: FontPalette.base600(13, color: colors.primaryText),
        ),
        4.verticalSpace,
        Text(
          Strings.paymentQrHint,
          style: FontPalette.base400(12, color: colors.secondaryText),
        ),
        12.verticalSpace,
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: notifier.pickPaymentQr,
            child: Container(
              width: 160.r,
              height: 160.r,
              decoration: BoxDecoration(
                color: colors.inputBackground,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: colors.inputBorder, width: 1.5.w),
              ),
              clipBehavior: Clip.antiAlias,
              child: hasLocal
                  ? Image.file(File(selectedQrPath), fit: BoxFit.cover)
                  : hasRemote
                  ? CommonCachedNetworkImage(
                      imageUrl: remoteQrUrl,
                      width: 160.r,
                      height: 160.r,
                      memCacheWidth: 320,
                      memCacheHeight: 320,
                      fit: BoxFit.cover,
                      borderRadius: 16,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_2_rounded,
                          size: 36.r,
                          color: colors.secondaryText,
                        ),
                        8.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            Strings.paymentQrAdd,
                            style: FontPalette.base500(
                              12,
                              color: colors.primaryText,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        if (hasLocal) ...[
          8.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: notifier.clearSelectedPaymentQr,
              child: Text(
                Strings.paymentQrClearLocal,
                style: FontPalette.base500(12, color: colors.primary),
              ),
            ),
          ),
        ] else if (hasRemote) ...[
          8.verticalSpace,
          Text(
            Strings.paymentQrChange,
            style: FontPalette.base400(12, color: colors.secondaryText),
          ),
        ],
      ],
    );
  }
}
