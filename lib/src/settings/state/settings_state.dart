// lib/src/settings/state/settings_state.dart
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/utils/helpers/working_hour_helper.dart';
import '../model/settings_model.dart';
import '../model/company_details_model.dart';

part 'settings_state.freezed.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(LoaderState.loaded) LoaderState loaderState,
    required SettingsModel settings,
    CompanyDetailsModel? companyDetails,
    @Default(defaultStartWorkingTime) TimeOfDay startWorkingTime,
    @Default(defaultEndWorkingTime) TimeOfDay endWorkingTime,
    String? errorMessage,
  }) = _SettingsState;
}
