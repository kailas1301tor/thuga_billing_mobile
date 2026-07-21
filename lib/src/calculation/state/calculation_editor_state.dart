// lib/src/calculation/state/calculation_editor_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';

import '../model/calculation_bill_model.dart';
import '../model/calculation_catalog_model.dart';

part 'calculation_editor_state.freezed.dart';

@freezed
sealed class CalculationEditorState with _$CalculationEditorState {
  const factory CalculationEditorState({
    @Default(LoaderState.loaded) LoaderState loaderState,
    @Default(LoaderState.loading) LoaderState catalogLoaderState,
    String? billId,
    @Default('') String billName,
    @Default([]) List<CalculationCustomerSectionModel> customerSections,
    int? activeCustomerId,
    @Default([]) List<CalculationCategoryModel> categories,
    @Default([]) List<CalculationProductModel> products,
    @Default('') String selectedCategory,
    @Default(0) int selectedCategoryId,
    @Default('') String searchQuery,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _CalculationEditorState;
}
