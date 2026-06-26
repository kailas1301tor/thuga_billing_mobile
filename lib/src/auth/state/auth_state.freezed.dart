// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  LoaderState get loaderState =>
      throw _privateConstructorUsedError; // !error texts
  String? get emailErrorText => throw _privateConstructorUsedError;
  String? get passwordErrorText => throw _privateConstructorUsedError;
  String? get phoneErrorText => throw _privateConstructorUsedError;
  String? get companyNameErrorText => throw _privateConstructorUsedError;
  String? get addressErrorText =>
      throw _privateConstructorUsedError; //! success model
  AuthModel? get authModel => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    String? emailErrorText,
    String? passwordErrorText,
    String? phoneErrorText,
    String? companyNameErrorText,
    String? addressErrorText,
    AuthModel? authModel,
  });
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? emailErrorText = freezed,
    Object? passwordErrorText = freezed,
    Object? phoneErrorText = freezed,
    Object? companyNameErrorText = freezed,
    Object? addressErrorText = freezed,
    Object? authModel = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            emailErrorText: freezed == emailErrorText
                ? _value.emailErrorText
                : emailErrorText // ignore: cast_nullable_to_non_nullable
                      as String?,
            passwordErrorText: freezed == passwordErrorText
                ? _value.passwordErrorText
                : passwordErrorText // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneErrorText: freezed == phoneErrorText
                ? _value.phoneErrorText
                : phoneErrorText // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyNameErrorText: freezed == companyNameErrorText
                ? _value.companyNameErrorText
                : companyNameErrorText // ignore: cast_nullable_to_non_nullable
                      as String?,
            addressErrorText: freezed == addressErrorText
                ? _value.addressErrorText
                : addressErrorText // ignore: cast_nullable_to_non_nullable
                      as String?,
            authModel: freezed == authModel
                ? _value.authModel
                : authModel // ignore: cast_nullable_to_non_nullable
                      as AuthModel?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    String? emailErrorText,
    String? passwordErrorText,
    String? phoneErrorText,
    String? companyNameErrorText,
    String? addressErrorText,
    AuthModel? authModel,
  });
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? emailErrorText = freezed,
    Object? passwordErrorText = freezed,
    Object? phoneErrorText = freezed,
    Object? companyNameErrorText = freezed,
    Object? addressErrorText = freezed,
    Object? authModel = freezed,
  }) {
    return _then(
      _$AuthStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        emailErrorText: freezed == emailErrorText
            ? _value.emailErrorText
            : emailErrorText // ignore: cast_nullable_to_non_nullable
                  as String?,
        passwordErrorText: freezed == passwordErrorText
            ? _value.passwordErrorText
            : passwordErrorText // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneErrorText: freezed == phoneErrorText
            ? _value.phoneErrorText
            : phoneErrorText // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyNameErrorText: freezed == companyNameErrorText
            ? _value.companyNameErrorText
            : companyNameErrorText // ignore: cast_nullable_to_non_nullable
                  as String?,
        addressErrorText: freezed == addressErrorText
            ? _value.addressErrorText
            : addressErrorText // ignore: cast_nullable_to_non_nullable
                  as String?,
        authModel: freezed == authModel
            ? _value.authModel
            : authModel // ignore: cast_nullable_to_non_nullable
                  as AuthModel?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl({
    this.loaderState = LoaderState.loaded,
    this.emailErrorText,
    this.passwordErrorText,
    this.phoneErrorText,
    this.companyNameErrorText,
    this.addressErrorText,
    this.authModel,
  });

  @override
  @JsonKey()
  final LoaderState loaderState;
  // !error texts
  @override
  final String? emailErrorText;
  @override
  final String? passwordErrorText;
  @override
  final String? phoneErrorText;
  @override
  final String? companyNameErrorText;
  @override
  final String? addressErrorText;
  //! success model
  @override
  final AuthModel? authModel;

  @override
  String toString() {
    return 'AuthState(loaderState: $loaderState, emailErrorText: $emailErrorText, passwordErrorText: $passwordErrorText, phoneErrorText: $phoneErrorText, companyNameErrorText: $companyNameErrorText, addressErrorText: $addressErrorText, authModel: $authModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.emailErrorText, emailErrorText) ||
                other.emailErrorText == emailErrorText) &&
            (identical(other.passwordErrorText, passwordErrorText) ||
                other.passwordErrorText == passwordErrorText) &&
            (identical(other.phoneErrorText, phoneErrorText) ||
                other.phoneErrorText == phoneErrorText) &&
            (identical(other.companyNameErrorText, companyNameErrorText) ||
                other.companyNameErrorText == companyNameErrorText) &&
            (identical(other.addressErrorText, addressErrorText) ||
                other.addressErrorText == addressErrorText) &&
            (identical(other.authModel, authModel) ||
                other.authModel == authModel));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    emailErrorText,
    passwordErrorText,
    phoneErrorText,
    companyNameErrorText,
    addressErrorText,
    authModel,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState({
    final LoaderState loaderState,
    final String? emailErrorText,
    final String? passwordErrorText,
    final String? phoneErrorText,
    final String? companyNameErrorText,
    final String? addressErrorText,
    final AuthModel? authModel,
  }) = _$AuthStateImpl;

  @override
  LoaderState get loaderState; // !error texts
  @override
  String? get emailErrorText;
  @override
  String? get passwordErrorText;
  @override
  String? get phoneErrorText;
  @override
  String? get companyNameErrorText;
  @override
  String? get addressErrorText; //! success model
  @override
  AuthModel? get authModel;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
