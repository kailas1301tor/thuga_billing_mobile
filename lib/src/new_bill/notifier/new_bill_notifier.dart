// lib/src/new_bill/notifier/new_bill_notifier.dart
import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/src/printer/service/printer_service.dart';
import 'package:thuga/src/settings/notifier/settings_notifier.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/utils/helpers/bill_tax_helper.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/utils/helpers/product_stock_helper.dart';
import 'package:thuga/utils/helpers/receipt_print_helper.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/utils/common_widgets/common_bottom_sheet.dart';
import 'package:thuga/src/new_bill/view/widget/bill_preview_sheet.dart';
import '../../main/model/dropdown_model.dart';
import '../model/new_bill_model.dart';
import '../state/new_bill_state.dart';

part 'new_bill_notifier.g.dart';

@Riverpod(keepAlive: false)
class NewBillNotifier extends _$NewBillNotifier {
  late final TextEditingController searchController;
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;
  late final TextEditingController customNameController;
  late final TextEditingController customQtyController;
  late final TextEditingController customPriceController;
  late final TextEditingController quantityController;
  late final TextEditingController receivedAmountController;
  late final FocusNode searchFocusNode;
  Timer? _searchDebounce;

  @override
  NewBillState build() {
    searchController = TextEditingController();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    customNameController = TextEditingController();
    customQtyController = TextEditingController();
    customPriceController = TextEditingController();
    quantityController = TextEditingController();
    receivedAmountController = TextEditingController();
    searchFocusNode = FocusNode();

    searchController.addListener(_onSearchChanged);
    receivedAmountController.addListener(_onReceivedAmountChanged);

    ref.onDispose(() {
      _searchDebounce?.cancel();
      searchController.dispose();
      amountController.dispose();
      descriptionController.dispose();
      customNameController.dispose();
      customQtyController.dispose();
      customPriceController.dispose();
      quantityController.dispose();
      receivedAmountController.dispose();
      searchFocusNode.dispose();
    });

    Future.microtask(() => fetchProducts());
    return const NewBillState();
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      final query = searchController.text.trim();
      state = state.copyWith(searchQuery: query, currentPage: 1);
      fetchProducts(
        search: query.isNotEmpty ? query : null,
        categoryId: state.selectedCategoryId,
      );
    });
  }

  void _onReceivedAmountChanged() {
    final text = receivedAmountController.text.trim();
    final val = double.tryParse(text) ?? 0.0;
    state = state.copyWith(receivedAmount: val);
  }

  Future<void> fetchProducts({
    String? search,
    int? categoryId,
    int page = 1,
    bool showLoader = true,
  }) async {
    if (page == 1 && showLoader) {
      state = state.copyWith(loaderState: LoaderState.loading);
    } else if (page > 1) {
      state = state.copyWith(isLoadingMore: true);
    }

    return await ref
        .read(newBillRepositoryProvider)
        .getCategoriesWithProducts(
          search: search,
          categoryId: categoryId,
          page: page,
          pageSize: 9,
        )
        .fold(
          (left) {
            if (showLoader || page > 1) {
              state = state.copyWith(
                loaderState: handleResponseError(left.key),
                isLoadingMore: false,
                errorMessage: left.message,
              );
            } else {
              debugPrint(
                "🔴 Silent product refresh failed: ${left.message}",
              );
            }
          },
          (right) {
            final categories = right.results.data;

            // Find the selected category's products
            final selectedCatId = categoryId ?? state.selectedCategoryId;
            final selectedCat = categories.firstWhere(
              (c) => c.id == selectedCatId,
              orElse: () => categories.first,
            );
            final newProducts = selectedCat.products;

            // Page 1 → replace; page > 1 → append
            final allProducts = page == 1
                ? newProducts
                : [...state.products, ...newProducts];

            // On first load, default selection to the first category
            final selectedName = page == 1 && state.selectedCategory.isEmpty
                ? selectedCat.name
                : state.selectedCategory;

            state = state.copyWith(
              loaderState: allProducts.isEmpty
                  ? LoaderState.noData
                  : LoaderState.loaded,
              isLoadingMore: false,
              categories: categories,
              products: allProducts,
              selectedCategory: selectedName,
              currentPage: right.results.currentPage,
              totalPages: right.results.totalPages,
            );
          },
        )
        .catchError((Object e) {
          debugPrint("🔴 Error fetching categories with products: $e");
          if (showLoader) {
            state = state.copyWith(
              loaderState: LoaderState.error,
              isLoadingMore: false,
            );
          }
        });
  }

  Future<void> _refreshProductsAfterBill() {
    return fetchProducts(
      categoryId: state.selectedCategoryId,
      search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
      showLoader: false,
    );
  }

  // ── Mode & Filter ──────────────────────────────────────────────
  void setBillingMode(int mode) => state = state.copyWith(billingMode: mode);
  void setCategory(String catName, int catId) {
    state = state.copyWith(
      selectedCategory: catName,
      selectedCategoryId: catId,
      currentPage: 1,
    );
    fetchProducts(
      categoryId: catId,
      search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
    );
  }

  void loadMoreProducts() {
    if (state.isLoadingMore || state.currentPage >= state.totalPages) return;
    fetchProducts(
      search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
      categoryId: state.selectedCategoryId,
      page: state.currentPage + 1,
    );
  }

  void setPaymentMethod(String method) =>
      state = state.copyWith(paymentMethod: method);

  void selectCustomer(DropdownCustomerModel? customer) {
    receivedAmountController.clear();
    state = state.copyWith(
      selectedCustomer: customer,
      paymentStatus: customer == null ? 'Paid' : state.paymentStatus,
      receivedAmount: 0.0,
    );
  }

  void setPaymentStatus(String status) {
    if (status != 'Partially Paid') {
      receivedAmountController.clear();
    }
    state = state.copyWith(
      paymentStatus: status,
      receivedAmount: status == 'Paid' ? 0.0 : state.receivedAmount,
    );
  }

  void setReceivedAmount(double amount) {
    state = state.copyWith(receivedAmount: amount);
  }

  BillTotals get billTotals =>
      computeBillTotals(state.cart, state.discountAmount);

  double calculateBalance(double grandTotal) {
    if (state.paymentStatus == 'Paid') return 0.0;
    if (state.paymentStatus == 'Credit') return grandTotal;
    return (grandTotal - state.receivedAmount).clamp(0.0, grandTotal);
  }

  // ── Search & Cart Expansion Toggles ────────────────────────────
  void toggleSearchExpanded() {
    final expanding = !state.isSearchExpanded;
    state = state.copyWith(isSearchExpanded: expanding);
    if (expanding) {
      searchFocusNode.requestFocus();
    } else {
      searchController.clear();
      searchFocusNode.unfocus();
    }
  }

  void toggleCartExpanded() {
    state = state.copyWith(isCartExpanded: !state.isCartExpanded);
  }

  // ── Cart Operations ────────────────────────────────────────────
  ProductModel? _productById(int id) {
    for (final product in state.products) {
      if (product.id == id) return product;
    }
    return null;
  }

  void _showInsufficientStockToast(double? stockQuantity) {
    final maxQty = maxPurchasableQuantity(stockQuantity);
    if (maxQty != null) {
      showCustomErrorToast(message: Strings.productInsufficientStock(maxQty));
    }
  }

  void addToCart(ProductModel prod) {
    if (isOutOfStock(prod.quantity)) {
      showCustomErrorToast(message: Strings.productOutOfStock);
      return;
    }

    HapticFeedback.lightImpact();
    final index = state.cart.indexWhere((item) => item.productId == prod.id);
    final currentQty = index >= 0 ? state.cart[index].quantity : 0;

    if (!canIncreaseCartQuantity(
      stockQuantity: prod.quantity,
      cartQuantity: currentQty,
    )) {
      _showInsufficientStockToast(prod.quantity);
      return;
    }

    if (index >= 0) {
      final updated = List<CartItemModel>.from(state.cart);
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );
      state = state.copyWith(cart: updated);
    } else {
      state = state.copyWith(
        cart: [
          ...state.cart,
          CartItemModel(
            productId: prod.id,
            name: prod.name,
            price: prod.price,
            quantity: 1,
            emoji: '📦',
            imageUrl: prod.imageUrl,
            sgst: prod.sgst,
            cgst: prod.cgst,
          ),
        ],
      );
    }
  }

  void setProductQuantity(ProductModel prod, int qty) {
    if (qty <= 0) {
      HapticFeedback.lightImpact();
      state = state.copyWith(
        cart: state.cart.where((i) => i.productId != prod.id).toList(),
      );
      return;
    }

    if (isOutOfStock(prod.quantity)) {
      showCustomErrorToast(message: Strings.productOutOfStock);
      return;
    }

    final cappedQty = clampCartQuantity(
      stockQuantity: prod.quantity,
      requestedQty: qty,
    );

    if (cappedQty <= 0) {
      showCustomErrorToast(message: Strings.productOutOfStock);
      return;
    }

    if (cappedQty < qty) {
      _showInsufficientStockToast(prod.quantity);
    }

    HapticFeedback.lightImpact();
    final index = state.cart.indexWhere((item) => item.productId == prod.id);
    if (index >= 0) {
      final updated = List<CartItemModel>.from(state.cart);
      updated[index] = updated[index].copyWith(quantity: cappedQty);
      state = state.copyWith(cart: updated);
    } else {
      state = state.copyWith(
        cart: [
          ...state.cart,
          CartItemModel(
            productId: prod.id,
            name: prod.name,
            price: prod.price,
            quantity: cappedQty,
            emoji: '📦',
            imageUrl: prod.imageUrl,
            sgst: prod.sgst,
            cgst: prod.cgst,
          ),
        ],
      );
    }
  }

  void incrementQuantity(CartItemModel item) {
    if (item.productId == null) {
      final updated = state.cart
          .map((i) => i == item ? i.copyWith(quantity: i.quantity + 1) : i)
          .toList();
      state = state.copyWith(cart: updated);
      return;
    }

    final product = _productById(item.productId!);
    if (product != null) {
      if (isOutOfStock(product.quantity)) {
        showCustomErrorToast(message: Strings.productOutOfStock);
        return;
      }
      if (!canIncreaseCartQuantity(
        stockQuantity: product.quantity,
        cartQuantity: item.quantity,
      )) {
        _showInsufficientStockToast(product.quantity);
        return;
      }
    }

    final updated = state.cart
        .map((i) => i == item ? i.copyWith(quantity: i.quantity + 1) : i)
        .toList();
    state = state.copyWith(cart: updated);
  }

  void decrementQuantity(CartItemModel item) {
    if (item.quantity <= 1) {
      removeCartItem(item);
    } else {
      final updated = state.cart
          .map((i) => i == item ? i.copyWith(quantity: i.quantity - 1) : i)
          .toList();
      state = state.copyWith(cart: updated);
    }
  }

  void removeCartItem(CartItemModel item) {
    state = state.copyWith(cart: state.cart.where((i) => i != item).toList());
  }

  void clearCart() => state = state.copyWith(cart: const []);

  void setDiscountAmount(double amount) {
    state = state.copyWith(discountAmount: amount);
  }

  void updateCartItemDiscount({
    required CartItemModel item,
    required String discountType,
    required double discountValue,
    int? bogoBuyQty,
    int? bogoGetQty,
  }) {
    final updated = state.cart.map((i) {
      if (i == item) {
        return i.copyWith(
          discountType: discountType,
          discountValue: discountValue,
          bogoBuyQty: () => bogoBuyQty,
          bogoGetQty: () => bogoGetQty,
        );
      }
      return i;
    }).toList();
    state = state.copyWith(cart: updated);
  }

  void removeCartItemDiscount(CartItemModel item) {
    final updated = state.cart.map((i) {
      if (i == item) {
        return i.copyWith(
          discountType: 'None',
          discountValue: 0.0,
          bogoBuyQty: () => null,
          bogoGetQty: () => null,
        );
      }
      return i;
    }).toList();
    state = state.copyWith(cart: updated);
  }

  // ── Amount Entry ───────────────────────────────────────────────
  void addAmountEntry() {
    final amtVal = double.tryParse(amountController.text) ?? 0.0;
    if (amtVal <= 0.0) {
      showCustomErrorToast(message: 'Please enter a valid amount');
      return;
    }
    final desc = descriptionController.text.trim();
    final newItem = CartItemModel(
      productId: null,
      name: desc.isEmpty ? 'Amount Entry' : desc,
      price: amtVal,
      quantity: 1,
      emoji: '💰',
      isCustom: true,
    );
    state = state.copyWith(cart: [...state.cart, newItem]);
    amountController.clear();
    descriptionController.clear();
    showCustomToast(message: 'Amount entry added');
  }

  // ── Custom Item ────────────────────────────────────────────────
  void addCustomItem() {
    final name = customNameController.text.trim();
    final qty = int.tryParse(customQtyController.text) ?? 0;
    final price = double.tryParse(customPriceController.text) ?? 0.0;
    if (name.isEmpty || qty <= 0 || price <= 0.0) {
      showCustomErrorToast(message: 'Please fill all item fields correctly');
      return;
    }
    final newItem = CartItemModel(
      productId: null,
      name: name,
      price: price,
      quantity: qty,
      emoji: '📦',
      isCustom: true,
    );
    state = state.copyWith(cart: [...state.cart, newItem]);
    customNameController.clear();
    customQtyController.clear();
    customPriceController.clear();
    showCustomToast(message: 'Custom item added');
  }

  ReceiptPrintData _buildReceiptPrintData({
    required String orderNumber,
    required String dateString,
    required String paymentStatus,
    required double subtotal,
    required double itemDiscountAmount,
    required double billDiscountAmount,
    required double sgstTotal,
    required double cgstTotal,
    required double grandTotal,
    required double balance,
  }) {
    final storeName = ref.read(settingsProvider).settings.storeName;
    final storePhone = ref.read(settingsProvider).companyDetails?.phoneNumber;
    final amountPaid = (grandTotal - balance).clamp(0.0, grandTotal);

    return ReceiptPrintData(
      storeName: storeName,
      storePhone: storePhone,
      orderNumber: orderNumber,
      dateString: dateString,
      customerName: state.selectedCustomer?.name ?? Strings.walkInCustomer,
      paymentMethod: state.paymentMethod,
      paymentStatus: paymentStatus,
      subtotalText: subtotal.toCurrency(),
      grandTotalText: grandTotal.toCurrency(),
      balanceText: balance.toCurrency(),
      amountPaidText: amountPaid.toCurrency(),
      itemDiscountText:
          itemDiscountAmount > 0 ? itemDiscountAmount.toCurrency() : null,
      billDiscountText:
          billDiscountAmount > 0 ? billDiscountAmount.toCurrency() : null,
      sgstTotalText: sgstTotal > 0 ? sgstTotal.toCurrency() : null,
      cgstTotalText: cgstTotal > 0 ? cgstTotal.toCurrency() : null,
      items: state.cart
          .map(
            (item) => ReceiptPrintLineItem(
              name: item.name,
              unitPriceText: item.price.toCurrency(),
              quantityText: item.quantity.toString(),
              lineTotalText: item.totalPrice.toCurrency(),
              discountLabel: item.hasDiscount ? item.discountLabel : null,
            ),
          )
          .toList(),
    );
  }

  Future<void> _showBillPreview({
    required BuildContext context,
    required String orderNumber,
    required String dateString,
    required String paymentStatus,
    required double subtotal,
    required double itemDiscountAmount,
    required double balance,
    required BillTotals totals,
  }) async {
    await CommonBottomSheet.show(
      context: context,
      title: 'Bill Invoice',
      isScrollControlled: true,
      child: BillPreviewSheet(
        orderNumber: orderNumber,
        dateString: dateString,
        paymentMethod: state.paymentMethod,
        paymentStatus: paymentStatus,
        customerName: state.selectedCustomer?.name ?? Strings.walkInCustomer,
        cartItems: state.cart,
        subtotal: subtotal,
        itemDiscountAmount: itemDiscountAmount,
        billDiscountAmount: state.discountAmount,
        sgstTotal: totals.sgstTotal,
        cgstTotal: totals.cgstTotal,
        grandTotal: totals.grandTotal,
        balance: balance,
      ),
    );
  }

  Future<void> _resetAfterBillSave() async {
    state = state.copyWith(
      billNumber: state.billNumber + 1,
      cart: const [],
      selectedCustomer: null,
      isCartExpanded: false,
      isSavingBill: false,
      discountAmount: 0.0,
      paymentStatus: 'Paid',
      receivedAmount: 0.0,
    );

    await _refreshProductsAfterBill();
  }

  // ── Save / Print Bill ──────────────────────────────────────────
  Future<void> saveAndMaybePrint(BuildContext context) async {
    if (state.cart.isEmpty) {
      showCustomErrorToast(message: 'Your bill cart is empty');
      return;
    }
    HapticFeedback.mediumImpact();
    state = state.copyWith(isSavingBill: true);

    final itemDiscountTotal = state.cart.fold<double>(
      0,
      (sum, item) => sum + item.discountAmount,
    );
    final totals = billTotals;
    final totalDiscount = itemDiscountTotal + state.discountAmount;
    final balance = calculateBalance(totals.grandTotal);
    final paymentStatus =
        resolvePaymentStatus(totals.grandTotal, balance);

    const printSource = 'new_bill_save';
    final printerNotifier = ref.read(printerProvider.notifier);
    printerNotifier.logPrintFlow(
      stage: 'save_started',
      source: printSource,
      context: {
        'itemCount': state.cart.length,
        'grandTotal': totals.grandTotal,
      },
    );

    final savedPrinter =
        await ref.read(printerServiceProvider).getSavedPrinter();
    if (savedPrinter != null) {
      await printerNotifier.warmUpConnection(source: printSource);
    } else {
      printerNotifier.logPrintFlow(
        stage: 'warmup_skipped',
        source: printSource,
        context: {'reason': 'no_saved_printer'},
      );
    }

    final payload = {
      'customer': state.selectedCustomer?.id,
      'payment_method': state.paymentMethod,
      'payment_status': paymentStatus,
      'total_amount': totals.grandTotal.toStringAsFixed(2),
      'discount_amount': totalDiscount.toStringAsFixed(2),
      'sgst_amount': totals.sgstTotal.toStringAsFixed(2),
      'cgst_amount': totals.cgstTotal.toStringAsFixed(2),
      'balance': balance.toStringAsFixed(2),
      'items': state.cart
          .map(
            (item) => {
              'product': item.productId,
              'qty': item.quantity,
              'price': item.price.toStringAsFixed(2),
              'discount_type': item.discountType,
              'discount_value': item.discountValue.toStringAsFixed(2),
              'discount_amount': item.discountAmount.toStringAsFixed(2),
              'bogo_buy_qty': item.bogoBuyQty,
              'bogo_get_qty': item.bogoGetQty,
              'sgst': item.sgst.toStringAsFixed(2),
              'cgst': item.cgst.toStringAsFixed(2),
              'total_price': item.totalPrice.toStringAsFixed(2),
            },
          )
          .toList(),
    };

    return await ref
        .read(newBillRepositoryProvider)
        .createBill(payload)
        .fold(
          (left) {
            debugPrint("🔴 API ERROR: ${left.message}");
            showCustomErrorToast(
              message: left.message ?? 'Failed to save bill',
            );
            state = state.copyWith(isSavingBill: false);
          },
          (right) async {
            debugPrint("🟢 API SUCCESS: ${right.message}");
            showCustomToast(message: right.message);

            // Construct preview data
            final previewOrderNumber =
                right.data?.orderNumber ?? 'ORD-TEMP-${state.billNumber}';
            final previewDate =
                right.data?.dateString ?? DateTime.now().toString();
            final previewSubtotal = state.cart.fold<double>(
              0,
              (sum, item) => sum + item.lineTotal,
            );
            final previewItemDiscount = state.cart.fold<double>(
              0,
              (sum, item) => sum + item.discountAmount,
            );
            final previewBalance = right.data?.balance ?? balance;
            final receiptData = _buildReceiptPrintData(
              orderNumber: previewOrderNumber,
              dateString: previewDate,
              paymentStatus: paymentStatus,
              subtotal: previewSubtotal,
              itemDiscountAmount: previewItemDiscount,
              billDiscountAmount: state.discountAmount,
              sgstTotal: totals.sgstTotal,
              cgstTotal: totals.cgstTotal,
              grandTotal: totals.grandTotal,
              balance: previewBalance,
            );

            var printed = false;
            if (savedPrinter != null) {
              printerNotifier.logPrintFlow(
                stage: 'print_started',
                source: printSource,
                context: {
                  'orderNumber': previewOrderNumber,
                  'itemCount': state.cart.length,
                },
              );
              printed = await printerNotifier.printReceiptData(
                receiptData,
                source: printSource,
              );
              printerNotifier.logPrintFlow(
                stage: printed ? 'print_success' : 'print_failed',
                source: printSource,
                context: {
                  'orderNumber': previewOrderNumber,
                  'itemCount': state.cart.length,
                  'printed': printed,
                  if (!printed)
                    'errorMessage':
                        ref.read(printerProvider).errorMessage ??
                        Strings.printerPrintFailed,
                },
              );
              if (printed) {
                showCustomToast(message: Strings.printerSavedSuccess);
              } else {
                showCustomErrorToast(
                  message:
                      ref.read(printerProvider).errorMessage ??
                      Strings.printerPrintFailed,
                );
              }
            }

            if (context.mounted && !printed) {
              await _showBillPreview(
                context: context,
                orderNumber: previewOrderNumber,
                dateString: previewDate,
                paymentStatus: paymentStatus,
                subtotal: previewSubtotal,
                itemDiscountAmount: previewItemDiscount,
                balance: previewBalance,
                totals: totals,
              );
            }

            await _resetAfterBillSave();
          },
        )
        .catchError((Object e) {
          debugPrint("🔴 Error saving bill: $e");
          showCustomErrorToast(message: 'Unexpected error saving bill');
          state = state.copyWith(isSavingBill: false);
        });
  }
}
