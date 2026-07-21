// lib/src/calculation/state/calculation_list_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';

import '../model/calculation_bill_model.dart';
import '../model/calculation_catalog_model.dart';

part 'calculation_list_state.freezed.dart';

@freezed
sealed class CalculationListState with _$CalculationListState {
  const factory CalculationListState({
    @Default(LoaderState.loading) LoaderState loaderState,
    @Default([]) List<CalculationBillSummaryModel> bills,
    @Default([]) List<CalculationCategoryModel> categories,
    String? errorMessage,
  }) = _CalculationListState;
}
