// lib/src/new_bill/view/widget/payment_qr_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/common_widgets/common_loader.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:tuple/tuple.dart';
import '../../notifier/new_bill_notifier.dart';

class PaymentQrSheet extends ConsumerWidget {
  const PaymentQrSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final data = ref.watch(
      newBillProvider.select(
        (s) => Tuple2(s.paymentQrLoaderState, s.paymentQrUrl),
      ),
    );
    final loaderState = data.item1;
    final qrUrl = data.item2;
    final notifier = ref.read(newBillProvider.notifier);

    return SizedBox(
      height: 0.55.sh,
      child: switch (loaderState) {
        LoaderState.loading => const Center(child: CommonLoader()),
        LoaderState.noData || LoaderState.noSearchData => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              Strings.paymentQrEmpty,
              style: FontPalette.base400(14, color: colors.secondaryText),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        LoaderState.error ||
        LoaderState.networkError ||
        LoaderState.serverError => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Strings.paymentQrLoadFailed,
                  style: FontPalette.base500(14, color: colors.primaryText),
                  textAlign: TextAlign.center,
                ),
                16.verticalSpace,
                PrimaryButton(
                  text: Strings.refresh,
                  onPressed: notifier.loadPaymentQr,
                  height: 44,
                ),
              ],
            ),
          ),
        ),
        LoaderState.loaded => Column(
          children: [
            Expanded(
              child: Center(
                child: qrUrl == null || qrUrl.isEmpty
                    ? Text(
                        Strings.paymentQrEmpty,
                        style: FontPalette.base400(
                          14,
                          color: colors.secondaryText,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : CommonCachedNetworkImage(
                        imageUrl: qrUrl,
                        width: 260.r,
                        height: 260.r,
                        memCacheWidth: 520,
                        memCacheHeight: 520,
                        fit: BoxFit.contain,
                        borderRadius: 16,
                      ),
              ),
            ),
            12.verticalSpace,
            Text(
              Strings.paymentQrScanHelper,
              style: FontPalette.base400(13, color: colors.secondaryText),
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,
          ],
        ),
      },
    );
  }
}
