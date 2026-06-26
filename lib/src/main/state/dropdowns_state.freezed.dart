// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropdowns_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DropdownsState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  DropdownsDataModel get data => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of DropdownsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropdownsStateCopyWith<DropdownsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropdownsStateCopyWith<$Res> {
  factory $DropdownsStateCopyWith(
    DropdownsState value,
    $Res Function(DropdownsState) then,
  ) = _$DropdownsStateCopyWithImpl<$Res, DropdownsState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    DropdownsDataModel data,
    String? errorMessage,
  });
}

/// @nodoc
class _$DropdownsStateCopyWithImpl<$Res, $Val extends DropdownsState>
    implements $DropdownsStateCopyWith<$Res> {
  _$DropdownsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropdownsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? data = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as DropdownsDataModel,
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
abstract class _$$DropdownsStateImplCopyWith<$Res>
    implements $DropdownsStateCopyWith<$Res> {
  factory _$$DropdownsStateImplCopyWith(
    _$DropdownsStateImpl value,
    $Res Function(_$DropdownsStateImpl) then,
  ) = __$$DropdownsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    DropdownsDataModel data,
    String? errorMessage,
  });
}

/// @nodoc
class __$$DropdownsStateImplCopyWithImpl<$Res>
    extends _$DropdownsStateCopyWithImpl<$Res, _$DropdownsStateImpl>
    implements _$$DropdownsStateImplCopyWith<$Res> {
  __$$DropdownsStateImplCopyWithImpl(
    _$DropdownsStateImpl _value,
    $Res Function(_$DropdownsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropdownsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? data = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$DropdownsStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as DropdownsDataModel,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DropdownsStateImpl implements _DropdownsState {
  const _$DropdownsStateImpl({
    this.loaderState = LoaderState.loading,
    this.data = const DropdownsDataModel(),
    this.errorMessage,
  });

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  @JsonKey()
  final DropdownsDataModel data;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'DropdownsState(loaderState: $loaderState, data: $data, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropdownsStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loaderState, data, errorMessage);

  /// Create a copy of DropdownsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropdownsStateImplCopyWith<_$DropdownsStateImpl> get copyWith =>
      __$$DropdownsStateImplCopyWithImpl<_$DropdownsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DropdownsState implements DropdownsState {
  const factory _DropdownsState({
    final LoaderState loaderState,
    final DropdownsDataModel data,
    final String? errorMessage,
  }) = _$DropdownsStateImpl;

  @override
  LoaderState get loaderState;
  @override
  DropdownsDataModel get data;
  @override
  String? get errorMessage;

  /// Create a copy of DropdownsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropdownsStateImplCopyWith<_$DropdownsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
