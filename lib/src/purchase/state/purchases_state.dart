// lib/src/purchase/state/purchases_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import '../model/purchase_model.dart';

part 'purchases_state.freezed.dart';

@freezed
sealed class PurchasesState with _$PurchasesState {
  const factory PurchasesState({
    @Default(LoaderState.loading) LoaderState loaderState,
    @Default([]) List<PurchaseModel> purchases,
    required DateTime startDate,
    required DateTime endDate,
    String? errorMessage,
  }) = _PurchasesState;
}
