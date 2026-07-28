// lib/src/customers/notifier/customers_notifier.dart
import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';
import 'package:thuga/utils/helpers/debounce_helper.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import '../model/customer_model.dart';
import '../state/customers_state.dart';

part 'customers_notifier.g.dart';

@riverpod
class CustomersNotifier extends _$CustomersNotifier {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;
  late final ScrollController scrollController;

  @override
  CustomersState build() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    scrollController = ScrollController();

    scrollController.addListener(_onScroll);

    ref.onDispose(() {
      scrollController.removeListener(_onScroll);
      nameController.dispose();
      phoneController.dispose();
      searchController.dispose();
      searchFocusNode.dispose();
      scrollController.dispose();
    });

    searchController.addListener(_onSearchChanged);

    Future.microtask(() => fetchCustomers());
    return const CustomersState();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreCustomers();
    }
  }

  Future<void> fetchCustomers({int page = 1, bool showLoader = true}) async {
    if (page == 1 && showLoader) {
      state = state.copyWith(loaderState: LoaderState.loading);
    } else if (page > 1) {
      state = state.copyWith(isLoadingMore: true);
    }

    return await ref
        .read(customersRepositoryProvider)
        .getCustomers(
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
                    ...state.response?.results.data ?? <CustomerModel>[],
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

            debugPrint("🟢 API SUCCESS: customers fetched (page $page)");
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              response: CustomerResponse(
                message: right.message,
                results: CustomerResults(
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

  void loadMoreCustomers() {
    if (state.isLoadingMore ||
        state.loaderState == LoaderState.loading ||
        state.currentPage >= state.totalPages) {
      return;
    }
    fetchCustomers(page: state.currentPage + 1, showLoader: false);
  }

  void _onSearchChanged() {
    state = state.copyWith(searchQuery: searchController.text.trim());
    debounce(const Duration(milliseconds: 900), () {
      fetchCustomers();
    });
  }

  void clearSearch() {
    searchController.clear();
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
  }

  Future<bool> createCustomer() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty) {
      showCustomErrorToast(message: 'Please enter a customer name');
      return false;
    }

    state = state.copyWith(saveCustomerLoader: true);

    final map = {
      'name': name,
      'phone_number': phone,
    };

    return await ref.read(customersRepositoryProvider).createCustomer(map).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to create customer');
        state = state.copyWith(saveCustomerLoader: false);
        return false;
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        clearForm();
        showCustomToast(message: right.message);
        fetchCustomers(showLoader: false);
        ref.read(dropdownsProvider.notifier).refreshDropdowns();
        state = state.copyWith(saveCustomerLoader: false);
        return true;
      },
    );
  }

  Future<bool> updateCustomer(int id) async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty) {
      showCustomErrorToast(message: 'Please enter a customer name');
      return false;
    }

    state = state.copyWith(updateCustomerLoader: true);

    final map = {
      'name': name,
      'phone_number': phone,
    };

    return await ref.read(customersRepositoryProvider).updateCustomer(id, map).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to update customer');
        state = state.copyWith(updateCustomerLoader: false);
        return false;
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        clearForm();
        showCustomToast(message: right.message);
        fetchCustomers(showLoader: false);
        ref.read(dropdownsProvider.notifier).refreshDropdowns();
        state = state.copyWith(updateCustomerLoader: false);
        return true;
      },
    );
  }

  Future<bool> deleteCustomer(int id) async {
    state = state.copyWith(deleteCustomerLoader: true);
    return await ref.read(customersRepositoryProvider).deleteCustomer(id).fold(
      (left) {
        debugPrint("🔴 API ERROR: ${left.message}");
        showCustomErrorToast(message: left.message ?? 'Failed to delete customer');
        state = state.copyWith(deleteCustomerLoader: false);
        return false;
      },
      (right) {
        debugPrint("🟢 API SUCCESS: ${right.message}");
        showCustomToast(message: right.message);
        fetchCustomers(showLoader: false);
        ref.read(dropdownsProvider.notifier).refreshDropdowns();
        state = state.copyWith(deleteCustomerLoader: false);
        return true;
      },
    );
  }
}
