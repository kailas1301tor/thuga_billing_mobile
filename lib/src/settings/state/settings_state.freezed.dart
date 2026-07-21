// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SettingsState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  SettingsModel get settings => throw _privateConstructorUsedError;
  CompanyDetailsModel? get companyDetails => throw _privateConstructorUsedError;
  TimeOfDay get startWorkingTime => throw _privateConstructorUsedError;
  TimeOfDay get endWorkingTime => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
    SettingsState value,
    $Res Function(SettingsState) then,
  ) = _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    SettingsModel settings,
    CompanyDetailsModel? companyDetails,
    TimeOfDay startWorkingTime,
    TimeOfDay endWorkingTime,
    String? errorMessage,
  });
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? settings = null,
    Object? companyDetails = freezed,
    Object? startWorkingTime = null,
    Object? endWorkingTime = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as SettingsModel,
            companyDetails: freezed == companyDetails
                ? _value.companyDetails
                : companyDetails // ignore: cast_nullable_to_non_nullable
                      as CompanyDetailsModel?,
            startWorkingTime: null == startWorkingTime
                ? _value.startWorkingTime
                : startWorkingTime // ignore: cast_nullable_to_non_nullable
                      as TimeOfDay,
            endWorkingTime: null == endWorkingTime
                ? _value.endWorkingTime
                : endWorkingTime // ignore: cast_nullable_to_non_nullable
                      as TimeOfDay,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
    _$SettingsStateImpl value,
    $Res Function(_$SettingsStateImpl) then,
  ) = __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    SettingsModel settings,
    CompanyDetailsModel? companyDetails,
    TimeOfDay startWorkingTime,
    TimeOfDay endWorkingTime,
    String? errorMessage,
  });
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
    _$SettingsStateImpl _value,
    $Res Function(_$SettingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? settings = null,
    Object? companyDetails = freezed,
    Object? startWorkingTime = null,
    Object? endWorkingTime = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$SettingsStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as SettingsModel,
        companyDetails: freezed == companyDetails
            ? _value.companyDetails
            : companyDetails // ignore: cast_nullable_to_non_nullable
                  as CompanyDetailsModel?,
        startWorkingTime: null == startWorkingTime
            ? _value.startWorkingTime
            : startWorkingTime // ignore: cast_nullable_to_non_nullable
                  as TimeOfDay,
        endWorkingTime: null == endWorkingTime
            ? _value.endWorkingTime
            : endWorkingTime // ignore: cast_nullable_to_non_nullable
                  as TimeOfDay,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SettingsStateImpl implements _SettingsState {
  const _$SettingsStateImpl({
    this.loaderState = LoaderState.loaded,
    required this.settings,
    this.companyDetails,
    this.startWorkingTime = defaultStartWorkingTime,
    this.endWorkingTime = defaultEndWorkingTime,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  final SettingsModel settings;
  @override
  final CompanyDetailsModel? companyDetails;
  @override
  @JsonKey()
  final TimeOfDay startWorkingTime;
  @override
  @JsonKey()
  final TimeOfDay endWorkingTime;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SettingsState(loaderState: $loaderState, settings: $settings, companyDetails: $companyDetails, startWorkingTime: $startWorkingTime, endWorkingTime: $endWorkingTime, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.companyDetails, companyDetails) ||
                other.companyDetails == companyDetails) &&
            (identical(other.startWorkingTime, startWorkingTime) ||
                other.startWorkingTime == startWorkingTime) &&
            (identical(other.endWorkingTime, endWorkingTime) ||
                other.endWorkingTime == endWorkingTime) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    settings,
    companyDetails,
    startWorkingTime,
    endWorkingTime,
    errorMessage,
  );

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState({
    final LoaderState loaderState,
    required final SettingsModel settings,
    final CompanyDetailsModel? companyDetails,
    final TimeOfDay startWorkingTime,
    final TimeOfDay endWorkingTime,
    final String? errorMessage,
  }) = _$SettingsStateImpl;

  @override
  LoaderState get loaderState;
  @override
  SettingsModel get settings;
  @override
  CompanyDetailsModel? get companyDetails;
  @override
  TimeOfDay get startWorkingTime;
  @override
  TimeOfDay get endWorkingTime;
  @override
  String? get errorMessage;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
