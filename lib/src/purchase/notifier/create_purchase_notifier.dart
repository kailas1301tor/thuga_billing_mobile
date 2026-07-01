// lib/src/purchase/notifier/create_purchase_notifier.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:either_dart/either.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/common_functions.dart';
import 'package:vyapapp/src/main/model/dropdown_model.dart';
import '../repo/purchase_repository.dart';
import '../state/create_purchase_state.dart';
import 'purchases_notifier.dart';

part 'create_purchase_notifier.g.dart';

@Riverpod(keepAlive: false)
class CreatePurchaseNotifier extends _$CreatePurchaseNotifier {
  late final TextEditingController quantityController;
  late final TextEditingController priceController;
  late final PurchasesRepo _repo;

  @override
  CreatePurchaseState build() {
    quantityController = TextEditingController();
    priceController = TextEditingController();
    _repo = ref.read(purchasesRepositoryProvider);

    ref.onDispose(() {
      quantityController.dispose();
      priceController.dispose();
    });

    return CreatePurchaseState(
      purchaseDate: DateTime.now(),
    );
  }

  void selectProduct(DropdownProductModel? product) {
    state = state.copyWith(selectedProduct: product);
  }

  void updatePurchaseDate(DateTime date) {
    state = state.copyWith(purchaseDate: date);
  }

  bool addItem() {
    final product = state.selectedProduct;
    if (product == null) {
      showCustomErrorToast(message: 'Please select a product');
      return false;
    }

    final qty = int.tryParse(quantityController.text) ?? 0;
    if (qty <= 0) {
      showCustomErrorToast(message: 'Quantity must be greater than 0');
      return false;
    }

    final price = double.tryParse(priceController.text) ?? 0.0;
    if (price <= 0) {
      showCustomErrorToast(message: 'Price must be greater than 0');
      return false;
    }

    // Check if product is already added, if so, merge or alert?
    // Let's merge it!
    final index = state.items.indexWhere((i) => i.productId == product.id);
    final updatedList = List<PurchaseItemDraftModel>.from(state.items);

    if (index >= 0) {
      final existing = updatedList[index];
      updatedList[index] = PurchaseItemDraftModel(
        productId: product.id,
        productName: product.name,
        quantity: existing.quantity + qty,
        price: price, // overwrite with latest purchase price
      );
    } else {
      updatedList.add(
        PurchaseItemDraftModel(
          productId: product.id,
          productName: product.name,
          quantity: qty,
          price: price,
        ),
      );
    }

    state = state.copyWith(
      items: updatedList,
      selectedProduct: null,
    );

    quantityController.clear();
    priceController.clear();
    showCustomToast(message: 'Item added successfully');
    return true;
  }

  void removeItem(int index) {
    final updatedList = List<PurchaseItemDraftModel>.from(state.items);
    updatedList.removeAt(index);
    state = state.copyWith(items: updatedList);
    showCustomToast(message: 'Item removed');
  }

  Future<void> savePurchase(BuildContext context) async {
    if (state.items.isEmpty) {
      showCustomErrorToast(message: 'Please add at least one item');
      return;
    }

    state = state.copyWith(isSaving: true);

    final totalAmount = state.items.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    final payload = {
      'purchase_date': formatDate(state.purchaseDate, pattern: 'yyyy-MM-dd'),
      'total_amount': totalAmount,
      'items': state.items.map((item) => {
        'product': item.productId,
        'qty': item.quantity,
        'price': item.price,
        'total_price': item.totalPrice,
      }).toList(),
    };

    return await _repo.createPurchase(payload).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to create purchase');
        state = state.copyWith(isSaving: false);
      },
      (right) {
        debugPrint("🟢 API SUCCESS: purchase created successfully");
        showCustomToast(message: right.message);
        
        // Refresh listing
        ref.read(purchasesNotifierProvider.notifier).fetchPurchases();
        
        Navigator.pop(context);
      },
    );
  }
}
