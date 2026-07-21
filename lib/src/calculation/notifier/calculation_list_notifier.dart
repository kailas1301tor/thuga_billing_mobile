// lib/src/calculation/notifier/calculation_list_notifier.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/data/local/sembast_services.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import 'package:vyapapp/utils/helpers/calculation_total_helper.dart';

import '../model/calculation_bill_model.dart';
import '../state/calculation_list_state.dart';

part 'calculation_list_notifier.g.dart';

@riverpod
class CalculationListNotifier extends _$CalculationListNotifier {
  @override
  CalculationListState build() {
    Future.microtask(refresh);
    return const CalculationListState();
  }

  Future<void> refresh() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    try {
      await ref.read(sembastServicesProvider).initialize();
    } catch (e) {
      debugPrint('🔴 CALCULATION LIST: sembast init error: $e');
    }

    final repo = ref.read(calculationRepositoryProvider);
    final bills = await repo.getAllBills();

    final catalogResult = await repo.getCatalog(pageSize: 100);

    try {
      catalogResult.fold(
        (left) {
          final loaderState = handleResponseError(left.key);
          debugPrint('🔴 CALCULATION LIST API ERROR: ${left.message}');
          state = state.copyWith(
            loaderState: loaderState,
            bills: _summaries(bills, {}),
            errorMessage: left.message,
          );
        },
        (right) {
          final categories = right.results.data;
          final prices = buildCalculationPriceMap(categories);
          debugPrint('🟢 CALCULATION LIST: ${bills.length} bills loaded');
          state = state.copyWith(
            loaderState: LoaderState.loaded,
            bills: _summaries(bills, prices),
            categories: categories,
          );
        },
      );
    } catch (e) {
      debugPrint('🔴 CALCULATION LIST UNEXPECTED: $e');
      state = state.copyWith(
        loaderState: LoaderState.error,
        bills: _summaries(bills, {}),
      );
    }
  }

  List<CalculationBillSummaryModel> _summaries(
    List<CalculationBillModel> bills,
    Map<int, double> prices,
  ) =>
      bills
          .map(
            (bill) => CalculationBillSummaryModel(
              bill: bill,
              grandTotal: calculationBillGrandTotal(bill, prices),
            ),
          )
          .toList();

  Future<void> deleteBill(String id) async {
    await ref.read(calculationRepositoryProvider).deleteBill(id);
    await refresh();
  }
}
