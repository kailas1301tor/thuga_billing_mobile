// lib/src/main/notifier/dropdowns_notifier.dart
import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/utils/helpers/api_error_handler.dart';
import '../state/dropdowns_state.dart';

part 'dropdowns_notifier.g.dart';

@Riverpod(keepAlive: true)
class DropdownsNotifier extends _$DropdownsNotifier {
  @override
  DropdownsState build() => const DropdownsState();

  Future<void> fetchDropdowns() async {
    state = state.copyWith(loaderState: LoaderState.loading);
    return await ref.read(dropdownsRepositoryProvider).getDropdowns().fold(
      (left) {
        final loaderState = handleResponseError(left.key);
        debugPrint("🔴 API ERROR: ${left.message}");
        state = state.copyWith(loaderState: loaderState, errorMessage: left.message);
      },
      (right) {
        debugPrint("🟢 API SUCCESS: dropdowns loaded");
        state = state.copyWith(
          loaderState: LoaderState.loaded,
          data: right,
        );
      },
    ).catchError((e) {
      debugPrint("🔴 UNEXPECTED ERROR: $e");
      state = state.copyWith(loaderState: LoaderState.error);
    });
  }

  Future<void> refreshDropdowns() async {
    return fetchDropdowns();
  }
}
