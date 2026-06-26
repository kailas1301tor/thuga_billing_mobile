// lib/src/new_bill/state/new_bill_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import '../../main/model/dropdown_model.dart';
import '../model/new_bill_model.dart';

part 'new_bill_state.freezed.dart';

@freezed
sealed class NewBillState with _$NewBillState {
  const factory NewBillState({
    @Default(LoaderState.loaded) LoaderState loaderState,
    @Default(0) int billingMode, // 0: Quick Tap, 1: Amount Entry
    @Default('') String selectedCategory,
    @Default('') String searchQuery,
    @Default(false) bool isSearchExpanded,
    @Default(false) bool isCartExpanded,
    @Default([]) List<CategoryWithProductsModel> categories,
    @Default([]) List<ProductModel> products,
    @Default([]) List<CartItemModel> cart,
    @Default('Cash') String paymentMethod,
    @Default(1046) int billNumber,
    @Default(false) bool isSavingBill,
    DropdownCustomerModel? selectedCustomer,
    String? errorMessage,
  }) = _NewBillState;
}
