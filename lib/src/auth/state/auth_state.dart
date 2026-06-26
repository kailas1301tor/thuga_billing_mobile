import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import '../model/auth_model.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(LoaderState.loaded) LoaderState loaderState,

    // !error texts
    String? emailErrorText,
    String? passwordErrorText,
    String? phoneErrorText,
    String? companyNameErrorText,
    String? addressErrorText,

    //! success model
    AuthModel? authModel,
  }) = _AuthState;
}
