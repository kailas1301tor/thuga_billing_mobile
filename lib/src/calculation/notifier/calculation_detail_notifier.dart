// lib/src/calculation/notifier/calculation_detail_notifier.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/data/local/sembast_services.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/utils/helpers/calculation_total_helper.dart';

import '../state/calculation_detail_state.dart';

part 'calculation_detail_notifier.g.dart';

@riverpod
class CalculationDetailNotifier extends _$CalculationDetailNotifier {
  @override
  CalculationDetailState build(String billId) {
    Future.microtask(refresh);
    return const CalculationDetailState();
  }

  Future<void> refresh() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    try {
      await ref.read(sembastServicesProvider).initialize();
    } catch (e) {
      debugPrint('🔴 CALCULATION DETAIL: sembast init error: $e');
    }

    final repo = ref.read(calculationRepositoryProvider);
    final bill = await repo.getBill(billId);

    if (bill == null) {
      state = state.copyWith(
        loaderState: LoaderState.noData,
        errorMessage: 'Bill not found',
      );
      return;
    }

    final catalogResult = await repo.getCatalog(pageSize: 100);

    catalogResult.fold(
      (left) {
        final loaderState = handleResponseError(left.key);
        debugPrint('🔴 CALCULATION DETAIL API ERROR: ${left.message}');
        state = state.copyWith(
          loaderState: loaderState,
          bill: bill,
          errorMessage: left.message,
        );
      },
      (right) {
        final categories = right.results.data;
        final prices = buildCalculationPriceMap(categories);
        debugPrint('🟢 CALCULATION DETAIL: bill ${bill.name} loaded');
        state = state.copyWith(
          loaderState: LoaderState.loaded,
          bill: bill,
          categories: categories,
          grandTotal: calculationBillGrandTotal(bill, prices),
        );
      },
    );
  }
}
