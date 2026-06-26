// lib/src/categories/notifier/categories_notifier.dart
import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';
import 'package:vyapapp/utils/helpers/debounce_helper.dart';
import 'package:vyapapp/src/main/notifier/dropdowns_notifier.dart';
import '../state/categories_state.dart';

part 'categories_notifier.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  late final TextEditingController nameController;
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;

  @override
  CategoriesState build() {
    nameController = TextEditingController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    ref.onDispose(() {
      nameController.dispose();
      searchController.dispose();
      searchFocusNode.dispose();
    });

    searchController.addListener(_onSearchChanged);

    Future.microtask(() => fetchCategories());
    return const CategoriesState();
  }

  Future<void> fetchCategories() async {
    state = state.copyWith(loaderState: LoaderState.loading);
    return await ref
        .read(categoriesRepositoryProvider)
        .getCategories(search: state.searchQuery)
        .fold(
          (left) {
            final loaderState = handleResponseError(left.key);
            debugPrint("🔴 API ERROR: ${left.message}");
            state = state.copyWith(
              loaderState: loaderState,
              errorMessage: left.message,
            );
          },
          (right) {
            if (right.results.data.isEmpty) {
              state = state.copyWith(loaderState: LoaderState.noData);
              return;
            }
            debugPrint("🟢 API SUCCESS: categories fetched");
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              response: right,
            );
          },
        )
        .catchError((e) {
          debugPrint("🔴 UNEXPECTED ERROR: $e");
          state = state.copyWith(loaderState: LoaderState.error);
        });
  }

  void _onSearchChanged() {
    state = state.copyWith(searchQuery: searchController.text.trim());
    debounce(const Duration(milliseconds: 900), () {
      fetchCategories();
    });
  }

  void clearSearch() {
    searchController.clear();
  }

  Future<bool> createCategory() async {
    state = state.copyWith(saveCategoryLoader: true);
    final name = nameController.text.trim();
    if (name.isEmpty) return false;

    return await ref
        .read(categoriesRepositoryProvider)
        .createCategory(name)
        .fold(
          (left) {
            debugPrint("🔴 API ERROR: ${left.message}");
            showCustomErrorToast(
              message: left.message ?? 'Failed to create category',
            );
            state = state.copyWith(saveCategoryLoader: false);
            return false;
          },
          (right) {
            debugPrint("🟢 API SUCCESS: ${right.message}");
            nameController.clear();
            showCustomToast(message: right.message);
            fetchCategories();
            ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
            state = state.copyWith(saveCategoryLoader: false);
            return true;
          },
        );
  }

  Future<bool> updateCategory(int id, String name) async {
    state = state.copyWith(updateCategoryLoader: true);
    if (name.isEmpty) return false;

    return await ref
        .read(categoriesRepositoryProvider)
        .updateCategory(id, name)
        .fold(
          (left) {
            debugPrint("🔴 API ERROR: ${left.message}");
            showCustomErrorToast(
              message: left.message ?? 'Failed to update category',
            );
            state = state.copyWith(updateCategoryLoader: false);
            return false;
          },
          (right) {
            debugPrint("🟢 API SUCCESS: ${right.message}");
            showCustomToast(message: right.message);
            fetchCategories();
            ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
            state = state.copyWith(updateCategoryLoader: false);
            return true;
          },
        );
  }

  Future<bool> deleteCategory(int id) async {
    state = state.copyWith(deleteCategoryLoader: true);
    return await ref
        .read(categoriesRepositoryProvider)
        .deleteCategory(id)
        .fold(
          (left) {
            debugPrint("🔴 API ERROR: ${left.message}");
            showCustomErrorToast(
              message: left.message ?? 'Failed to delete category',
            );
            state = state.copyWith(deleteCategoryLoader: false);
            return false;
          },
          (right) {
            debugPrint("🟢 API SUCCESS: ${right.message}");
            showCustomToast(message: right.message);
            fetchCategories();
            ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
            state = state.copyWith(deleteCategoryLoader: false);
            return true;
          },
        );
  }
}
