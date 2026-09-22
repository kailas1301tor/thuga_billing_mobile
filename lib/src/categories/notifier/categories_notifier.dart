// lib/src/categories/notifier/categories_notifier.dart
import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';
import 'package:thuga/utils/helpers/debounce_helper.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import '../model/category_model.dart';
import '../state/categories_state.dart';

part 'categories_notifier.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  late final TextEditingController nameController;
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;
  late final ScrollController scrollController;

  @override
  CategoriesState build() {
    nameController = TextEditingController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    scrollController = ScrollController();

    scrollController.addListener(_onScroll);

    ref.onDispose(() {
      scrollController.removeListener(_onScroll);
      nameController.dispose();
      searchController.dispose();
      searchFocusNode.dispose();
      scrollController.dispose();
    });

    searchController.addListener(_onSearchChanged);

    Future.microtask(() => fetchCategories());
    return const CategoriesState();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreCategories();
    }
  }

  Future<void> fetchCategories({int page = 1, bool showLoader = true}) async {
    if (page == 1 && showLoader) {
      state = state.copyWith(loaderState: LoaderState.loading);
    } else if (page > 1) {
      state = state.copyWith(isLoadingMore: true);
    }

    return await ref
        .read(categoriesRepositoryProvider)
        .getCategories(
          search: state.searchQuery,
          page: page,
          pageSize: state.pageSize,
        )
        .fold(
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
                    ...state.response?.results.data ?? <CategoryModel>[],
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

            debugPrint("🟢 API SUCCESS: categories fetched (page $page)");
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              response: CategoryResponse(
                message: right.message,
                results: CategoryResults(
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
        )
        .catchError((e) {
          debugPrint("🔴 UNEXPECTED ERROR: $e");
          state = state.copyWith(
            loaderState: LoaderState.error,
            isLoadingMore: false,
          );
        });
  }

  void loadMoreCategories() {
    if (state.isLoadingMore ||
        state.loaderState == LoaderState.loading ||
        state.currentPage >= state.totalPages) {
      return;
    }
    fetchCategories(page: state.currentPage + 1, showLoader: false);
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

  void searchCategories(String query) {
    state = state.copyWith(searchQuery: query.trim(), currentPage: 1);
    debounce(const Duration(milliseconds: 900), () {
      fetchCategories();
    });
  }

  void prepareCategoryPicker() {
    state = state.copyWith(searchQuery: '', currentPage: 1);
    fetchCategories();
  }

  void resetAfterCategoryPicker() {
    state = state.copyWith(searchQuery: '', currentPage: 1);
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      return;
    }
    fetchCategories(showLoader: false);
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
            fetchCategories(showLoader: false);
            ref.read(dropdownsProvider.notifier).refreshDropdowns();
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
            fetchCategories(showLoader: false);
            ref.read(dropdownsProvider.notifier).refreshDropdowns();
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
            fetchCategories(showLoader: false);
            ref.read(dropdownsProvider.notifier).refreshDropdowns();
            state = state.copyWith(deleteCategoryLoader: false);
            return true;
          },
        );
  }
}
