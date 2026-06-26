// lib/src/splash/state/splash_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

enum SplashStatus { idle, checking, done }

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStatus.idle) SplashStatus status,
    String? pendingRoute,
  }) = _SplashState;
}
