// lib/src/home/state/home_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/res/enums/enums.dart';

import '../model/home_dashboard_model.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default(LoaderState.loading) LoaderState loaderState,
    HomeDashboardModel? data,
    String? greetingPrefix,
    String? errorMessage,
  }) = _HomeState;
}
