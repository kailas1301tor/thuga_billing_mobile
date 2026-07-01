// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_purchase_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CreatePurchaseState {
  List<PurchaseItemDraftModel> get items => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  DropdownProductModel? get selectedProduct =>
      throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;

  /// Create a copy of CreatePurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePurchaseStateCopyWith<CreatePurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePurchaseStateCopyWith<$Res> {
  factory $CreatePurchaseStateCopyWith(
    CreatePurchaseState value,
    $Res Function(CreatePurchaseState) then,
  ) = _$CreatePurchaseStateCopyWithImpl<$Res, CreatePurchaseState>;
  @useResult
  $Res call({
    List<PurchaseItemDraftModel> items,
    DateTime purchaseDate,
    DropdownProductModel? selectedProduct,
    bool isSaving,
  });
}

/// @nodoc
class _$CreatePurchaseStateCopyWithImpl<$Res, $Val extends CreatePurchaseState>
    implements $CreatePurchaseStateCopyWith<$Res> {
  _$CreatePurchaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? purchaseDate = null,
    Object? selectedProduct = freezed,
    Object? isSaving = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<PurchaseItemDraftModel>,
            purchaseDate: null == purchaseDate
                ? _value.purchaseDate
                : purchaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            selectedProduct: freezed == selectedProduct
                ? _value.selectedProduct
                : selectedProduct // ignore: cast_nullable_to_non_nullable
                      as DropdownProductModel?,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatePurchaseStateImplCopyWith<$Res>
    implements $CreatePurchaseStateCopyWith<$Res> {
  factory _$$CreatePurchaseStateImplCopyWith(
    _$CreatePurchaseStateImpl value,
    $Res Function(_$CreatePurchaseStateImpl) then,
  ) = __$$CreatePurchaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PurchaseItemDraftModel> items,
    DateTime purchaseDate,
    DropdownProductModel? selectedProduct,
    bool isSaving,
  });
}

/// @nodoc
class __$$CreatePurchaseStateImplCopyWithImpl<$Res>
    extends _$CreatePurchaseStateCopyWithImpl<$Res, _$CreatePurchaseStateImpl>
    implements _$$CreatePurchaseStateImplCopyWith<$Res> {
  __$$CreatePurchaseStateImplCopyWithImpl(
    _$CreatePurchaseStateImpl _value,
    $Res Function(_$CreatePurchaseStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatePurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? purchaseDate = null,
    Object? selectedProduct = freezed,
    Object? isSaving = null,
  }) {
    return _then(
      _$CreatePurchaseStateImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<PurchaseItemDraftModel>,
        purchaseDate: null == purchaseDate
            ? _value.purchaseDate
            : purchaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        selectedProduct: freezed == selectedProduct
            ? _value.selectedProduct
            : selectedProduct // ignore: cast_nullable_to_non_nullable
                  as DropdownProductModel?,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$CreatePurchaseStateImpl implements _CreatePurchaseState {
  const _$CreatePurchaseStateImpl({
    final List<PurchaseItemDraftModel> items = const [],
    required this.purchaseDate,
    this.selectedProduct,
    this.isSaving = false,
  }) : _items = items;

  final List<PurchaseItemDraftModel> _items;
  @override
  @JsonKey()
  List<PurchaseItemDraftModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime purchaseDate;
  @override
  final DropdownProductModel? selectedProduct;
  @override
  @JsonKey()
  final bool isSaving;

  @override
  String toString() {
    return 'CreatePurchaseState(items: $items, purchaseDate: $purchaseDate, selectedProduct: $selectedProduct, isSaving: $isSaving)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePurchaseStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.selectedProduct, selectedProduct) ||
                other.selectedProduct == selectedProduct) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    purchaseDate,
    selectedProduct,
    isSaving,
  );

  /// Create a copy of CreatePurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePurchaseStateImplCopyWith<_$CreatePurchaseStateImpl> get copyWith =>
      __$$CreatePurchaseStateImplCopyWithImpl<_$CreatePurchaseStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CreatePurchaseState implements CreatePurchaseState {
  const factory _CreatePurchaseState({
    final List<PurchaseItemDraftModel> items,
    required final DateTime purchaseDate,
    final DropdownProductModel? selectedProduct,
    final bool isSaving,
  }) = _$CreatePurchaseStateImpl;

  @override
  List<PurchaseItemDraftModel> get items;
  @override
  DateTime get purchaseDate;
  @override
  DropdownProductModel? get selectedProduct;
  @override
  bool get isSaving;

  /// Create a copy of CreatePurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePurchaseStateImplCopyWith<_$CreatePurchaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
