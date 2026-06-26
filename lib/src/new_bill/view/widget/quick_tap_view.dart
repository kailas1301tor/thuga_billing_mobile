// lib/src/new_bill/view/widget/quick_tap_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_bottom_sheet.dart';
import 'package:vyapapp/utils/common_widgets/common_search_bar.dart';

import 'package:vyapapp/utils/common_widgets/bottomsheet_content.dart';
import '../../../main/model/dropdown_model.dart';
import '../../../main/notifier/dropdowns_notifier.dart';
import '../../model/new_bill_model.dart';
import '../../notifier/new_bill_notifier.dart';
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
    final searchQuery = ref.watch(
      newBillNotifierProvider.select((s) => s.searchQuery),
    );
    final isCartExpanded = ref.watch(
      newBillNotifierProvider.select((s) => s.isCartExpanded),
    );
    final products = ref.watch(
      newBillNotifierProvider.select((s) => s.products),
    );
    final cartItems = ref.watch(newBillNotifierProvider.select((s) => s.cart));
    final selectedCustomer = ref.watch(
      newBillNotifierProvider.select((s) => s.selectedCustomer),
    );
    final dropdownsState = ref.watch(dropdownsNotifierProvider);
    final customerList = dropdownsState.data.customers;
    final customersLoader = dropdownsState.loaderState;

    // Filter Products by Category Name and Search Query
    final filteredProducts = products.where((p) {
      final matchesCategory =
          p.categoryName.toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch =
          searchQuery.isEmpty ||
          p.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Expanded(
      child: Column(
        children: [
          // 1. Full-Width Category Chips Row
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 4.h),
            child: QuickTapCategoryChips(
              selectedCategory: selectedCategory,
              onCategorySelected: (cat) => notifier.setCategory(cat),
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
            child: filteredProducts.isEmpty
                ? Center(
                    child: Text(
                      'No products found',
                      style: FontPalette.base400(
                        13,
                        color: colors.secondaryText,
                      ),
                    ),
                  )
                : Builder(
                    builder: (context) {
                      final int chunkSize = 12;
                      final pages = <List<ProductModel>>[];
                      for (
                        var i = 0;
                        i < filteredProducts.length;
                        i += chunkSize
                      ) {
                        pages.add(
                          filteredProducts.sublist(
                            i,
                            i + chunkSize > filteredProducts.length
                                ? filteredProducts.length
                                : i + chunkSize,
                          ),
                        );
                      }

                      Widget buildGrid(List<ProductModel> chunk) {
                        return GridView.builder(
                          physics: pages.length > 1
                              ? const NeverScrollableScrollPhysics()
                              : const BouncingScrollPhysics(),
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
                          itemCount: chunk.length,
                          itemBuilder: (context, index) {
                            final product = chunk[index];
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
                        );
                      }

                      if (pages.length <= 1) {
                        return buildGrid(filteredProducts);
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: notifier.productPageController,
                              itemCount: pages.length,
                              itemBuilder: (context, pageIndex) =>
                                  buildGrid(pages[pageIndex]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                            child: AnimatedBuilder(
                              animation: notifier.productPageController,
                              builder: (context, child) {
                                final int currentPage =
                                    notifier.productPageController.hasClients
                                    ? notifier.productPageController.page
                                              ?.round() ??
                                          0
                                    : 0;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(pages.length, (
                                    index,
                                  ) {
                                    final isActive = index == currentPage;
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                      ),
                                      width: isActive ? 16.w : 6.r,
                                      height: 6.r,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? colors.primary
                                            : colors.inputBorder,
                                        borderRadius: BorderRadius.circular(
                                          3.r,
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),

          // 4. Smooth Animated Slide-up Expanded Cart List
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: cartItems.isNotEmpty && isCartExpanded
                ? Container(
                    constraints: BoxConstraints(maxHeight: 200.h),
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
                            ),
                          ),
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
}
