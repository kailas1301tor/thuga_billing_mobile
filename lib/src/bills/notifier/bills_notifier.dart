// lib/src/bills/notifier/bills_notifier.dart
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/utils/helpers/common_functions.dart';
import 'package:thuga/utils/helpers/date_range_labels.dart';
import '../model/bill_model.dart';
import '../notifier/bill_detail_notifier.dart';
import '../repo/bills_repository.dart';
import '../state/bills_state.dart';

part 'bills_notifier.g.dart';

@Riverpod(keepAlive: false)
class BillsNotifier extends _$BillsNotifier {
  late final TextEditingController searchController;
  late final ScrollController scrollController;
  late final BillsRepo _billsRepo;

  @override
  BillsState build() {
    searchController = TextEditingController();
    scrollController = ScrollController();
    _billsRepo = ref.read(billsRepositoryProvider);

    scrollController.addListener(_onScroll);

    ref.onDispose(() {
      scrollController.removeListener(_onScroll);
      searchController.dispose();
      scrollController.dispose();
    });

    searchController.addListener(_onSearchChanged);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    Future.microtask(() => fetchBills());
    return BillsState(
      startDate: today,
      endDate: today,
      selectedPreset: DateRangeIds.today,
    );
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreBills();
    }
  }

  void _onSearchChanged() {
    state = state.copyWith(searchQuery: searchController.text.trim());
    debounce(const Duration(milliseconds: 900), () {
      fetchBills();
    });
  }

  Future<void> fetchBills({int page = 1, bool showLoader = true}) async {
    if (page == 1 && showLoader) {
      state = state.copyWith(loaderState: LoaderState.loading);
    } else if (page > 1) {
      state = state.copyWith(isLoadingMore: true);
    }

    final startStr = formatDate(state.startDate, pattern: 'yyyy-MM-dd');
    final endStr = formatDate(state.endDate, pattern: 'yyyy-MM-dd');
    final status = state.statusFilter == 'All' ? null : state.statusFilter;

    return await _billsRepo
        .getBills(
          startDate: startStr,
          endDate: endStr,
          status: status,
          search: state.searchQuery,
          page: page,
          pageSize: state.pageSize,
        )
        .fold(
          (left) {
            final loader = handleResponseError(left.key);
            debugPrint("🔴 API ERROR: ${left.message}");
            state = state.copyWith(
              loaderState: loader,
              errorMessage: left.message,
              isLoadingMore: false,
            );
          },
          (right) {
            final mergedData = page == 1
                ? right.results.data
                : [
                    ...state.data?.results.data ?? <BillModel>[],
                    ...right.results.data,
                  ];

            if (mergedData.isEmpty) {
              state = state.copyWith(
                loaderState: state.searchQuery.isNotEmpty
                    ? LoaderState.noSearchData
                    : LoaderState.noData,
                data: null,
                currentPage: right.results.currentPage,
                totalPages: right.results.totalPages,
                isLoadingMore: false,
              );
              return;
            }

            debugPrint("🟢 API SUCCESS: bills fetched (page $page)");
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              data: BillsResponseModel(
                message: right.message,
                results: BillsResults(
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
        .catchError((Object e) {
          debugPrint("🔴 UNEXPECTED ERROR: $e");
          state = state.copyWith(
            loaderState: LoaderState.error,
            errorMessage: e.toString(),
            isLoadingMore: false,
          );
        });
  }

  void loadMoreBills() {
    if (state.isLoadingMore ||
        state.loaderState == LoaderState.loading ||
        state.currentPage >= state.totalPages) {
      return;
    }
    fetchBills(page: state.currentPage + 1, showLoader: false);
  }

  void setDateRange(DateTime start, DateTime end) {
    state = state.copyWith(
      startDate: start,
      endDate: end,
      selectedPreset: null,
      currentPage: 1,
    );
    fetchBills();
  }

  void setPresetRange(String preset) {
    final (start, end) = calculateDateRangeForPreset(preset);
    state = state.copyWith(
      startDate: start,
      endDate: end,
      selectedPreset: preset,
      currentPage: 1,
    );
    fetchBills();
  }

  void setStatusFilter(String status) {
    if (state.statusFilter == status) return;
    state = state.copyWith(statusFilter: status);
    fetchBills();
  }

  void toggleSort() {
    state = state.copyWith(isNewestFirst: !state.isNewestFirst);
  }

  void clearSearch() {
    searchController.clear();
  }

  void clearFilters() {
    searchController.clear();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    state = state.copyWith(
      searchQuery: '',
      startDate: today,
      endDate: today,
      selectedPreset: DateRangeIds.today,
      statusFilter: 'All',
    );
    fetchBills();
  }

  Future<bool> updateBillPaymentStatus({
    required int billId,
    required String paymentStatus,
  }) async {
    state = state.copyWith(updatingBillId: billId);

    return await _billsRepo
        .updateBillPaymentStatus(id: billId, paymentStatus: paymentStatus)
        .fold(
          (left) {
            final loader = handleResponseError(left.key);
            debugPrint("🔴 API ERROR: ${left.message}");
            showCustomErrorToast(message: left.message ?? Strings.somethingWentWrong);
            state = state.copyWith(
              updatingBillId: null,
              loaderState: loader,
              errorMessage: left.message,
            );
            return false;
          },
          (right) async {
            debugPrint("🟢 API SUCCESS: ${right.message}");
            showCustomToast(message: Strings.paymentStatusUpdated);
            ref.invalidate(billDetailProvider(billId));
            await fetchBills(page: 1, showLoader: false);
            state = state.copyWith(updatingBillId: null);
            return true;
          },
        )
        .catchError((Object e) {
          debugPrint("🔴 UNEXPECTED ERROR: $e");
          showCustomErrorToast(message: Strings.somethingWentWrong);
          state = state.copyWith(updatingBillId: null);
          return false;
        });
  }

  Future<bool> markBillAsPaid(int billId) {
    return updateBillPaymentStatus(
      billId: billId,
      paymentStatus: Strings.paid,
    );
  }

  Future<bool> markBillAsUnpaid(int billId) {
    return updateBillPaymentStatus(
      billId: billId,
      paymentStatus: Strings.credit,
    );
  }
}
