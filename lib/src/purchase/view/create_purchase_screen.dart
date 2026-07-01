// lib/src/purchase/view/create_purchase_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/main/notifier/dropdowns_notifier.dart';
import 'package:vyapapp/src/main/model/dropdown_model.dart';
import 'package:vyapapp/utils/common_widgets/bottomsheet_content.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'package:vyapapp/utils/helpers/common_functions.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';
import '../notifier/create_purchase_notifier.dart';

class CreatePurchaseScreen extends ConsumerWidget {
  const CreatePurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(createPurchaseNotifierProvider);
    final notifier = ref.read(createPurchaseNotifierProvider.notifier);

    // Watch products list from dropdowns
    final products = ref.watch(
      dropdownsNotifierProvider.select((s) => s.data.products),
    );
    final dropdownsLoader = ref.watch(
      dropdownsNotifierProvider.select((s) => s.loaderState),
    );

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: const CommonAppBar(
        title: 'New Purchase',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Date Selector
                    Text(
                      'Purchase Date',
                      style: FontPalette.base600(13, color: colors.secondaryText),
                    ),
                    10.verticalSpace,
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: state.purchaseDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          notifier.updatePurchaseDate(picked);
                        }
                      },
                      child: CommonContainer(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                        borderRadius: 16.r,
                        border: Border.all(color: colors.inputBorder, width: 1.w),
                        color: colors.surface,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: colors.primary,
                              size: 20.r,
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: Text(
                                formatDate(state.purchaseDate, pattern: 'dd MMM yyyy'),
                                style: FontPalette.base600(14, color: colors.primaryText),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    24.verticalSpace,

                    // Add Item Block
                    Text(
                      'Add Item',
                      style: FontPalette.base700(15, color: colors.primaryText),
                    ),
                    12.verticalSpace,
                    CommonContainer(
                      padding: EdgeInsets.all(16.r),
                      borderRadius: 20.r,
                      border: Border.all(color: colors.inputBorder, width: 1.w),
                      color: colors.surface,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Product Selector
                          GestureDetector(
                            onTap: () {
                              showSingleSelectBottomSheet<DropdownProductModel>(
                                context: context,
                                ref: ref,
                                title: 'Select Product',
                                options: products,
                                currentValue: state.selectedProduct,
                                onSelected: (product) => notifier.selectProduct(product),
                                displayText: (product) => product.name,
                                loaderState: dropdownsLoader,
                              );
                            },
                            child: Container(
                              height: 48.h,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              decoration: BoxDecoration(
                                color: colors.inputBackground,
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(
                                  color: state.selectedProduct != null
                                      ? colors.primary.withValues(alpha: 0.5)
                                      : colors.inputBorder,
                                  width: 1.w,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.selectedProduct != null
                                          ? state.selectedProduct!.name
                                          : 'Select Product',
                                      style: state.selectedProduct != null
                                          ? FontPalette.base600(
                                              13,
                                              color: colors.primaryText,
                                            )
                                          : FontPalette.base400(
                                              13,
                                              color: colors.secondaryText,
                                            ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          16.verticalSpace,

                          // Qty & Price Row
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextFormField(
                                  controller: notifier.quantityController,
                                  hintText: 'Qty',
                                  inputType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: CommonTextFormField(
                                  controller: notifier.priceController,
                                  hintText: 'Price per unit',
                                  inputType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          16.verticalSpace,

                          // Add Item Button
                          PrimaryButton(
                            text: 'Add Item to Purchase',
                            radius: 12,
                            onPressed: () {
                              notifier.addItem();
                            },
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,

                    // Items list title
                    Text(
                      'Purchase Items (${state.items.length})',
                      style: FontPalette.base700(15, color: colors.primaryText),
                    ),
                    12.verticalSpace,

                    if (state.items.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Text(
                          'No items added to this purchase yet.',
                          textAlign: TextAlign.center,
                          style: FontPalette.base400(13, color: colors.secondaryText),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: colors.inputBorder, width: 1.w),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: FontPalette.base700(14, color: colors.primaryText),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        'Qty: ${item.quantity}  ×  ${item.price.toCurrency()}',
                                        style: FontPalette.base400(12, color: colors.secondaryText),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  item.totalPrice.toCurrency(),
                                  style: FontPalette.base700(14, color: colors.primary),
                                ),
                                8.horizontalSpace,
                                IconButton(
                                  icon: Icon(Icons.delete_outline_rounded, color: Colors.red.shade600, size: 20.r),
                                  onPressed: () {
                                    notifier.removeItem(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),

            // Grand Total and Save Button Footer
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: colors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grand Total',
                          style: FontPalette.base700(15, color: colors.primaryText),
                        ),
                        Text(
                          state.items
                              .fold<double>(0, (sum, item) => sum + item.totalPrice)
                              .toCurrency(),
                          style: FontPalette.base700(18, color: colors.primary),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    PrimaryButton(
                      text: 'Create Purchase',
                      isLoading: state.isSaving,
                      onPressed: state.isSaving
                          ? () {}
                          : () => notifier.savePurchase(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
