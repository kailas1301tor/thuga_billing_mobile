// lib/src/bills/notifier/bills_notifier.dart
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
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
        .getBills()
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
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              data: right,
            );
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
  }

  void setStatusFilter(String value) {
    state = state.copyWith(statusFilter: value);
  }

  void setPaymentFilter(String value) {
    state = state.copyWith(paymentFilter: value);
  }

  void toggleSort() {
    state = state.copyWith(isNewestFirst: !state.isNewestFirst);
  }

  void clearFilters() {
    searchController.clear();
    state = state.copyWith(
      searchQuery: '',
      dateRangeFilter: 'All Time', // Reset to show all, or 'Today' as default
      statusFilter: 'All',
      paymentFilter: 'All',
    );
  }

  /// Computed method to get filtered bills list based on state filters.
  List<BillModel> getFilteredBills() {
    if (state.data == null) return [];

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));
    final sevenDaysAgo = todayStart.subtract(const Duration(days: 7));

    var list = List<BillModel>.from(state.data!.bills);

    // Date filtering
    if (state.dateRangeFilter == 'Today') {
      list = list.where((b) {
        final bDate = DateTime(b.date.year, b.date.month, b.date.day);
        return bDate.isAtSameMomentAs(todayStart);
      }).toList();
    } else if (state.dateRangeFilter == 'Yesterday') {
      list = list.where((b) {
        final bDate = DateTime(b.date.year, b.date.month, b.date.day);
        return bDate.isAtSameMomentAs(yesterdayStart);
      }).toList();
    } else if (state.dateRangeFilter == 'This Week') {
      list = list.where((b) {
        final bDate = DateTime(b.date.year, b.date.month, b.date.day);
        return bDate.isAfter(sevenDaysAgo) || bDate.isAtSameMomentAs(sevenDaysAgo);
      }).toList();
    }

    // Status filtering
    if (state.statusFilter == 'Paid') {
      list = list.where((b) => b.isPaid).toList();
    } else if (state.statusFilter == 'Pending') {
      list = list.where((b) => !b.isPaid).toList();
    }

    // Payment filtering
    if (state.paymentFilter != 'All') {
      list = list.where((b) =>
          b.paymentMethod.toLowerCase() == state.paymentFilter.toLowerCase()).toList();
    }

    // Search query
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      list = list.where((b) {
        return b.billNumber.toLowerCase().contains(query) ||
            b.customerLabel.toLowerCase().contains(query) ||
            b.amount.toString().contains(query);
      }).toList();
    }

    // Sorting
    if (state.isNewestFirst) {
      list.sort((a, b) => b.date.compareTo(a.date));
    } else {
      list.sort((a, b) => a.date.compareTo(b.date));
    }

    return list;
  }

  /// Computed method to get recalculated stats based on filtered bills.
  BillsSummaryModel getFilteredSummary(List<BillModel> filteredBills) {
    double totalSales = 0.0;
    int pendingBills = 0;
    for (final bill in filteredBills) {
      if (bill.isPaid) {
        totalSales += bill.amount;
      } else {
        pendingBills++;
      }
    }
    double avgValue =
        filteredBills.isNotEmpty ? (totalSales / filteredBills.length) : 0.0;
    return BillsSummaryModel(
      totalBills: filteredBills.length,
      totalSales: totalSales,
      avgBillValue: avgValue,
      pendingBills: pendingBills,
    );
  }
}
