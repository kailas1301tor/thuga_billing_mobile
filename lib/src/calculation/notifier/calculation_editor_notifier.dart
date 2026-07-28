// lib/src/calculation/notifier/calculation_editor_notifier.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/data/local/sembast_services.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/src/main/model/dropdown_model.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/utils/helpers/calculation_total_helper.dart';
import 'package:thuga/utils/helpers/debounce_helper.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';

import '../model/calculation_bill_model.dart';
import '../model/calculation_catalog_model.dart';
import '../state/calculation_editor_state.dart';

part 'calculation_editor_notifier.g.dart';

@riverpod
class CalculationEditorNotifier extends _$CalculationEditorNotifier {
  late final TextEditingController billNameController;
  late final TextEditingController searchController;

  @override
  CalculationEditorState build(String? billId) {
    billNameController = TextEditingController();
    searchController = TextEditingController();

    ref.onDispose(() {
      billNameController.dispose();
      searchController.dispose();
    });

    searchController.addListener(_onSearchChanged);

    Future.microtask(() async {
      await _loadExistingBill(billId);
      await fetchCatalog();
    });

    return CalculationEditorState(billId: billId);
  }

  Future<void> _loadExistingBill(String? billId) async {
    if (billId == null || billId.isEmpty) return;

    try {
      await ref.read(sembastServicesProvider).initialize();
    } catch (_) {}

    final bill = await ref.read(calculationRepositoryProvider).getBill(billId);
    if (bill == null) return;

    billNameController.text = bill.name;
    state = state.copyWith(
      billName: bill.name,
      customerSections: bill.customerSections,
      activeCustomerId: bill.customerSections.isNotEmpty
          ? bill.customerSections.first.customerId
          : null,
    );
  }

  void _onSearchChanged() {
    debounce(
      const Duration(milliseconds: 400),
      () {
        final query = searchController.text.trim();
        state = state.copyWith(searchQuery: query);
        fetchCatalog(search: query.isEmpty ? null : query);
      },
    );
  }

  Future<void> fetchCatalog({String? search}) async {
    state = state.copyWith(catalogLoaderState: LoaderState.loading);

    final catalogResult = await ref
        .read(calculationRepositoryProvider)
        .getCatalog(
          search: search,
          categoryId: state.selectedCategoryId == 0
              ? null
              : state.selectedCategoryId,
          pageSize: 100,
        );

    catalogResult.fold(
          (left) {
            final loaderState = handleResponseError(left.key);
            debugPrint('🔴 CALCULATION EDITOR API ERROR: ${left.message}');
            state = state.copyWith(catalogLoaderState: loaderState);
          },
          (right) {
            final categories = right.results.data;
            final selectedCategory = state.selectedCategory.isEmpty &&
                    categories.isNotEmpty
                ? categories.first.name
                : state.selectedCategory;
            final selectedId = state.selectedCategoryId == 0 &&
                    categories.isNotEmpty
                ? categories.first.id
                : state.selectedCategoryId;

            final products = _productsForCategory(categories, selectedId);

            state = state.copyWith(
              catalogLoaderState: LoaderState.loaded,
              categories: categories,
              selectedCategory: selectedCategory,
              selectedCategoryId: selectedId,
              products: products,
            );
          },
        );
  }

  List<CalculationProductModel> _productsForCategory(
    List<CalculationCategoryModel> categories,
    int categoryId,
  ) {
    for (final category in categories) {
      if (category.id == categoryId) return category.products;
    }
    if (categories.isEmpty) return const [];
    return categories.first.products;
  }

  void onBillNameChanged(String value) {
    state = state.copyWith(billName: value.trim());
  }

  void setCategory(String name, int id) {
    state = state.copyWith(
      selectedCategory: name,
      selectedCategoryId: id,
      products: _productsForCategory(state.categories, id),
    );
  }

  bool hasCustomer(int customerId) =>
      state.customerSections.any((s) => s.customerId == customerId);

  void addCustomerSection(DropdownCustomerModel customer) {
    if (hasCustomer(customer.id)) {
      showCustomErrorToast(message: Strings.customerAlreadyInBill);
      return;
    }

    final sections = [
      ...state.customerSections,
      CalculationCustomerSectionModel(
        customerId: customer.id,
        customerName: customer.name,
      ),
    ];

    state = state.copyWith(
      customerSections: sections,
      activeCustomerId: customer.id,
    );
  }

