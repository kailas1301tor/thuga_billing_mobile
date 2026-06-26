// lib/src/reports/state/reports_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import '../model/reports_model.dart';

part 'reports_state.freezed.dart';

@freezed
sealed class ReportsState with _$ReportsState {
  const factory ReportsState({
    @Default(LoaderState.loaded) LoaderState loaderState,
    @Default('Today') String selectedRange, // 'Today', 'Yesterday', 'Last 7 Days', 'This Month'
    ReportsDataModel? data,
    String? errorMessage,
  }) = _ReportsState;
}
