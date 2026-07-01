// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchases_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PurchasesState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  List<PurchaseModel> get purchases => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of PurchasesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchasesStateCopyWith<PurchasesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasesStateCopyWith<$Res> {
  factory $PurchasesStateCopyWith(
    PurchasesState value,
    $Res Function(PurchasesState) then,
  ) = _$PurchasesStateCopyWithImpl<$Res, PurchasesState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    List<PurchaseModel> purchases,
    DateTime startDate,
    DateTime endDate,
    String? errorMessage,
  });
}

/// @nodoc
class _$PurchasesStateCopyWithImpl<$Res, $Val extends PurchasesState>
    implements $PurchasesStateCopyWith<$Res> {
  _$PurchasesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchasesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? purchases = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            purchases: null == purchases
                ? _value.purchases
                : purchases // ignore: cast_nullable_to_non_nullable
                      as List<PurchaseModel>,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$PurchasesStateImplCopyWith<$Res>
    implements $PurchasesStateCopyWith<$Res> {
  factory _$$PurchasesStateImplCopyWith(
    _$PurchasesStateImpl value,
    $Res Function(_$PurchasesStateImpl) then,
  ) = __$$PurchasesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    List<PurchaseModel> purchases,
    DateTime startDate,
    DateTime endDate,
    String? errorMessage,
  });
}

/// @nodoc
class __$$PurchasesStateImplCopyWithImpl<$Res>
    extends _$PurchasesStateCopyWithImpl<$Res, _$PurchasesStateImpl>
    implements _$$PurchasesStateImplCopyWith<$Res> {
  __$$PurchasesStateImplCopyWithImpl(
    _$PurchasesStateImpl _value,
    $Res Function(_$PurchasesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchasesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? purchases = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$PurchasesStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        purchases: null == purchases
            ? _value._purchases
            : purchases // ignore: cast_nullable_to_non_nullable
                  as List<PurchaseModel>,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PurchasesStateImpl implements _PurchasesState {
  const _$PurchasesStateImpl({
    this.loaderState = LoaderState.loading,
    final List<PurchaseModel> purchases = const [],
    required this.startDate,
    required this.endDate,
    this.errorMessage,
  }) : _purchases = purchases;

  @override
  @JsonKey()
  final LoaderState loaderState;
  final List<PurchaseModel> _purchases;
  @override
  @JsonKey()
  List<PurchaseModel> get purchases {
    if (_purchases is EqualUnmodifiableListView) return _purchases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_purchases);
  }

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PurchasesState(loaderState: $loaderState, purchases: $purchases, startDate: $startDate, endDate: $endDate, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasesStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            const DeepCollectionEquality().equals(
              other._purchases,
              _purchases,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    const DeepCollectionEquality().hash(_purchases),
    startDate,
    endDate,
    errorMessage,
  );

  /// Create a copy of PurchasesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasesStateImplCopyWith<_$PurchasesStateImpl> get copyWith =>
      __$$PurchasesStateImplCopyWithImpl<_$PurchasesStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PurchasesState implements PurchasesState {
  const factory _PurchasesState({
    final LoaderState loaderState,
    final List<PurchaseModel> purchases,
    required final DateTime startDate,
    required final DateTime endDate,
    final String? errorMessage,
  }) = _$PurchasesStateImpl;

  @override
  LoaderState get loaderState;
  @override
  List<PurchaseModel> get purchases;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String? get errorMessage;

  /// Create a copy of PurchasesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchasesStateImplCopyWith<_$PurchasesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
