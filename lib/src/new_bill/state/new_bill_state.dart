// lib/src/new_bill/state/new_bill_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import '../../main/model/dropdown_model.dart';
import '../model/new_bill_model.dart';

part 'new_bill_state.freezed.dart';

@freezed
sealed class NewBillState with _$NewBillState {
  const factory NewBillState({
    @Default(LoaderState.loaded) LoaderState loaderState,
    @Default(0) int billingMode, // 0: Quick Tap, 1: Amount Entry
    @Default('') String selectedCategory,
    @Default(0) int selectedCategoryId, // 0 = "All Categories"
    @Default('') String searchQuery,
    @Default(false) bool isSearchExpanded,
    @Default(false) bool isCartExpanded,
    @Default([]) List<CategoryWithProductsModel> categories,
    @Default([]) List<ProductModel> products,
    @Default([]) List<CartItemModel> cart,
    @Default('Cash') String paymentMethod,
    @Default(1046) int billNumber,
    @Default(false) bool isSavingBill,
    @Default(0.0) double discountAmount,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isSearchingProducts,
    @Default('Paid') String paymentStatus,
    @Default(0.0) double receivedAmount,
    DropdownCustomerModel? selectedCustomer,
    String? quantityPickerUnit,
    String? errorMessage,
  }) = _NewBillState;
}
