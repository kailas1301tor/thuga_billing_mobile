// lib/src/home/notifier/home_notifier.dart
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';

import '../repo/home_repository.dart';
import '../state/home_state.dart';

part 'home_notifier.g.dart';

@Riverpod(keepAlive: false)
class HomeNotifier extends _$HomeNotifier {
  late final HomeRepo _homeRepo;

  @override
  HomeState build() {
    _homeRepo = ref.read(homeRepositoryProvider);
    return HomeState(greetingPrefix: _greetingPrefix());
  }

  String _greetingPrefix() {
    final hour = DateTime.now().hour;
    if (hour < 12) return Strings.goodMorning;
    if (hour < 17) return Strings.goodAfternoon;
    return Strings.goodEvening;
  }

  Future<void> fetchDashboard() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    return await _homeRepo
        .getDashboard()
        .fold(
          (left) {
            final loaderState = handleResponseError(left.key);
            debugPrint("🔴 API ERROR: ${left.message}");
            state = state.copyWith(
              loaderState: loaderState,
              errorMessage: left.message,
            );
          },
          (right) {
            debugPrint("🟢 API SUCCESS: dashboard loaded");
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              data: right,
              greetingPrefix: _greetingPrefix(),
            );
          },
        )
        .catchError((Object e) {
          debugPrint("🔴 UNEXPECTED ERROR: $e");
          state = state.copyWith(loaderState: LoaderState.error);
        });
  }
}
