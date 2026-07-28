// lib/src/purchase/state/create_purchase_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/src/main/model/dropdown_model.dart';

part 'create_purchase_state.freezed.dart';

class PurchaseItemDraftModel {
  final int productId;
  final String productName;
  final int quantity;
  final double price;

  const PurchaseItemDraftModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => quantity * price;
}

@freezed
sealed class CreatePurchaseState with _$CreatePurchaseState {
  const factory CreatePurchaseState({
    @Default([]) List<PurchaseItemDraftModel> items,
    required DateTime purchaseDate,
    DropdownProductModel? selectedProduct,
    @Default(false) bool isSaving,
  }) = _CreatePurchaseState;
}
