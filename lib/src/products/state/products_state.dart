import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import '../model/product_crud_model.dart';

part 'products_state.freezed.dart';

@freezed
sealed class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(LoaderState.loading) LoaderState loaderState,
    ProductResponse? response,
    String? errorMessage,
    int? selectedCategoryId,
    @Default('') String searchQuery,
    @Default(false) bool saveProductLoader,
    @Default(false) bool updateProductLoader,
    @Default(false) bool deleteProductLoader,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(10) int pageSize,
    @Default(false) bool isLoadingMore,
    @Default('lowest') String sort,
    int? filterCategoryId,
    @Default(true) bool isQuickProduct,
    String? selectedImagePath,
    @Default([]) List<int> togglingProductIds,
  }) = _ProductsState;
}
