// lib/src/new_bill/notifier/new_bill_notifier.dart
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';
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
  late final FocusNode searchFocusNode;
  late final PageController productPageController;

  @override
  NewBillState build() {
    searchController = TextEditingController();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    customNameController = TextEditingController();
    customQtyController = TextEditingController();
    customPriceController = TextEditingController();
    quantityController = TextEditingController();
    searchFocusNode = FocusNode();
    productPageController = PageController();

    searchController.addListener(() {
      state = state.copyWith(searchQuery: searchController.text.trim());
      if (productPageController.hasClients) {
        productPageController.jumpToPage(0);
      }
    });

    ref.onDispose(() {
      searchController.dispose();
      amountController.dispose();
      descriptionController.dispose();
      customNameController.dispose();
      customQtyController.dispose();
      customPriceController.dispose();
      quantityController.dispose();
      searchFocusNode.dispose();
      productPageController.dispose();
    });

    Future.microtask(() => fetchProducts());
    return const NewBillState();
  }

  Future<void> fetchProducts() async {
    state = state.copyWith(loaderState: LoaderState.loading);
    return await ref.read(newBillRepositoryProvider).getCategoriesWithProducts().fold(
      (left) {
        state = state.copyWith(
          loaderState: handleResponseError(left.key),
          errorMessage: left.message,
        );
      },
      (right) {
        final categories = right.results.data;
        // Flatten products from categories
        final allProducts = categories.expand((cat) => cat.products).toList();

        // Default selection to the first category if category list is not empty
        String defaultCategory = state.selectedCategory;
        if (categories.isNotEmpty) {
          defaultCategory = categories.first.name;
        }

        state = state.copyWith(
          loaderState: LoaderState.loaded,
          categories: categories,
          products: allProducts,
          selectedCategory: defaultCategory,
        );
      },
    ).catchError((Object e) {
      debugPrint("🔴 Error fetching categories with products: $e");
      state = state.copyWith(loaderState: LoaderState.error);
    });
  }

  // ── Mode & Filter ──────────────────────────────────────────────
  void setBillingMode(int mode) => state = state.copyWith(billingMode: mode);
  void setCategory(String cat) {
    state = state.copyWith(selectedCategory: cat);
    if (productPageController.hasClients) {
      productPageController.jumpToPage(0);
    }
  }
  void setPaymentMethod(String method) => state = state.copyWith(paymentMethod: method);

  void selectCustomer(DropdownCustomerModel? customer) {
    state = state.copyWith(selectedCustomer: customer);
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
  void addToCart(ProductModel prod) {
    HapticFeedback.lightImpact();
    final index = state.cart.indexWhere((item) => item.productId == prod.id);
    if (index >= 0) {
      final updated = List<CartItemModel>.from(state.cart);
      updated[index] = updated[index].copyWith(quantity: updated[index].quantity + 1);
      state = state.copyWith(cart: updated);
    } else {
      state = state.copyWith(
        cart: [...state.cart, CartItemModel(productId: prod.id, name: prod.name, price: prod.price, quantity: 1, emoji: '📦', imageUrl: prod.imageUrl)],
      );
    }
  }

  void setProductQuantity(ProductModel prod, int qty) {
    HapticFeedback.lightImpact();
    if (qty <= 0) {
      state = state.copyWith(cart: state.cart.where((i) => i.productId != prod.id).toList());
      return;
    }
    final index = state.cart.indexWhere((item) => item.productId == prod.id);
    if (index >= 0) {
      final updated = List<CartItemModel>.from(state.cart);
      updated[index] = updated[index].copyWith(quantity: qty);
      state = state.copyWith(cart: updated);
    } else {
      state = state.copyWith(
        cart: [...state.cart, CartItemModel(productId: prod.id, name: prod.name, price: prod.price, quantity: qty, emoji: '📦', imageUrl: prod.imageUrl)],
      );
    }
  }

  void incrementQuantity(CartItemModel item) {
    final updated = state.cart.map((i) => i == item ? i.copyWith(quantity: i.quantity + 1) : i).toList();
    state = state.copyWith(cart: updated);
  }

  void decrementQuantity(CartItemModel item) {
    if (item.quantity <= 1) {
      removeCartItem(item);
    } else {
      final updated = state.cart.map((i) => i == item ? i.copyWith(quantity: i.quantity - 1) : i).toList();
      state = state.copyWith(cart: updated);
    }
  }

  void removeCartItem(CartItemModel item) {
    state = state.copyWith(cart: state.cart.where((i) => i != item).toList());
  }

  void clearCart() => state = state.copyWith(cart: const []);

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

  // ── Print Bill ─────────────────────────────────────────────────
  Future<void> printBill(BuildContext context) async {
    if (state.cart.isEmpty) {
      showCustomErrorToast(message: 'Your bill cart is empty');
      return;
    }
    HapticFeedback.mediumImpact();
    state = state.copyWith(isSavingBill: true);

    final total = state.cart.fold<double>(0, (sum, item) => sum + item.lineTotal);

    final payload = {
      'customer': state.selectedCustomer?.id,
      'payment_method': state.paymentMethod,
      'total_amount': total.toStringAsFixed(2),
      'discount_amount': '0.00',
      'items': state.cart.map((item) => {
        'product': item.productId,
        'qty': item.quantity,
        'price': item.price.toStringAsFixed(2),
        'total_price': item.lineTotal.toStringAsFixed(2),
      }).toList(),
    };

    return await ref.read(newBillRepositoryProvider).createBill(payload).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to save bill');
        state = state.copyWith(isSavingBill: false);
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        showCustomToast(message: right.message);
        state = state.copyWith(
          billNumber: state.billNumber + 1,
          cart: const [],
          selectedCustomer: null,
          isCartExpanded: false,
          isSavingBill: false,
        );
      },
    ).catchError((Object e) {
      debugPrint("🔴 Error saving bill: $e");
      showCustomErrorToast(message: 'Unexpected error saving bill');
      state = state.copyWith(isSavingBill: false);
    });
  }
}
