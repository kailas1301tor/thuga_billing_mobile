// lib/src/customers/notifier/customers_notifier.dart
import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';
import 'package:vyapapp/src/main/notifier/dropdowns_notifier.dart';
import '../state/customers_state.dart';

part 'customers_notifier.g.dart';

@riverpod
class CustomersNotifier extends _$CustomersNotifier {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;

  @override
  CustomersState build() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    ref.onDispose(() {
      nameController.dispose();
      phoneController.dispose();
      searchController.dispose();
      searchFocusNode.dispose();
    });

    searchController.addListener(_onSearchChanged);

    Future.microtask(() => fetchCustomers());
    return const CustomersState();
  }

  Future<void> fetchCustomers() async {
    state = state.copyWith(loaderState: LoaderState.loading);
    return await ref.read(customersRepositoryProvider).getCustomers().fold(
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
        debugPrint("🟢 API SUCCESS: customers fetched");
        state = state.copyWith(loaderState: LoaderState.loaded, response: right);
      },
    ).catchError((e) {
      debugPrint("🔴 UNEXPECTED ERROR: $e");
      state = state.copyWith(loaderState: LoaderState.error);
    });
  }

  void _onSearchChanged() {
    state = state.copyWith(searchQuery: searchController.text.trim());
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

    if (name.isEmpty || phone.isEmpty) {
      showCustomErrorToast(message: 'Please fill all required fields');
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
        fetchCustomers();
        ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
        state = state.copyWith(saveCustomerLoader: false);
        return true;
      },
    );
  }

  Future<bool> updateCustomer(int id) async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      showCustomErrorToast(message: 'Please fill all required fields');
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
        fetchCustomers();
        ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
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
        fetchCustomers();
        ref.read(dropdownsNotifierProvider.notifier).refreshDropdowns();
        state = state.copyWith(deleteCustomerLoader: false);
        return true;
      },
    );
  }
}
