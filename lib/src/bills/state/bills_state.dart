// lib/src/bills/state/bills_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import '../model/bill_model.dart';

part 'bills_state.freezed.dart';

@freezed
sealed class BillsState with _$BillsState {
  const factory BillsState({
    @Default(LoaderState.loading) LoaderState loaderState,
    BillsResponseModel? data,
    @Default('') String searchQuery,
    @Default('Today') String dateRangeFilter,
    @Default(true) bool isNewestFirst,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(10) int pageSize,
    @Default(false) bool isLoadingMore,
    int? updatingBillId,
    String? errorMessage,
  }) = _BillsState;
}
