// lib/src/calculation/state/calculation_detail_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';

import '../model/calculation_bill_model.dart';
import '../model/calculation_catalog_model.dart';

part 'calculation_detail_state.freezed.dart';

@freezed
sealed class CalculationDetailState with _$CalculationDetailState {
  const factory CalculationDetailState({
    @Default(LoaderState.loading) LoaderState loaderState,
    CalculationBillModel? bill,
    @Default([]) List<CalculationCategoryModel> categories,
    @Default(0.0) double grandTotal,
    String? errorMessage,
  }) = _CalculationDetailState;
}
