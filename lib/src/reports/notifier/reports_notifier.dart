// lib/src/reports/notifier/reports_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import '../state/reports_state.dart';

part 'reports_notifier.g.dart';

@Riverpod(keepAlive: false)
class ReportsNotifier extends _$ReportsNotifier {
  @override
  ReportsState build() {
    Future.microtask(() => fetchReportsData());
    return const ReportsState();
  }

  Future<void> fetchReportsData() async {
    state = state.copyWith(loaderState: LoaderState.loading);
    final repo = ref.read(reportsRepositoryProvider);
    final result = await repo.getReportsData(state.selectedRange);

    result.fold(
      (left) {
        state = state.copyWith(
          loaderState: handleResponseError(left.key),
          errorMessage: left.message,
        );
      },
      (right) {
        state = state.copyWith(
          loaderState: LoaderState.loaded,
          data: right,
        );
      },
    );
  }

  void setRange(String range) {
    if (state.selectedRange == range) return;
    state = state.copyWith(selectedRange: range);
    fetchReportsData();
  }
}
