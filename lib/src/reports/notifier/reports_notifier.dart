// lib/src/reports/notifier/reports_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/utils/helpers/common_functions.dart';
import 'package:thuga/utils/helpers/date_range_labels.dart';
import '../state/reports_state.dart';

part 'reports_notifier.g.dart';

@Riverpod(keepAlive: false)
class ReportsNotifier extends _$ReportsNotifier {
  @override
  ReportsState build() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    Future.microtask(() => fetchReportsData());
    return ReportsState(
      startDate: today,
      endDate: today,
      selectedPreset: DateRangeIds.today,
    );
  }

  Future<void> fetchReportsData() async {
    state = state.copyWith(loaderState: LoaderState.loading);
    final repo = ref.read(reportsRepositoryProvider);
    final startStr = formatDate(state.startDate, pattern: 'yyyy-MM-dd');
    final endStr = formatDate(state.endDate, pattern: 'yyyy-MM-dd');
    final result = await repo.getReportsData(
      startDate: startStr,
      endDate: endStr,
    );

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

  void setDateRange(DateTime start, DateTime end) {
    state = state.copyWith(
      startDate: start,
      endDate: end,
      selectedPreset: null,
    );
    fetchReportsData();
  }

  void setRange(String range) => setPresetRange(range);

  void setPresetRange(String preset) {
    final (start, end) = calculateDateRangeForPreset(preset);
    state = state.copyWith(
      startDate: start,
      endDate: end,
      selectedPreset: preset,
    );
    fetchReportsData();
  }
}
