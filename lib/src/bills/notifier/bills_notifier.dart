// lib/src/bills/notifier/bills_notifier.dart
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import 'package:vyapapp/src/main/model/dropdown_model.dart';
import '../model/bill_model.dart';
import '../repo/bills_repository.dart';
import '../state/bills_state.dart';

part 'bills_notifier.g.dart';

@Riverpod(keepAlive: false)
class BillsNotifier extends _$BillsNotifier {
  late final TextEditingController searchController;
  late final BillsRepo _billsRepo;

  @override
  BillsState build() {
    searchController = TextEditingController();
    _billsRepo = ref.read(billsRepositoryProvider);

    ref.onDispose(() {
      searchController.dispose();
    });

    searchController.addListener(_onSearchChanged);

    // Fetch initial bills data
    Future.microtask(() => fetchBills());

    return const BillsState();
  }

  void _onSearchChanged() {
    final query = searchController.text.trim();
    state = state.copyWith(searchQuery: query);
  }

  Future<void> fetchBills() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    return await _billsRepo
        .getBills(dateFilter: state.dateRangeFilter)
        .fold(
          (left) {
            final loader = handleResponseError(left.key);
            debugPrint("🔴 API ERROR: ${left.message}");
            state = state.copyWith(
              loaderState: loader,
              errorMessage: left.message,
            );
          },
          (right) {
            debugPrint("🟢 API SUCCESS: bills fetched");
            if (right.results.data.isEmpty) {
              state = state.copyWith(
                loaderState: LoaderState.noData,
                data: right,
              );
            } else {
              state = state.copyWith(
                loaderState: LoaderState.loaded,
                data: right,
              );
            }
          },
        )
        .catchError((Object e) {
          debugPrint("🔴 UNEXPECTED ERROR: $e");
          state = state.copyWith(
            loaderState: LoaderState.error,
            errorMessage: e.toString(),
          );
        });
  }

  void setDateRangeFilter(String value) {
    state = state.copyWith(dateRangeFilter: value);
    fetchBills();
  }

  void toggleSort() {
    state = state.copyWith(isNewestFirst: !state.isNewestFirst);
  }

  void clearFilters() {
    searchController.clear();
    state = state.copyWith(searchQuery: '', dateRangeFilter: 'Today');
    fetchBills();
  }

  /// Computed method to get filtered bills list based on state filters.
  List<BillModel> getFilteredBills(List<DropdownCustomerModel> customers) {
    if (state.data == null) return [];

    var list = List<BillModel>.from(state.data!.results.data);

    // Search query
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      list = list.where((b) {
        final customerName = b.customerId != null
            ? customers
                  .firstWhere(
                    (c) => c.id == b.customerId,
                    orElse: () =>
                        DropdownCustomerModel(id: b.customerId!, name: ''),
                  )
                  .name
                  .toLowerCase()
            : 'walk-in customer';

        return b.orderNumber.toLowerCase().contains(query) ||
            customerName.contains(query) ||
            b.totalAmount.toString().contains(query);
      }).toList();
    }

    // Sorting
    if (state.isNewestFirst) {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    return list;
  }
}
