// lib/src/new_bill/view/widget/quantity_picker_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/src/main/model/dropdown_model.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import 'package:thuga/utils/common_widgets/bottomsheet_content.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/utils/helpers/product_stock_helper.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';
import 'package:thuga/utils/helpers/unit_conversion_helper.dart';
import '../../model/new_bill_model.dart';
import '../../notifier/new_bill_notifier.dart';

class QuantityPickerSheet extends ConsumerWidget {
  const QuantityPickerSheet({
    super.key,
    required this.product,
    required this.initialQuantity,
    required this.initialUnit,
    required this.onConfirm,
  });

  final ProductModel product;
  final double initialQuantity;
  final String initialUnit;
  final void Function(double qty, String unit) onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(newBillProvider.notifier);
    final productUnit = resolveProductUnit(product.unit);
    final pickerUnit = ref.watch(
      newBillProvider.select((s) => s.quantityPickerUnit ?? initialUnit),
    );
    final allowsUnitSwitch = allowsBillingUnitSwitch(productUnit);
    final allowsDecimal = allowsDecimalQuantity(productUnit);
    final dropdowns = ref.watch(
      dropdownsProvider.select((s) => s.data),
    );
    final unitOptions = allowsUnitSwitch
        ? dropdowns.unitsInSameCategory(productUnit)
        : const <DropdownUnitItemModel>[];
    final selectedUnitItem = unitOptions.isEmpty
        ? null
        : unitOptions.firstWhere(
            (item) => item.id == pickerUnit,
            orElse: () => unitOptions.first,
          );

    final maxQtyInProductUnit = maxPurchasableQuantity(product.quantity);
    final maxQtyDisplay = maxQtyInProductUnit == null
        ? null
        : convertQuantity(
              qty: maxQtyInProductUnit,
              fromUnit: productUnit,
              toUnit: pickerUnit,
            ) ??
            maxQtyInProductUnit;
    final isTracked = isStockTracked(product.quantity);

    final initialText = initialQuantity > 0
        ? formatQuantityDisplay(initialQuantity)
        : '1';
    if (notifier.quantityController.text != initialText) {
      notifier.quantityController.text = initialText;
    }

    final quickPicks = const [1.0, 2.0, 3.0, 5.0, 10.0]
        .where((pick) => maxQtyDisplay == null || pick <= maxQtyDisplay)
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
                      '${Strings.unitPriceLabel}: ${product.price.toCurrency()} / ${dropdowns.displayNameForUnit(productUnit)}',
                      style: FontPalette.base500(12, color: colors.secondaryText),
                    ),
                    if (isTracked && maxQtyDisplay != null && maxQtyDisplay > 0) ...[
                      4.verticalSpace,
                      Text(
                        Strings.productAvailableStockQty(maxQtyDisplay),
                        style: FontPalette.base500(12, color: colors.primary),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (allowsUnitSwitch) ...[
            20.verticalSpace,
            _buildLabeledField(
              context: context,
              label: Strings.unit,
              child: GestureDetector(
                onTap: unitOptions.isEmpty
                    ? null
                    : () {
                        showSingleSelectBottomSheet<DropdownUnitItemModel>(
                          context: context,
                          ref: ref,
                          title: Strings.selectUnit,
                          options: unitOptions,
                          currentValue: selectedUnitItem,
                          onSelected: (selected) {
                            notifier.setQuantityPickerUnit(selected.id);
                          },
                          displayText: (item) => item.name,
                        );
                      },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: colors.inputBackground,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          dropdowns.displayNameForUnit(pickerUnit),
                          style: FontPalette.base400(
                            14,
                            color: colors.primaryText,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: colors.secondaryText,
                        size: 20.r,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          20.verticalSpace,
          Text(
            Strings.quickSelect,
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
                        final currentQty = double.tryParse(val.text) ?? 0;
                        final isSelected = currentQty == pick;
                        return GestureDetector(
                          onTap: () {
                            notifier.quantityController.text =
                                formatQuantityDisplay(pick);
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
                              formatQuantityDisplay(pick),
                              style: FontPalette.base700(
                                14,
                                color: isSelected
                                    ? ColorPalette.white
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
            title: Strings.customQuantity,
            hintText: Strings.customQuantityHint,
            controller: notifier.quantityController,
            inputType: TextInputType.numberWithOptions(decimal: allowsDecimal),
            inputFormatters: allowsDecimal
                ? [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d*'),
                    ),
                  ]
                : [FilteringTextInputFormatter.digitsOnly],
          ),
          24.verticalSpace,
          PrimaryButton(
            text: Strings.setQuantity,
            radius: 12,
            onPressed: quickPicks.isEmpty && isOutOfStock(product.quantity)
                ? null
                : () {
                    final qty = allowsDecimal
                        ? double.tryParse(notifier.quantityController.text) ?? 1
                        : (double.tryParse(notifier.quantityController.text) ??
                            1);
                    if (isOutOfStock(product.quantity)) {
                      showCustomErrorToast(message: Strings.productOutOfStock);
                      return;
                    }
                    final cappedQty = clampBillingQuantity(
                      stockQuantity: product.quantity,
                      requestedBillingQty: qty,
                      billingUnit: pickerUnit,
                      productUnit: productUnit,
                    );
                    if (cappedQty <= 0) {
                      showCustomErrorToast(message: Strings.productOutOfStock);
                      return;
                    }
                    if (cappedQty < qty) {
                      showCustomErrorToast(
                        message: Strings.productInsufficientStockQty(
                          maxQtyDisplay ?? cappedQty,
                        ),
                      );
                    }
                    onConfirm(cappedQty, pickerUnit);
                    notifier.clearQuantityPickerUnit();
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
                  side: BorderSide(color: colors.errorText.withValues(alpha: 0.4), width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  onConfirm(0, pickerUnit);
                  notifier.clearQuantityPickerUnit();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      color: colors.errorText,
                      size: 20.r,
                    ),
                    6.horizontalSpace,
                    Text(
                      Strings.removeProduct,
                      style: FontPalette.base600(14, color: colors.errorText),
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

  Widget _buildLabeledField({
    required BuildContext context,
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FontPalette.base600(13, color: context.appColors.secondaryText),
        ),
        8.verticalSpace,
        child,
      ],
    );
  }
}
