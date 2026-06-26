// lib/src/main/state/dropdowns_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import '../model/dropdown_model.dart';

part 'dropdowns_state.freezed.dart';

@freezed
sealed class DropdownsState with _$DropdownsState {
  const factory DropdownsState({
    @Default(LoaderState.loading) LoaderState loaderState,
    @Default(DropdownsDataModel()) DropdownsDataModel data,
    String? errorMessage,
  }) = _DropdownsState;
}
