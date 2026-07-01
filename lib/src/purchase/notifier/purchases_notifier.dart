// lib/src/purchase/notifier/purchases_notifier.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:either_dart/either.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import 'package:vyapapp/utils/helpers/common_functions.dart';
import '../repo/purchase_repository.dart';
import '../state/purchases_state.dart';

part 'purchases_notifier.g.dart';

@Riverpod(keepAlive: false)
class PurchasesNotifier extends _$PurchasesNotifier {
  late final ScrollController scrollController;
  late final PurchasesRepo _repo;

  @override
  PurchasesState build() {
    scrollController = ScrollController();
    _repo = ref.read(purchasesRepositoryProvider);

    ref.onDispose(() {
      scrollController.dispose();
    });

    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);

    // Initial fetch
    Future.microtask(() => fetchPurchases());

    return PurchasesState(
      startDate: firstDay,
      endDate: lastDay,
    );
  }

  Future<void> fetchPurchases() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    final startStr = formatDate(state.startDate, pattern: 'yyyy-MM-dd');
    final endStr = formatDate(state.endDate, pattern: 'yyyy-MM-dd');

    return await _repo
        .getPurchases(startDate: startStr, endDate: endStr)
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
            debugPrint("🟢 API SUCCESS: purchases fetched: ${right.purchases.length}");
            if (right.purchases.isEmpty) {
              state = state.copyWith(
                loaderState: LoaderState.noData,
                purchases: const [],
              );
            } else {
              state = state.copyWith(
                loaderState: LoaderState.loaded,
                purchases: right.purchases,
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

  void setDateRange(DateTime start, DateTime end) {
    state = state.copyWith(startDate: start, endDate: end);
    fetchPurchases();
  }
}
