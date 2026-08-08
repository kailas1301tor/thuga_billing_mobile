// lib/src/new_bill/view/widget/quick_tap_view.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_bottom_sheet.dart';
import 'package:thuga/utils/common_widgets/common_search_bar.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/utils/helpers/product_stock_helper.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';
import 'package:thuga/utils/helpers/unit_conversion_helper.dart';
import 'package:thuga/utils/common_widgets/bottomsheet_content.dart';
import 'package:thuga/utils/helpers/bill_tax_helper.dart';
import '../../../main/model/dropdown_model.dart';
import '../../../main/notifier/dropdowns_notifier.dart';
import '../../model/new_bill_model.dart';
import '../../notifier/new_bill_notifier.dart';
import 'item_discount_sheet.dart';
import 'quantity_picker_sheet.dart';
import 'quick_tap_cart_list.dart';
import 'quick_tap_cart_strip.dart';
import 'quick_tap_category_chips.dart';
import 'quick_tap_product_card.dart';

class QuickTapView extends ConsumerWidget {
  const QuickTapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(newBillProvider.notifier);

    // Watched state fields for granular rebuilds
    final selectedCategory = ref.watch(
      newBillProvider.select((s) => s.selectedCategory),
    );
    final isCartExpanded = ref.watch(
      newBillProvider.select((s) => s.isCartExpanded),
    );
    final products = ref.watch(
      newBillProvider.select((s) => s.products),
    );
    final isLoadingMore = ref.watch(
      newBillProvider.select((s) => s.isLoadingMore),
    );
    final cartItems = ref.watch(newBillProvider.select((s) => s.cart));
    final discountAmount = ref.watch(
      newBillProvider.select((s) => s.discountAmount),
    );
    final selectedCustomer = ref.watch(
      newBillProvider.select((s) => s.selectedCustomer),
    );
    final dropdownsState = ref.watch(dropdownsProvider);
    final customerList = dropdownsState.data.customers;
    final customersLoader = dropdownsState.loaderState;
    final billTotals = notifier.billTotals;
    final showExpandedCart = cartItems.isNotEmpty && isCartExpanded;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Full-Width Category Chips Row
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 4.h),
            child: QuickTapCategoryChips(
              selectedCategory: selectedCategory,
              onCategorySelected: (name, id) => notifier.setCategory(name, id),
            ),
          ),

          // 2. Search Field & Custom Item Action Row (Unified, Always Visible)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            child: Row(
              children: [
                // Left 50%: Product Search & compact "+ Custom" icon button
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonSearchBar(
                          controller: notifier.searchController,
                          focusNode: notifier.searchFocusNode,
                          hintText: 'Search products...',
                        ),
                      ),
                      // 8.horizontalSpace,
                      // GestureDetector(
                      //   onTap: () => _showCustomItemSheet(context, notifier),
                      //   child: Container(
                      //     height: 40.h,
                      //     width: 40.w,
                      //     decoration: BoxDecoration(
                      //       color: colors.primary.withValues(alpha: 0.08),
                      //       borderRadius: BorderRadius.circular(20.r),
                      //       border: Border.all(
                      //         color: colors.primary.withValues(alpha: 0.3),
                      //         width: 1.w,
                      //       ),
                      //     ),
                      //     child: Center(
                      //       child: Icon(
                      //         Icons.add_circle_outline_rounded,
                      //         size: 18.r,
                      //         color: colors.primary,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                8.horizontalSpace,
                // Right 50%: Customer selector
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showSingleSelectBottomSheet<DropdownCustomerModel>(
                        context: context,
                        ref: ref,
                        title: 'Select Customer',
                        options: customerList,
                        currentValue: selectedCustomer,
                        onSelected: (customer) =>
                            notifier.selectCustomer(customer),
                        displayText: (customer) => customer.name,
                        loaderState: customersLoader,
                      );
                    },
                    child: Container(
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: selectedCustomer != null
                              ? colors.primary.withValues(alpha: 0.5)
                              : colors.inputBorder,
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selectedCustomer != null
                                ? Icons.person_rounded
                                : Icons.person_outline_rounded,
                            size: 18.r,
                            color: selectedCustomer != null
                                ? colors.primary
                                : colors.secondaryText,
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Text(
                              selectedCustomer != null
                                  ? selectedCustomer.name
                                  : 'Select Customer',
                              style: selectedCustomer != null
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
                          if (selectedCustomer != null)
                            GestureDetector(
                              onTap: () {
                                notifier.selectCustomer(null);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(4.r),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 16.r,
                                  color: colors.secondaryText,
                                ),
                              ),
                            )
                          else
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 20.r,
                              color: colors.secondaryText,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Product grid + expanded cart share remaining vertical space
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final expandedCartHeight = showExpandedCart
                    ? _expandedCartPanelHeight(
                        availableHeight: constraints.maxHeight,
                        billTotals: billTotals,
                      )
                    : 0.0;

                return Column(
                  children: [
                    Expanded(
                      child: products.isEmpty
                          ? Center(
                              child: Text(
                                'No products found',
                                style: FontPalette.base400(
                                  13,
                                  color: colors.secondaryText,
                                ),
                              ),
                            )
                          : NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is ScrollEndNotification &&
                                    notification.metrics.pixels >=
                                        notification.metrics.maxScrollExtent -
                                            200) {
                                  notifier.loadMoreProducts();
                                }
                                return false;
                              },
                              child: GridView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 6.h,
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8.h,
                                      crossAxisSpacing: 10.w,
                                      childAspectRatio: 0.85,
                                    ),
                                itemCount:
                                    products.length + (isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == products.length) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: SizedBox(
                                          width: 24.r,
                                          height: 24.r,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.w,
                                            color: colors.primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final product = products[index];
                                  final cartItemIndex = cartItems.indexWhere(
                                    (item) => item.productId == product.id,
                                  );
                                  final qty = cartItemIndex >= 0
                                      ? cartItems[cartItemIndex].quantity
                                      : 0.0;
                                  final billingUnit = cartItemIndex >= 0
                                      ? cartItems[cartItemIndex].billingUnit
                                      : resolveProductUnit(product.unit);
                                  return QuickTapProductCard(
                                    product: product,
                                    quantity: qty,
                                    isOutOfStock: isOutOfStock(product.quantity),
                                    onTap: () => notifier.addToCart(product),
                                    onReduce: () => notifier.setProductQuantity(
                                      product,
                                      qty -
                                          incrementStepForUnit(billingUnit),
                                      unit: billingUnit,
                                    ),
                                    onLongPress: () {
                                      notifier.initQuantityPicker(
                                        product,
                                        currentBillingUnit: billingUnit,
                                      );
                                      CommonBottomSheet.show(
                                        context: context,
                                        title: Strings.selectQuantity,
                                        isScrollControlled: true,
                                        child: QuantityPickerSheet(
                                          product: product,
                                          initialQuantity: qty,
                                          initialUnit: billingUnit,
                                          onConfirm: (newQty, unit) {
                                            notifier.setProductQuantity(
                                              product,
                                              newQty,
                                              unit: unit,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                    if (showExpandedCart)
                      SizedBox(
                        height: expandedCartHeight,
                        child: _QuickTapExpandedCartPanel(
                          cartItems: cartItems,
                          billTotals: billTotals,
                          discountAmount: discountAmount,
                          onClearCart: notifier.clearCart,
                          onIncrementQty: notifier.incrementQuantity,
                          onDecrementQty: notifier.decrementQuantity,
                          onRemoveCartItem: notifier.removeCartItem,
                          onTapDiscount: (item) => _showItemDiscountSheet(
                            context,
                            ref,
                            item,
                          ),
                          onTapDiscountRow: () => _showDiscountDialog(
                            context,
                            ref,
                            billTotals.subtotal,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),

          // 5. Persistent Cart Summary Strip (always visible if cart is not empty)
          const QuickTapCartStrip(),
        ],
      ),
    );
  }

  // void _showCustomItemSheet(BuildContext context, NewBillNotifier notifier) {
  //   notifier.customNameController.clear();
  //   notifier.customQtyController.text = '1';
  //   notifier.customPriceController.clear();
  //   if (notifier.searchController.text.isNotEmpty) {
  //     notifier.customNameController.text = notifier.searchController.text;
  //   }
  //   CommonBottomSheet.show(
  //     context: context,
  //     title: 'Add Custom Item',
  //     isScrollControlled: true,
  //     child: Padding(
  //       padding: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).viewInsets.bottom,
  //       ),
  //       child: CustomItemView(
  //         nameController: notifier.customNameController,
  //         qtyController: notifier.customQtyController,
  //         priceController: notifier.customPriceController,
  //         onAddPressed: () {
  //           notifier.addCustomItem();
  //           Navigator.pop(context);
  //         },
  //       ),
  //     ),
  //   );
  // }

  void _showItemDiscountSheet(
    BuildContext context,
    WidgetRef ref,
    CartItemModel item,
  ) {
    final notifier = ref.read(newBillProvider.notifier);
    CommonBottomSheet.show(
      context: context,
      title: 'Item Discount',
      isScrollControlled: true,
      child: ItemDiscountSheet(
        item: item,
        onApply: ({
          required String discountType,
          required double discountValue,
          int? bogoBuyQty,
          int? bogoGetQty,
        }) {
          notifier.updateCartItemDiscount(
            item: item,
            discountType: discountType,
            discountValue: discountValue,
            bogoBuyQty: bogoBuyQty,
            bogoGetQty: bogoGetQty,
          );
        },
        onRemove: () => notifier.removeCartItemDiscount(item),
      ),
    );
  }

  void _showDiscountDialog(BuildContext context, WidgetRef ref, double subtotal) {
    final colors = context.appColors;
    final notifier = ref.read(newBillProvider.notifier);
    final currentDiscount = ref.read(newBillProvider.select((s) => s.discountAmount));
    final controller = TextEditingController(text: currentDiscount > 0 ? currentDiscount.toStringAsFixed(2) : '');

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Apply Discount',
                  textAlign: TextAlign.center,
                  style: FontPalette.base700(18, color: colors.primaryText),
                ),
                16.verticalSpace,
                Text(
                  'Enter discount amount to apply on subtotal of ${subtotal.toCurrency()}',
                  textAlign: TextAlign.center,
                  style: FontPalette.base400(13, color: colors.secondaryText),
                ),
                16.verticalSpace,
                CommonTextFormField(
                  controller: controller,
                  hintText: 'Enter discount amount (₹)',
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  autoFocus: true,
                ),
                24.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: FontPalette.base600(14, color: colors.secondaryText),
                        ),
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: PrimaryButton(
                        text: 'Apply',
                        radius: 12,
                        onPressed: () {
                          final value = double.tryParse(controller.text) ?? 0.0;
                          if (value < 0.0 || value > subtotal) {
                            showCustomErrorToast(
                              message: 'Please enter a valid discount amount',
                            );
                            return;
                          }
                          notifier.setDiscountAmount(value);
                          Navigator.pop(context);
                          showCustomToast(message: 'Discount applied successfully');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) => controller.dispose());
  }

  static const int _minVisibleCartItems = 4;

  double _expandedCartPanelHeight({
    required double availableHeight,
    required BillTotals billTotals,
  }) {
    const itemRowHeight = 52.0;
    const headerHeight = 28.0;
    final hasSgst = billTotals.sgstTotal > 0;
    final hasCgst = billTotals.cgstTotal > 0;
    final taxRows = hasSgst && hasCgst ? 1 : ((hasSgst ? 1 : 0) + (hasCgst ? 1 : 0));
    const summaryBaseRows = 3; // subtotal, discount, total
    final summaryRows = summaryBaseRows + taxRows;
    const summaryRowHeight = 18.0;
    const summaryGap = 4.0;

    final listHeight = _minVisibleCartItems * itemRowHeight.h +
        (_minVisibleCartItems - 1) * 1.h;
    final summaryHeight = 16.h +
        summaryRows * summaryRowHeight.h +
        (summaryRows - 1) * summaryGap.h;
    final minHeight = headerHeight.h + listHeight + summaryHeight;

    return math.min(
      availableHeight * 0.78,
      math.max(minHeight, availableHeight * 0.68),
    );
  }
}

class _QuickTapExpandedCartPanel extends StatelessWidget {
  const _QuickTapExpandedCartPanel({
    required this.cartItems,
    required this.billTotals,
    required this.discountAmount,
    required this.onClearCart,
    required this.onIncrementQty,
    required this.onDecrementQty,
    required this.onRemoveCartItem,
    required this.onTapDiscount,
    required this.onTapDiscountRow,
  });

  final List<CartItemModel> cartItems;
  final BillTotals billTotals;
  final double discountAmount;
  final VoidCallback onClearCart;
  final ValueChanged<CartItemModel> onIncrementQty;
  final ValueChanged<CartItemModel> onDecrementQty;
  final ValueChanged<CartItemModel> onRemoveCartItem;
  final ValueChanged<CartItemModel> onTapDiscount;
  final VoidCallback onTapDiscountRow;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final totals = billTotals;
    final subtotal = totals.subtotal;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: colors.inputBorder, width: 1.w),
        ),
      ),
      child: ClipRect(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bill Cart Items (${cartItems.length})',
                    style: FontPalette.base700(13, color: colors.primaryText),
                  ),
                  GestureDetector(
                    onTap: onClearCart,
                    child: Text(
                      'Clear All',
                      style: FontPalette.base600(
                        12,
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 4.h),
              child: QuickTapCartList(
                cartItems: cartItems,
                onIncrementQty: onIncrementQty,
                onDecrementQty: onDecrementQty,
                onRemoveCartItem: onRemoveCartItem,
                onTapDiscount: onTapDiscount,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colors.inputBackground.withValues(alpha: 0.5),
              border: Border(
                top: BorderSide(color: colors.inputBorder, width: 1.w),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: FontPalette.base500(
                        12,
                        color: colors.secondaryText,
                      ),
                    ),
                    Text(
                      subtotal.toCurrency(),
                      style: FontPalette.base600(
                        12,
                        color: colors.primaryText,
                      ),
                    ),
                  ],
                ),
                4.verticalSpace,
                GestureDetector(
                  onTap: onTapDiscountRow,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Discount',
                            style: FontPalette.base500(
                              12,
                              color: colors.secondaryText,
                            ),
                          ),
                          4.horizontalSpace,
                          Icon(
                            Icons.edit_rounded,
                            size: 12.r,
                            color: colors.primary,
                          ),
                        ],
                      ),
                      Text(
                        discountAmount > 0
                            ? '- ${discountAmount.toCurrency()}'
                            : 0.toCurrency(),
                        style: FontPalette.base700(
                          12,
                          color: discountAmount > 0
                              ? Colors.green.shade600
                              : colors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                if (totals.sgstTotal > 0 && totals.cgstTotal > 0) ...[
                  4.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.gstTotal,
                        style: FontPalette.base500(
                          12,
                          color: colors.secondaryText,
                        ),
                      ),
                      Text(
                        (totals.sgstTotal + totals.cgstTotal).toCurrency(),
                        style: FontPalette.base600(
                          12,
                          color: colors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  if (totals.sgstTotal > 0) ...[
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.sgstTotal,
                          style: FontPalette.base500(
                            12,
                            color: colors.secondaryText,
                          ),
                        ),
                        Text(
                          totals.sgstTotal.toCurrency(),
                          style: FontPalette.base600(
                            12,
                            color: colors.primaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (totals.cgstTotal > 0) ...[
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.cgstTotal,
                          style: FontPalette.base500(
                            12,
                            color: colors.secondaryText,
                          ),
                        ),
                        Text(
                          totals.cgstTotal.toCurrency(),
                          style: FontPalette.base600(
                            12,
                            color: colors.primaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
                4.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: FontPalette.base700(
                        13,
                        color: colors.primaryText,
                      ),
                    ),
                    Text(
                      totals.grandTotal.toCurrency(),
                      style: FontPalette.base700(14, color: colors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}
