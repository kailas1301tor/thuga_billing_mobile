// lib/src/bills/state/bills_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import '../model/bill_model.dart';

part 'bills_state.freezed.dart';

@freezed
sealed class BillsState with _$BillsState {
  const factory BillsState({
    @Default(LoaderState.loading) LoaderState loaderState,
    BillsResponseModel? data,
    @Default('') String searchQuery,
    @Default('Today') String dateRangeFilter,
    @Default('All') String statusFilter,
    @Default('All') String paymentFilter,
    @Default(true) bool isNewestFirst,
    String? errorMessage,
  }) = _BillsState;
}
