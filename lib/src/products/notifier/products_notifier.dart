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
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;

  @override
  ProductsState build() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    barcodeController = TextEditingController();
    qtyController = TextEditingController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    ref.onDispose(() {
      nameController.dispose();
      priceController.dispose();
      barcodeController.dispose();
      qtyController.dispose();
      searchController.dispose();
      searchFocusNode.dispose();
    });

    searchController.addListener(_onSearchChanged);

    Future.microtask(() => fetchProducts());
    return const ProductsState();
  }

  Future<void> fetchProducts({bool showLoader = true}) async {
    if (showLoader) {
      state = state.copyWith(loaderState: LoaderState.loading);
    }
    return await ref.read(productsRepositoryProvider).getProducts(
          search: state.searchQuery,
          categoryId: state.filterCategoryId,
          sort: state.sort,
          page: state.page,
          pageSize: state.pageSize,
        ).fold(
      (left) {
        final loaderState = handleResponseError(left.key);
        debugPrint("🔴 API ERROR: ${left.message}");
        state = state.copyWith(loaderState: loaderState, errorMessage: left.message);
      },
      (right) {
        if (right.results.data.isEmpty) {
          state = state.copyWith(loaderState: LoaderState.noData);
          return;
        }
        debugPrint("🟢 API SUCCESS: products fetched");
        state = state.copyWith(loaderState: LoaderState.loaded, response: right);
      },
    ).catchError((e) {
      debugPrint("🔴 UNEXPECTED ERROR: $e");
      state = state.copyWith(loaderState: LoaderState.error);
    });
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

  Future<bool> createProduct() async {
    final name = nameController.text.trim();
    final priceStr = priceController.text.trim();
    final categoryId = state.selectedCategoryId;

    if (name.isEmpty || priceStr.isEmpty || categoryId == null) {
      showCustomErrorToast(message: 'Please fill all required fields');
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
