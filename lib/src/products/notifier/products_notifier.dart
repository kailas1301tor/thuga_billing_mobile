// lib/src/products/notifier/products_notifier.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';
import 'package:vyapapp/utils/helpers/debounce_helper.dart';
import 'package:vyapapp/src/main/notifier/dropdowns_notifier.dart';
import 'package:vyapapp/utils/helpers/file_picker.dart';
import '../model/product_crud_model.dart';
import '../state/products_state.dart';

part 'products_notifier.g.dart';

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController barcodeController;
  late final TextEditingController qtyController;
  late final TextEditingController sgstController;
  late final TextEditingController cgstController;
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;
  late final ScrollController scrollController;

  @override
  ProductsState build() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    barcodeController = TextEditingController();
    qtyController = TextEditingController();
    sgstController = TextEditingController();
    cgstController = TextEditingController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    scrollController = ScrollController();

    scrollController.addListener(_onScroll);

    ref.onDispose(() {
      scrollController.removeListener(_onScroll);
      nameController.dispose();
      priceController.dispose();
      barcodeController.dispose();
      qtyController.dispose();
      sgstController.dispose();
      cgstController.dispose();
      searchController.dispose();
      searchFocusNode.dispose();
      scrollController.dispose();
    });

    searchController.addListener(_onSearchChanged);

    Future.microtask(() => fetchProducts());
    return const ProductsState();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreProducts();
    }
  }

  Future<void> fetchProducts({int page = 1, bool showLoader = true}) async {
    if (page == 1 && showLoader) {
      state = state.copyWith(loaderState: LoaderState.loading);
    } else if (page > 1) {
      state = state.copyWith(isLoadingMore: true);
    }

    return await ref.read(productsRepositoryProvider).getProducts(
          search: state.searchQuery,
          categoryId: state.filterCategoryId,
          sort: state.sort,
          page: page,
          pageSize: state.pageSize,
        ).fold(
      (left) {
        final loaderState = handleResponseError(left.key);
        debugPrint("🔴 API ERROR: ${left.message}");
        state = state.copyWith(
          loaderState: loaderState,
          errorMessage: left.message,
          isLoadingMore: false,
        );
      },
      (right) {
        final mergedData = page == 1
            ? right.results.data
            : [
                ...state.response?.results.data ?? <ProductCrudModel>[],
                ...right.results.data,
              ];

        if (mergedData.isEmpty) {
          state = state.copyWith(
            loaderState: state.searchQuery.isNotEmpty
                ? LoaderState.noSearchData
                : LoaderState.noData,
            response: null,
            currentPage: right.results.currentPage,
            totalPages: right.results.totalPages,
            isLoadingMore: false,
          );
          return;
        }

        debugPrint("🟢 API SUCCESS: products fetched (page $page)");
        state = state.copyWith(
          loaderState: LoaderState.loaded,
          response: ProductResponse(
            message: right.message,
            results: ProductResults(
              totalCount: right.results.totalCount,
              totalPages: right.results.totalPages,
              currentPage: right.results.currentPage,
              itemPerPage: right.results.itemPerPage,
              data: mergedData,
            ),
          ),
          currentPage: right.results.currentPage,
          totalPages: right.results.totalPages,
          isLoadingMore: false,
        );
      },
    ).catchError((e) {
      debugPrint("🔴 UNEXPECTED ERROR: $e");
      state = state.copyWith(
        loaderState: LoaderState.error,
        isLoadingMore: false,
      );
    });
  }

  void loadMoreProducts() {
    if (state.isLoadingMore ||
        state.loaderState == LoaderState.loading ||
        state.currentPage >= state.totalPages) {
      return;
    }
    fetchProducts(page: state.currentPage + 1, showLoader: false);
  }

  void _onSearchChanged() {
    state = state.copyWith(searchQuery: searchController.text.trim());
    debounce(const Duration(milliseconds: 900), () {
      fetchProducts();
    });
  }

  void clearSearch() {
    searchController.clear();
  }

  void filterByCategory(int? id) {
    state = state.copyWith(filterCategoryId: id);
    fetchProducts();
  }

  void setSort(String newSort) {
    if (state.sort == newSort) return;
    state = state.copyWith(sort: newSort);
    fetchProducts();
  }

  void selectCategory(int? id) {
    state = state.copyWith(selectedCategoryId: id);
  }

  void clearForm() {
    nameController.clear();
    priceController.clear();
    barcodeController.clear();
    qtyController.clear();
    sgstController.clear();
    cgstController.clear();
    state = state.copyWith(
      selectedCategoryId: null,
      isQuickProduct: true,
      selectedImagePath: null,
    );
  }

  Future<void> pickImage() async {
    try {
      final imageFile = await FileSelectionService.instance.pickImage();
      if (imageFile != null) {
        state = state.copyWith(selectedImagePath: imageFile.path);
      }
    } catch (e) {
      debugPrint("🔴 Error picking image: $e");
      showCustomErrorToast(message: "Failed to pick image");
    }
  }

  void clearImage() {
    state = state.copyWith(selectedImagePath: null);
  }

  void toggleQuickProduct(bool value) {
    state = state.copyWith(isQuickProduct: value);
  }

  void initializeEdit({required bool isQuickProduct}) {
    state = state.copyWith(
      isQuickProduct: isQuickProduct,
      selectedImagePath: null,
    );
  }

  bool _validateOptionalTaxFields() {
    for (final entry in [
      ('SGST', sgstController.text.trim()),
      ('CGST', cgstController.text.trim()),
    ]) {
      final label = entry.$1;
      final value = entry.$2;
      if (value.isEmpty) continue;

      final parsed = double.tryParse(value);
      if (parsed == null) {
        showCustomErrorToast(message: '$label must be a valid number');
        return false;
      }
      if (parsed < 0 || parsed > 100) {
        showCustomErrorToast(message: '$label must be between 0 and 100');
        return false;
      }
    }
    return true;
  }

  void _appendOptionalTaxFields(Map<String, dynamic> map) {
    final sgst = sgstController.text.trim();
    if (sgst.isNotEmpty) {
      map['sgst'] = sgst;
    }

    final cgst = cgstController.text.trim();
    if (cgst.isNotEmpty) {
      map['cgst'] = cgst;
    }
  }

  Future<bool> createProduct() async {
    final name = nameController.text.trim();
    final priceStr = priceController.text.trim();
    final categoryId = state.selectedCategoryId;

    if (name.isEmpty || priceStr.isEmpty || categoryId == null) {
      showCustomErrorToast(message: 'Please fill all required fields');
      return false;
    }

    if (!_validateOptionalTaxFields()) {
      return false;
    }

    state = state.copyWith(saveProductLoader: true);

    final Map<String, dynamic> map = {
      'name': name,
      'category': categoryId,
      'price': priceStr,
      'is_quick_product': state.isQuickProduct,
    };

    final barcode = barcodeController.text.trim();
    if (barcode.isNotEmpty) {
      map['barcode'] = barcode;
    }
    final qty = qtyController.text.trim();
    if (qty.isNotEmpty) {
      map['qty'] = qty;
    }
    _appendOptionalTaxFields(map);

    if (state.selectedImagePath != null) {
      map['image'] = await MultipartFile.fromFile(
        state.selectedImagePath!,
        filename: state.selectedImagePath!.split('/').last,
      );
    }

    final formData = FormData.fromMap(map);

    return await ref.read(productsRepositoryProvider).createProduct(formData).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to create product');
        state = state.copyWith(saveProductLoader: false);
        return false;
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        clearForm();
        showCustomToast(message: right.message);
        fetchProducts(showLoader: false);
        ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
        state = state.copyWith(saveProductLoader: false);
        return true;
      },
    );
  }

  Future<bool> updateProduct(int id) async {
    final name = nameController.text.trim();
    final priceStr = priceController.text.trim();
    final categoryId = state.selectedCategoryId;

    if (name.isEmpty || priceStr.isEmpty || categoryId == null) {
      showCustomErrorToast(message: 'Please fill all required fields');
      return false;
    }

    if (!_validateOptionalTaxFields()) {
      return false;
    }

    state = state.copyWith(updateProductLoader: true);

    final Map<String, dynamic> map = {
      'name': name,
      'category': categoryId,
      'price': priceStr,
      'is_quick_product': state.isQuickProduct,
    };

    final barcode = barcodeController.text.trim();
    if (barcode.isNotEmpty) {
      map['barcode'] = barcode;
    }
    final qty = qtyController.text.trim();
    if (qty.isNotEmpty) {
      map['qty'] = qty;
    }
    _appendOptionalTaxFields(map);

    if (state.selectedImagePath != null) {
      map['image'] = await MultipartFile.fromFile(
        state.selectedImagePath!,
        filename: state.selectedImagePath!.split('/').last,
      );
    }

    final formData = FormData.fromMap(map);

    return await ref.read(productsRepositoryProvider).updateProduct(id, formData).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to update product');
        state = state.copyWith(updateProductLoader: false);
        return false;
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        clearForm();
        showCustomToast(message: right.message);
        fetchProducts(showLoader: false);
        ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
        state = state.copyWith(updateProductLoader: false);
        return true;
      },
    );
  }

  Future<bool> deleteProduct(int id) async {
    state = state.copyWith(deleteProductLoader: true);
    return await ref.read(productsRepositoryProvider).deleteProduct(id).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to delete product');
        state = state.copyWith(deleteProductLoader: false);
        return false;
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        showCustomToast(message: right.message);
        fetchProducts(showLoader: false);
        ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
        state = state.copyWith(deleteProductLoader: false);
        return true;
      },
    );
  }

  Future<bool> toggleProductStatus(int id, bool isActive) async {
    // Add product ID to toggling list
    state = state.copyWith(
      togglingProductIds: [...state.togglingProductIds, id],
    );

    // Optimistically update the product's active status locally
    final oldResponse = state.response;
    if (oldResponse != null) {
      final updatedList = oldResponse.results.data.map((product) {
        if (product.id == id) {
          return ProductCrudModel(
            id: product.id,
            categoryId: product.categoryId,
            categoryName: product.categoryName,
            name: product.name,
            barcode: product.barcode,
            quantity: product.quantity,
            price: product.price,
            sgst: product.sgst,
            cgst: product.cgst,
            isQuickProduct: product.isQuickProduct,
            isActive: isActive,
            deleted: product.deleted,
            image: product.image,
            imageUrl: product.imageUrl,
            createdAt: product.createdAt,
            updatedAt: product.updatedAt,
          );
        }
        return product;
      }).toList();

      final updatedResponse = ProductResponse(
        message: oldResponse.message,
        results: ProductResults(
          totalCount: oldResponse.results.totalCount,
          totalPages: oldResponse.results.totalPages,
          currentPage: oldResponse.results.currentPage,
          itemPerPage: oldResponse.results.itemPerPage,
          data: updatedList,
        ),
      );

      state = state.copyWith(response: updatedResponse);
    }

    final statusString = isActive ? "Active" : "Inactive";
    final result = await ref
        .read(productsRepositoryProvider)
        .toggleProductStatus(id, statusString);

    // Remove product ID from toggling list
    state = state.copyWith(
      togglingProductIds: state.togglingProductIds.where((tId) => tId != id).toList(),
    );

    return result.fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to update product status');
        // Revert local state on failure
        state = state.copyWith(response: oldResponse);
        return false;
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        showCustomToast(message: right.message);
        // Refresh products list from server
        fetchProducts(showLoader: false);
        return true;
      },
    );
  }
}
