// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CalculationDetailState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  CalculationBillModel? get bill => throw _privateConstructorUsedError;
  List<CalculationCategoryModel> get categories =>
      throw _privateConstructorUsedError;
  double get grandTotal => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CalculationDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalculationDetailStateCopyWith<CalculationDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculationDetailStateCopyWith<$Res> {
  factory $CalculationDetailStateCopyWith(
    CalculationDetailState value,
    $Res Function(CalculationDetailState) then,
  ) = _$CalculationDetailStateCopyWithImpl<$Res, CalculationDetailState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    CalculationBillModel? bill,
    List<CalculationCategoryModel> categories,
    double grandTotal,
    String? errorMessage,
  });
}

/// @nodoc
class _$CalculationDetailStateCopyWithImpl<
  $Res,
  $Val extends CalculationDetailState
>
    implements $CalculationDetailStateCopyWith<$Res> {
  _$CalculationDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalculationDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? bill = freezed,
    Object? categories = null,
    Object? grandTotal = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            bill: freezed == bill
                ? _value.bill
                : bill // ignore: cast_nullable_to_non_nullable
                      as CalculationBillModel?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<CalculationCategoryModel>,
            grandTotal: null == grandTotal
                ? _value.grandTotal
                : grandTotal // ignore: cast_nullable_to_non_nullable
                      as double,
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
abstract class _$$CalculationDetailStateImplCopyWith<$Res>
    implements $CalculationDetailStateCopyWith<$Res> {
  factory _$$CalculationDetailStateImplCopyWith(
    _$CalculationDetailStateImpl value,
    $Res Function(_$CalculationDetailStateImpl) then,
  ) = __$$CalculationDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    CalculationBillModel? bill,
    List<CalculationCategoryModel> categories,
    double grandTotal,
    String? errorMessage,
  });
}

/// @nodoc
class __$$CalculationDetailStateImplCopyWithImpl<$Res>
    extends
        _$CalculationDetailStateCopyWithImpl<$Res, _$CalculationDetailStateImpl>
    implements _$$CalculationDetailStateImplCopyWith<$Res> {
  __$$CalculationDetailStateImplCopyWithImpl(
    _$CalculationDetailStateImpl _value,
    $Res Function(_$CalculationDetailStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalculationDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? bill = freezed,
    Object? categories = null,
    Object? grandTotal = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CalculationDetailStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        bill: freezed == bill
            ? _value.bill
            : bill // ignore: cast_nullable_to_non_nullable
                  as CalculationBillModel?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<CalculationCategoryModel>,
        grandTotal: null == grandTotal
            ? _value.grandTotal
            : grandTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CalculationDetailStateImpl implements _CalculationDetailState {
  const _$CalculationDetailStateImpl({
    this.loaderState = LoaderState.loading,
    this.bill,
    final List<CalculationCategoryModel> categories = const [],
    this.grandTotal = 0.0,
    this.errorMessage,
  }) : _categories = categories;

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  final CalculationBillModel? bill;
  final List<CalculationCategoryModel> _categories;
  @override
  @JsonKey()
  List<CalculationCategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final double grandTotal;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CalculationDetailState(loaderState: $loaderState, bill: $bill, categories: $categories, grandTotal: $grandTotal, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculationDetailStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.bill, bill) || other.bill == bill) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    bill,
    const DeepCollectionEquality().hash(_categories),
    grandTotal,
    errorMessage,
  );

  /// Create a copy of CalculationDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculationDetailStateImplCopyWith<_$CalculationDetailStateImpl>
  get copyWith =>
      __$$CalculationDetailStateImplCopyWithImpl<_$CalculationDetailStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CalculationDetailState implements CalculationDetailState {
  const factory _CalculationDetailState({
    final LoaderState loaderState,
    final CalculationBillModel? bill,
    final List<CalculationCategoryModel> categories,
    final double grandTotal,
    final String? errorMessage,
  }) = _$CalculationDetailStateImpl;

  @override
  LoaderState get loaderState;
  @override
  CalculationBillModel? get bill;
  @override
  List<CalculationCategoryModel> get categories;
  @override
  double get grandTotal;
  @override
  String? get errorMessage;

  /// Create a copy of CalculationDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalculationDetailStateImplCopyWith<_$CalculationDetailStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
