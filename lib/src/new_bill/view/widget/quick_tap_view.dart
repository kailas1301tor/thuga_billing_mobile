// lib/src/new_bill/view/widget/quick_tap_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_bottom_sheet.dart';
import 'package:vyapapp/utils/common_widgets/common_search_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';
import 'package:vyapapp/utils/common_widgets/bottomsheet_content.dart';
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
    final notifier = ref.read(newBillNotifierProvider.notifier);

    // Watched state fields for granular rebuilds
    final selectedCategory = ref.watch(
      newBillNotifierProvider.select((s) => s.selectedCategory),
    );
    final isCartExpanded = ref.watch(
      newBillNotifierProvider.select((s) => s.isCartExpanded),
    );
    final products = ref.watch(
      newBillNotifierProvider.select((s) => s.products),
    );
    final isLoadingMore = ref.watch(
      newBillNotifierProvider.select((s) => s.isLoadingMore),
    );
    final cartItems = ref.watch(newBillNotifierProvider.select((s) => s.cart));
    final discountAmount = ref.watch(
      newBillNotifierProvider.select((s) => s.discountAmount),
    );
    final selectedCustomer = ref.watch(
      newBillNotifierProvider.select((s) => s.selectedCustomer),
    );
    final dropdownsState = ref.watch(dropdownsNotifierProvider);
    final customerList = dropdownsState.data.customers;
    final customersLoader = dropdownsState.loaderState;

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

          // 3. Main Product Grid Area
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
                              notification.metrics.maxScrollExtent - 200) {
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
                      itemCount: products.length + (isLoadingMore ? 1 : 0),
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
                            : 0;
                        return QuickTapProductCard(
                          product: product,
                          quantity: qty,
                          onTap: () => notifier.addToCart(product),
                          onReduce: () => notifier.setProductQuantity(product, qty - 1),
                          onLongPress: () {
                            CommonBottomSheet.show(
                              context: context,
                              title: 'Select Quantity',
                              isScrollControlled: true,
                              child: QuantityPickerSheet(
                                product: product,
                                initialQuantity: qty,
                                onConfirm: (newQty) {
                                  notifier.setProductQuantity(
                                    product,
                                    newQty,
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

          // 4. Smooth Animated Slide-up Expanded Cart List
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: cartItems.isNotEmpty && isCartExpanded
                ? Container(
                    constraints: BoxConstraints(maxHeight: 260.h),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      border: Border(
                        top: BorderSide(color: colors.inputBorder, width: 1.w),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bill Cart Items (${cartItems.fold<int>(0, (sum, i) => sum + i.quantity)})',
                                style: FontPalette.base700(
                                  13,
                                  color: colors.primaryText,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => notifier.clearCart(),
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
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: QuickTapCartList(
                              cartItems: cartItems,
                              onIncrementQty: (item) =>
                                  notifier.incrementQuantity(item),
                              onDecrementQty: (item) =>
                                  notifier.decrementQuantity(item),
                              onRemoveCartItem: (item) =>
                                  notifier.removeCartItem(item),
                              onTapDiscount: (item) =>
                                  _showItemDiscountSheet(context, ref, item),
                            ),
                          ),
                        ),
                        // Pricing Summary block
                        Builder(
                          builder: (context) {
                            final subtotal = cartItems.fold<double>(
                              0.0,
                              (sum, item) => sum + item.totalPrice,
                            );
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
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
                                        '₹${subtotal.toStringAsFixed(2)}',
                                        style: FontPalette.base600(
                                          12,
                                          color: colors.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  6.verticalSpace,
                                  GestureDetector(
                                    onTap: () => _showDiscountDialog(
                                      context,
                                      ref,
                                      subtotal,
                                    ),
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
                                              ? '- ₹${discountAmount.toStringAsFixed(2)}'
                                              : '₹0.00',
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
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
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
    final notifier = ref.read(newBillNotifierProvider.notifier);
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
    final notifier = ref.read(newBillNotifierProvider.notifier);
    final currentDiscount = ref.read(newBillNotifierProvider.select((s) => s.discountAmount));
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
                  'Enter discount amount to apply on subtotal of ₹${subtotal.toStringAsFixed(2)}',
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
}
