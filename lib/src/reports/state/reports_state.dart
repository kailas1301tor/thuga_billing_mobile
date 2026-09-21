// lib/src/reports/state/reports_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import '../model/reports_model.dart';

part 'reports_state.freezed.dart';

@freezed
sealed class ReportsState with _$ReportsState {
  const factory ReportsState({
    @Default(LoaderState.loaded) LoaderState loaderState,
    required DateTime startDate,
    required DateTime endDate,
    @Default('Today') String? selectedPreset,
    ReportsDataModel? data,
    String? errorMessage,
  }) = _ReportsState;
}