  void setActiveCustomer(int customerId) {
    state = state.copyWith(
      activeCustomerId:
          state.activeCustomerId == customerId ? null : customerId,
    );
  }

  void removeCustomerSection(int customerId) {
    final sections = state.customerSections
        .where((s) => s.customerId != customerId)
        .toList();
    final activeId = state.activeCustomerId == customerId
        ? (sections.isNotEmpty ? sections.first.customerId : null)
        : state.activeCustomerId;

    state = state.copyWith(
      customerSections: sections,
      activeCustomerId: activeId,
    );
  }

  CalculationCustomerSectionModel? get _activeSection {
    final id = state.activeCustomerId;
    if (id == null) return null;
    try {
      return state.customerSections.firstWhere((s) => s.customerId == id);
    } catch (_) {
      return null;
    }
  }

  int productQuantityInActiveSection(int productId) {
    final section = _activeSection;
    if (section == null) return 0;
    try {
      return section.items.firstWhere((i) => i.productId == productId).quantity;
    } catch (_) {
      return 0;
    }
  }

  void addProduct(CalculationProductModel product, {int qty = 1}) {
    final activeId = state.activeCustomerId;
    if (activeId == null) {
      showCustomErrorToast(message: Strings.selectCustomerFirst);
      return;
    }

    final sections = state.customerSections.map((section) {
      if (section.customerId != activeId) return section;

      final items = [...section.items];
      final index = items.indexWhere((i) => i.productId == product.id);
      if (index >= 0) {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity + qty,
        );
      } else {
        items.add(
          CalculationLineItemModel(
            productId: product.id,
            productName: product.name,
            categoryId: product.categoryId,
            categoryName: product.categoryName,
            quantity: qty,
          ),
        );
      }
      return section.copyWith(items: items);
    }).toList();

    state = state.copyWith(customerSections: sections);
  }

  void updateQuantity(int productId, int quantity) {
    final activeId = state.activeCustomerId;
    if (activeId == null) return;

    final sections = state.customerSections.map((section) {
      if (section.customerId != activeId) return section;

      if (quantity <= 0) {
        return section.copyWith(
          items: section.items.where((i) => i.productId != productId).toList(),
        );
      }

      final items = section.items.map((item) {
        if (item.productId != productId) return item;
        return item.copyWith(quantity: quantity);
      }).toList();

      return section.copyWith(items: items);
    }).toList();

    state = state.copyWith(customerSections: sections);
  }

  Map<int, double> get priceMap => buildCalculationPriceMap(state.categories);

  double sectionTotal(CalculationCustomerSectionModel section) =>
      calculationSectionTotal(section, priceMap);

  double get draftGrandTotal => state.customerSections.fold<double>(
        0,
        (sum, section) => sum + sectionTotal(section),
      );

  Future<bool> saveBill() async {
    final name = billNameController.text.trim();
    if (name.isEmpty) {
      showCustomErrorToast(message: Strings.enterBillName);
      return false;
    }
    if (state.customerSections.isEmpty) {
      showCustomErrorToast(message: Strings.selectCustomerFirst);
      return false;
    }
    if (state.customerSections.any((s) => s.items.isEmpty)) {
      showCustomErrorToast(message: Strings.eachCustomerNeedsProduct);
      return false;
    }

    state = state.copyWith(isSaving: true);

    try {
      await ref.read(sembastServicesProvider).initialize();
    } catch (_) {}

    final now = DateTime.now();
    final existingId = state.billId;
    CalculationBillModel? existing;
    if (existingId != null && existingId.isNotEmpty) {
      existing = await ref.read(calculationRepositoryProvider).getBill(existingId);
    }

    final bill = CalculationBillModel(
      id: existing?.id ?? generateCalculationBillId(),
      name: name,
      customerSections: state.customerSections,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    await ref.read(calculationRepositoryProvider).saveBill(bill);
    debugPrint('🟢 CALCULATION EDITOR: bill saved ${bill.id}');
    showCustomToast(message: Strings.billSavedSuccess);
    state = state.copyWith(isSaving: false, billId: bill.id);
    return true;
  }
}
