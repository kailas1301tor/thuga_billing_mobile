// lib/src/categories/state/categories_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import '../model/category_model.dart';

part 'categories_state.freezed.dart';

@freezed
sealed class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default(LoaderState.loading) LoaderState loaderState,
    CategoryResponse? response,
    String? errorMessage,
    @Default('') String searchQuery,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(10) int pageSize,
    @Default(false) bool isLoadingMore,
    @Default(false) bool saveCategoryLoader,
    @Default(false) bool updateCategoryLoader,
    @Default(false) bool deleteCategoryLoader,
  }) = _CategoriesState;
}
