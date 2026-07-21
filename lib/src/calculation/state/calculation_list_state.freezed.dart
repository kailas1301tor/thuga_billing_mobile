// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CalculationListState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  List<CalculationBillSummaryModel> get bills =>
      throw _privateConstructorUsedError;
  List<CalculationCategoryModel> get categories =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CalculationListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalculationListStateCopyWith<CalculationListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculationListStateCopyWith<$Res> {
  factory $CalculationListStateCopyWith(
    CalculationListState value,
    $Res Function(CalculationListState) then,
  ) = _$CalculationListStateCopyWithImpl<$Res, CalculationListState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    List<CalculationBillSummaryModel> bills,
    List<CalculationCategoryModel> categories,
    String? errorMessage,
  });
}

/// @nodoc
class _$CalculationListStateCopyWithImpl<
  $Res,
  $Val extends CalculationListState
>
    implements $CalculationListStateCopyWith<$Res> {
  _$CalculationListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalculationListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? bills = null,
    Object? categories = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            bills: null == bills
                ? _value.bills
                : bills // ignore: cast_nullable_to_non_nullable
                      as List<CalculationBillSummaryModel>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<CalculationCategoryModel>,
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
abstract class _$$CalculationListStateImplCopyWith<$Res>
    implements $CalculationListStateCopyWith<$Res> {
  factory _$$CalculationListStateImplCopyWith(
    _$CalculationListStateImpl value,
    $Res Function(_$CalculationListStateImpl) then,
  ) = __$$CalculationListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    List<CalculationBillSummaryModel> bills,
    List<CalculationCategoryModel> categories,
    String? errorMessage,
  });
}

/// @nodoc
class __$$CalculationListStateImplCopyWithImpl<$Res>
    extends _$CalculationListStateCopyWithImpl<$Res, _$CalculationListStateImpl>
    implements _$$CalculationListStateImplCopyWith<$Res> {
  __$$CalculationListStateImplCopyWithImpl(
    _$CalculationListStateImpl _value,
    $Res Function(_$CalculationListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalculationListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? bills = null,
    Object? categories = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CalculationListStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        bills: null == bills
            ? _value._bills
            : bills // ignore: cast_nullable_to_non_nullable
                  as List<CalculationBillSummaryModel>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<CalculationCategoryModel>,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CalculationListStateImpl implements _CalculationListState {
  const _$CalculationListStateImpl({
    this.loaderState = LoaderState.loading,
    final List<CalculationBillSummaryModel> bills = const [],
    final List<CalculationCategoryModel> categories = const [],
    this.errorMessage,
  }) : _bills = bills,
       _categories = categories;

  @override
  @JsonKey()
  final LoaderState loaderState;
  final List<CalculationBillSummaryModel> _bills;
  @override
  @JsonKey()
  List<CalculationBillSummaryModel> get bills {
    if (_bills is EqualUnmodifiableListView) return _bills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bills);
  }

  final List<CalculationCategoryModel> _categories;
  @override
  @JsonKey()
  List<CalculationCategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CalculationListState(loaderState: $loaderState, bills: $bills, categories: $categories, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculationListStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            const DeepCollectionEquality().equals(other._bills, _bills) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    const DeepCollectionEquality().hash(_bills),
    const DeepCollectionEquality().hash(_categories),
    errorMessage,
  );

  /// Create a copy of CalculationListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculationListStateImplCopyWith<_$CalculationListStateImpl>
  get copyWith =>
      __$$CalculationListStateImplCopyWithImpl<_$CalculationListStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CalculationListState implements CalculationListState {
  const factory _CalculationListState({
    final LoaderState loaderState,
    final List<CalculationBillSummaryModel> bills,
    final List<CalculationCategoryModel> categories,
    final String? errorMessage,
  }) = _$CalculationListStateImpl;

  @override
  LoaderState get loaderState;
  @override
  List<CalculationBillSummaryModel> get bills;
  @override
  List<CalculationCategoryModel> get categories;
  @override
  String? get errorMessage;

  /// Create a copy of CalculationListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalculationListStateImplCopyWith<_$CalculationListStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
