// lib/src/new_bill/view/web/new_bill_web_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/src/main/model/dropdown_model.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/utils/common_widgets/bottomsheet_content.dart';
import 'package:thuga/utils/common_widgets/common_search_bar.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/common_widgets/common_loader.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/utils/helpers/product_stock_helper.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';

import '../../notifier/new_bill_notifier.dart';
import 'widget/new_bill_web_cart_panel.dart';
import 'widget/new_bill_web_product_card.dart';

class NewBillWebScreen extends ConsumerWidget {
  const NewBillWebScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final loaderState = ref.watch(
      newBillProvider.select((s) => s.loaderState),
    );
    final billNumber = ref.watch(newBillProvider.select((s) => s.billNumber));
    final notifier = ref.read(newBillProvider.notifier);
    final isPrinterConnected = ref.watch(
      printerProvider.select((value) => value.isConnected),
    );

    return Scaffold(
      backgroundColor: colors.background,
      body: CommonSwitchState(
        loaderState: loaderState,
        reload: () => notifier.fetchProducts(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _CatalogPane(billNumber: billNumber)),
            NewBillWebCartPanel(
              onSubmit: () => notifier.saveAndMaybePrint(
                context,
                printWhenPossible: isPrinterConnected,
              ),
              onApplyDiscount: () => _showDiscountDialog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _showDiscountDialog(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(newBillProvider.notifier);
    final subtotal = notifier.billTotals.subtotal;
    final currentDiscount = ref.read(
      newBillProvider.select((s) => s.discountAmount),
    );
    final controller = TextEditingController(
      text: currentDiscount > 0 ? currentDiscount.toStringAsFixed(2) : '',
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(WebSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Strings.applyDiscount,
                    textAlign: TextAlign.center,
                    style: FontPalette.base700(18, color: colors.primaryText),
                  ),
                  const SizedBox(height: WebSpacing.sm),
                  Text(
                    'Enter discount amount to apply on subtotal of ${subtotal.toCurrency()}',
                    textAlign: TextAlign.center,
                    style: FontPalette.base400(13, color: colors.secondaryText),
                  ),
                  const SizedBox(height: WebSpacing.md),
                  CommonTextFormField(
                    controller: controller,
                    hintText: Strings.enterDiscountAmount,
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    autoFocus: true,
                  ),
                  const SizedBox(height: WebSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text(
                            Strings.cancel,
                            style: FontPalette.base600(
                              14,
                              color: colors.secondaryText,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: WebSpacing.sm),
                      Expanded(
                        child: PrimaryButton(
                          text: Strings.apply,
                          radius: 12,
                          onPressed: () {
                            final value =
                                double.tryParse(controller.text) ?? 0.0;
                            if (value < 0.0 || value > subtotal) {
                              showCustomErrorToast(
                                message: 'Please enter a valid discount amount',
                              );
                              return;
                            }
                            notifier.setDiscountAmount(value);
                            Navigator.pop(dialogContext);
                            showCustomToast(
                              message: 'Discount applied successfully',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(controller.dispose);
  }
}

class _CatalogPane extends ConsumerWidget {
  const _CatalogPane({required this.billNumber});

  final int billNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(newBillProvider.notifier);
    final selectedCategory = ref.watch(
      newBillProvider.select((s) => s.selectedCategory),
    );
    final products = ref.watch(newBillProvider.select((s) => s.products));
    final isLoadingMore = ref.watch(
      newBillProvider.select((s) => s.isLoadingMore),
    );
    final cartItems = ref.watch(newBillProvider.select((s) => s.cart));
    final categories = ref.watch(newBillProvider.select((s) => s.categories));
    final selectedCustomer = ref.watch(
      newBillProvider.select((s) => s.selectedCustomer),
    );
    final customers = ref.watch(
      dropdownsProvider.select((s) => s.data.customers),
    );
    final dropdownsLoaderState = ref.watch(
      dropdownsProvider.select((s) => s.loaderState),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _WebBillHeader(billNumber: billNumber),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            WebSpacing.lg,
            0,
            WebSpacing.lg,
            WebSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CommonSearchBar(
                  controller: notifier.searchController,
                  focusNode: notifier.searchFocusNode,
                  hintText: Strings.searchProductsHint,
                  dense: true,
                ),
              ),
              const SizedBox(width: WebSpacing.md),
              Expanded(
                flex: 2,
                child: _CustomerSelector(
                  selectedCustomer: selectedCustomer,
                  customers: customers,
                  loaderState: dropdownsLoaderState,
                  onSelected: notifier.selectCustomer,
                  onClear: () => notifier.selectCustomer(null),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: WebSpacing.lg),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: WebSpacing.xs),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category.name;
              return FilterChip(
                label: Text(category.name),
                selected: isSelected,
                onSelected: (_) =>
                    notifier.setCategory(category.name, category.id),
                labelStyle: FontPalette.base600(
                  12,
                  color: isSelected ? ColorPalette.white : colors.secondaryText,
                ),
                selectedColor: colors.primary,
                backgroundColor: colors.surface,
                side: BorderSide(
                  color: isSelected ? colors.primary : colors.inputBorder,
                ),
                showCheckmark: false,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              );
            },
          ),
        ),
        const SizedBox(height: WebSpacing.sm),
        Expanded(
          child: products.isEmpty
              ? Center(
                  child: Text(
                    Strings.noProductsFound,
                    style: FontPalette.base400(
                      14,
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
                    padding: const EdgeInsets.fromLTRB(
                      WebSpacing.lg,
                      0,
                      WebSpacing.lg,
                      WebSpacing.lg,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _gridColumns(context),
                      mainAxisSpacing: WebSpacing.sm,
                      crossAxisSpacing: WebSpacing.sm,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: products.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == products.length) {
                        return const Center(
                          child: CommonLoader(size: 24, strokeWidth: 2),
                        );
                      }
                      final product = products[index];
                      final cartIndex = cartItems.indexWhere(
                        (item) => item.productId == product.id,
                      );
                      final qty =
                          cartIndex >= 0 ? cartItems[cartIndex].quantity : 0;
                      return NewBillWebProductCard(
                        product: product,
                        quantity: qty,
                        isOutOfStock: isOutOfStock(product.quantity),
                        onAdd: () => notifier.addToCart(product),
                        onReduce: () =>
                            notifier.setProductQuantity(product, qty - 1),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  int _gridColumns(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    if (breakpoints.largerThan(TABLET)) return 5;
    if (breakpoints.largerThan(MOBILE)) return 4;
    return 3;
  }
}

class _WebBillHeader extends StatelessWidget {
  const _WebBillHeader({required this.billNumber});

  final int billNumber;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        WebSpacing.md,
        WebSpacing.lg,
        WebSpacing.lg,
        WebSpacing.md,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.arrow_back_rounded, color: colors.primaryText),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.newBillTitle,
                style: FontPalette.base700(22, color: colors.primaryText),
              ),
              Text(
                '#$billNumber',
                style: FontPalette.base500(13, color: colors.secondaryText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomerSelector extends ConsumerWidget {
  const _CustomerSelector({
    required this.selectedCustomer,
    required this.customers,
    required this.loaderState,
    required this.onSelected,
    required this.onClear,
  });

  final DropdownCustomerModel? selectedCustomer;
  final List<DropdownCustomerModel> customers;
  final LoaderState loaderState;
  final ValueChanged<DropdownCustomerModel?> onSelected;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    return InkWell(
      onTap: () {
        showSingleSelectBottomSheet<DropdownCustomerModel>(
          context: context,
          ref: ref,
          title: Strings.selectCustomer,
          options: customers,
          currentValue: selectedCustomer,
          onSelected: onSelected,
          displayText: (customer) => customer.name,
          loaderState: loaderState,
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: WebSpacing.md),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selectedCustomer != null
                ? colors.primary.withValues(alpha: 0.5)
                : colors.inputBorder,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selectedCustomer != null
                  ? Icons.person_rounded
                  : Icons.person_outline_rounded,
              size: 18,
              color: selectedCustomer != null
                  ? colors.primary
                  : colors.secondaryText,
            ),
            const SizedBox(width: WebSpacing.xs),
            Expanded(
              child: Text(
                selectedCustomer?.name ?? Strings.selectCustomer,
                style: selectedCustomer != null
                    ? FontPalette.base600(13, color: colors.primaryText)
                    : FontPalette.base400(13, color: colors.secondaryText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (selectedCustomer != null)
              IconButton(
                tooltip: Strings.clear,
                onPressed: onClear,
                icon: Icon(Icons.close_rounded, size: 16, color: colors.secondaryText),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              )
            else
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
                color: colors.secondaryText,
              ),
          ],
        ),
      ),
    );
  }
}
