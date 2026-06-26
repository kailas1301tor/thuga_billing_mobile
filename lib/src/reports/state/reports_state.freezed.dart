// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReportsState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  String get selectedRange =>
      throw _privateConstructorUsedError; // 'Today', 'Yesterday', 'Last 7 Days', 'This Month'
  ReportsDataModel? get data => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportsStateCopyWith<ReportsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportsStateCopyWith<$Res> {
  factory $ReportsStateCopyWith(
    ReportsState value,
    $Res Function(ReportsState) then,
  ) = _$ReportsStateCopyWithImpl<$Res, ReportsState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    String selectedRange,
    ReportsDataModel? data,
    String? errorMessage,
  });
}

/// @nodoc
class _$ReportsStateCopyWithImpl<$Res, $Val extends ReportsState>
    implements $ReportsStateCopyWith<$Res> {
  _$ReportsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? selectedRange = null,
    Object? data = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            selectedRange: null == selectedRange
                ? _value.selectedRange
                : selectedRange // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as ReportsDataModel?,
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
abstract class _$$ReportsStateImplCopyWith<$Res>
    implements $ReportsStateCopyWith<$Res> {
  factory _$$ReportsStateImplCopyWith(
    _$ReportsStateImpl value,
    $Res Function(_$ReportsStateImpl) then,
  ) = __$$ReportsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    String selectedRange,
    ReportsDataModel? data,
    String? errorMessage,
  });
}

/// @nodoc
class __$$ReportsStateImplCopyWithImpl<$Res>
    extends _$ReportsStateCopyWithImpl<$Res, _$ReportsStateImpl>
    implements _$$ReportsStateImplCopyWith<$Res> {
  __$$ReportsStateImplCopyWithImpl(
    _$ReportsStateImpl _value,
    $Res Function(_$ReportsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? selectedRange = null,
    Object? data = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ReportsStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        selectedRange: null == selectedRange
            ? _value.selectedRange
            : selectedRange // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as ReportsDataModel?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ReportsStateImpl implements _ReportsState {
  const _$ReportsStateImpl({
    this.loaderState = LoaderState.loaded,
    this.selectedRange = 'Today',
    this.data,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  @JsonKey()
  final String selectedRange;
  // 'Today', 'Yesterday', 'Last 7 Days', 'This Month'
  @override
  final ReportsDataModel? data;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ReportsState(loaderState: $loaderState, selectedRange: $selectedRange, data: $data, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportsStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.selectedRange, selectedRange) ||
                other.selectedRange == selectedRange) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, loaderState, selectedRange, data, errorMessage);

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportsStateImplCopyWith<_$ReportsStateImpl> get copyWith =>
      __$$ReportsStateImplCopyWithImpl<_$ReportsStateImpl>(this, _$identity);
}

abstract class _ReportsState implements ReportsState {
  const factory _ReportsState({
    final LoaderState loaderState,
    final String selectedRange,
    final ReportsDataModel? data,
    final String? errorMessage,
  }) = _$ReportsStateImpl;

  @override
  LoaderState get loaderState;
  @override
  String get selectedRange; // 'Today', 'Yesterday', 'Last 7 Days', 'This Month'
  @override
  ReportsDataModel? get data;
  @override
  String? get errorMessage;

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportsStateImplCopyWith<_$ReportsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
