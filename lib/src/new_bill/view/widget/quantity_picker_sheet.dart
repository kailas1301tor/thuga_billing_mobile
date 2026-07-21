// lib/src/new_bill/view/widget/quantity_picker_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'package:vyapapp/utils/common_widgets/common_cached_network_image.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';
import 'package:vyapapp/utils/helpers/product_stock_helper.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';
import '../../model/new_bill_model.dart';
import '../../notifier/new_bill_notifier.dart';

class QuantityPickerSheet extends ConsumerWidget {
  const QuantityPickerSheet({
    super.key,
    required this.product,
    required this.initialQuantity,
    required this.onConfirm,
  });

  final ProductModel product;
  final int initialQuantity;
  final void Function(int qty) onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(newBillNotifierProvider.notifier);
    final maxQty = maxPurchasableQuantity(product.quantity);
    final isTracked = isStockTracked(product.quantity);

    final initialText = initialQuantity > 0 ? '$initialQuantity' : '1';
    if (notifier.quantityController.text != initialText) {
      notifier.quantityController.text = initialText;
    }

    final quickPicks = const [1, 2, 3, 5, 10]
        .where((pick) => maxQty == null || pick <= maxQty)
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CommonCachedNetworkImage(
                imageUrl: product.imageUrl ?? '',
                width: 32.r,
                height: 32.r,
                borderRadius: 6.r,
                fit: BoxFit.cover,
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: FontPalette.base700(16, color: colors.primaryText),
                    ),
                    Text(
                      'Unit Price: ${product.price.toCurrency()}',
                      style: FontPalette.base500(12, color: colors.secondaryText),
                    ),
                    if (isTracked && maxQty != null && maxQty > 0) ...[
                      4.verticalSpace,
                      Text(
                        Strings.productAvailableStock(maxQty),
                        style: FontPalette.base500(12, color: colors.primary),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Text(
            'Quick Select',
            style: FontPalette.base600(13, color: colors.secondaryText),
          ),
          8.verticalSpace,
          if (quickPicks.isEmpty)
            Text(
              Strings.productOutOfStock,
              style: FontPalette.base500(13, color: colors.errorText),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: quickPicks.map((pick) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: notifier.quantityController,
                      builder: (context, val, _) {
                        final currentQty = int.tryParse(val.text) ?? 0;
                        final isSelected = currentQty == pick;
                        return GestureDetector(
                          onTap: () {
                            notifier.quantityController.text = '$pick';
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colors.primary
                                  : colors.inputBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? colors.primary
                                    : colors.inputBorder,
                                width: 1.w,
                              ),
                            ),
                            child: Text(
                              '$pick',
                              style: FontPalette.base700(
                                14,
                                color: isSelected
                                    ? Colors.white
                                    : colors.primaryText,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          20.verticalSpace,
          CommonTextFormField(
            title: 'Custom Quantity',
            hintText: 'Enter quantity...',
            controller: notifier.quantityController,
            inputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          24.verticalSpace,
          PrimaryButton(
            text: 'Set Quantity',
            radius: 12,
            onPressed: quickPicks.isEmpty && isOutOfStock(product.quantity)
                ? null
                : () {
                    final qty =
                        int.tryParse(notifier.quantityController.text) ?? 1;
                    if (isOutOfStock(product.quantity)) {
                      showCustomErrorToast(message: Strings.productOutOfStock);
                      return;
                    }
                    final cappedQty = clampCartQuantity(
                      stockQuantity: product.quantity,
                      requestedQty: qty,
                    );
                    if (cappedQty <= 0) {
                      showCustomErrorToast(message: Strings.productOutOfStock);
                      return;
                    }
                    if (cappedQty < qty) {
                      showCustomErrorToast(
                        message: Strings.productInsufficientStock(cappedQty),
                      );
                    }
                    onConfirm(cappedQty);
                    Navigator.pop(context);
                  },
          ),
          if (initialQuantity > 0) ...[
            12.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: BorderSide(color: Colors.red.shade200, width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  onConfirm(0);
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade600,
                      size: 20.r,
                    ),
                    6.horizontalSpace,
                    Text(
                      'Remove Product',
                      style: FontPalette.base600(14, color: Colors.red.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
