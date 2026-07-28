// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_purchase_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatePurchaseState {

 List<PurchaseItemDraftModel> get items; DateTime get purchaseDate; DropdownProductModel? get selectedProduct; bool get isSaving;
/// Create a copy of CreatePurchaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePurchaseStateCopyWith<CreatePurchaseState> get copyWith => _$CreatePurchaseStateCopyWithImpl<CreatePurchaseState>(this as CreatePurchaseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePurchaseState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),purchaseDate,selectedProduct,isSaving);

@override
String toString() {
  return 'CreatePurchaseState(items: $items, purchaseDate: $purchaseDate, selectedProduct: $selectedProduct, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class $CreatePurchaseStateCopyWith<$Res>  {
  factory $CreatePurchaseStateCopyWith(CreatePurchaseState value, $Res Function(CreatePurchaseState) _then) = _$CreatePurchaseStateCopyWithImpl;
@useResult
$Res call({
 List<PurchaseItemDraftModel> items, DateTime purchaseDate, DropdownProductModel? selectedProduct, bool isSaving
});




}
/// @nodoc
class _$CreatePurchaseStateCopyWithImpl<$Res>
    implements $CreatePurchaseStateCopyWith<$Res> {
  _$CreatePurchaseStateCopyWithImpl(this._self, this._then);

  final CreatePurchaseState _self;
  final $Res Function(CreatePurchaseState) _then;

/// Create a copy of CreatePurchaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? purchaseDate = null,Object? selectedProduct = freezed,Object? isSaving = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PurchaseItemDraftModel>,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as DropdownProductModel?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePurchaseState].
extension CreatePurchaseStatePatterns on CreatePurchaseState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePurchaseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePurchaseState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePurchaseState value)  $default,){
final _that = this;
switch (_that) {
case _CreatePurchaseState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePurchaseState value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePurchaseState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PurchaseItemDraftModel> items,  DateTime purchaseDate,  DropdownProductModel? selectedProduct,  bool isSaving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePurchaseState() when $default != null:
return $default(_that.items,_that.purchaseDate,_that.selectedProduct,_that.isSaving);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PurchaseItemDraftModel> items,  DateTime purchaseDate,  DropdownProductModel? selectedProduct,  bool isSaving)  $default,) {final _that = this;
switch (_that) {
case _CreatePurchaseState():
return $default(_that.items,_that.purchaseDate,_that.selectedProduct,_that.isSaving);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PurchaseItemDraftModel> items,  DateTime purchaseDate,  DropdownProductModel? selectedProduct,  bool isSaving)?  $default,) {final _that = this;
switch (_that) {
case _CreatePurchaseState() when $default != null:
return $default(_that.items,_that.purchaseDate,_that.selectedProduct,_that.isSaving);case _:
  return null;

}
}

}

/// @nodoc


class _CreatePurchaseState implements CreatePurchaseState {
  const _CreatePurchaseState({final  List<PurchaseItemDraftModel> items = const [], required this.purchaseDate, this.selectedProduct, this.isSaving = false}): _items = items;
  

 final  List<PurchaseItemDraftModel> _items;
@override@JsonKey() List<PurchaseItemDraftModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  DateTime purchaseDate;
@override final  DropdownProductModel? selectedProduct;
@override@JsonKey() final  bool isSaving;

/// Create a copy of CreatePurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePurchaseStateCopyWith<_CreatePurchaseState> get copyWith => __$CreatePurchaseStateCopyWithImpl<_CreatePurchaseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePurchaseState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),purchaseDate,selectedProduct,isSaving);

@override
String toString() {
  return 'CreatePurchaseState(items: $items, purchaseDate: $purchaseDate, selectedProduct: $selectedProduct, isSaving: $isSaving)';
}


}

/// @nodoc
abstract mixin class _$CreatePurchaseStateCopyWith<$Res> implements $CreatePurchaseStateCopyWith<$Res> {
  factory _$CreatePurchaseStateCopyWith(_CreatePurchaseState value, $Res Function(_CreatePurchaseState) _then) = __$CreatePurchaseStateCopyWithImpl;
@override @useResult
$Res call({
 List<PurchaseItemDraftModel> items, DateTime purchaseDate, DropdownProductModel? selectedProduct, bool isSaving
});




}
/// @nodoc
class __$CreatePurchaseStateCopyWithImpl<$Res>
    implements _$CreatePurchaseStateCopyWith<$Res> {
  __$CreatePurchaseStateCopyWithImpl(this._self, this._then);

  final _CreatePurchaseState _self;
  final $Res Function(_CreatePurchaseState) _then;

/// Create a copy of CreatePurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? purchaseDate = null,Object? selectedProduct = freezed,Object? isSaving = null,}) {
  return _then(_CreatePurchaseState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PurchaseItemDraftModel>,purchaseDate: null == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as DropdownProductModel?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
