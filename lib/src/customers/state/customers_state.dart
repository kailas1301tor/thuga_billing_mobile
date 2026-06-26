// lib/src/customers/state/customers_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import '../model/customer_model.dart';

part 'customers_state.freezed.dart';

@freezed
sealed class CustomersState with _$CustomersState {
  const factory CustomersState({
    @Default(LoaderState.loading) LoaderState loaderState,
    CustomerResponse? response,
    String? errorMessage,
    @Default('') String searchQuery,
    @Default(false) bool saveCustomerLoader,
    @Default(false) bool updateCustomerLoader,
    @Default(false) bool deleteCustomerLoader,
  }) = _CustomersState;
}
