// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalculationDetailState {

 LoaderState get loaderState; CalculationBillModel? get bill; List<CalculationCategoryModel> get categories; double get grandTotal; String? get errorMessage;
/// Create a copy of CalculationDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculationDetailStateCopyWith<CalculationDetailState> get copyWith => _$CalculationDetailStateCopyWithImpl<CalculationDetailState>(this as CalculationDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculationDetailState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.bill, bill) || other.bill == bill)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.grandTotal, grandTotal) || other.grandTotal == grandTotal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,bill,const DeepCollectionEquality().hash(categories),grandTotal,errorMessage);

@override
String toString() {
  return 'CalculationDetailState(loaderState: $loaderState, bill: $bill, categories: $categories, grandTotal: $grandTotal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CalculationDetailStateCopyWith<$Res>  {
  factory $CalculationDetailStateCopyWith(CalculationDetailState value, $Res Function(CalculationDetailState) _then) = _$CalculationDetailStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, CalculationBillModel? bill, List<CalculationCategoryModel> categories, double grandTotal, String? errorMessage
});




}
/// @nodoc
class _$CalculationDetailStateCopyWithImpl<$Res>
    implements $CalculationDetailStateCopyWith<$Res> {
  _$CalculationDetailStateCopyWithImpl(this._self, this._then);

  final CalculationDetailState _self;
  final $Res Function(CalculationDetailState) _then;

/// Create a copy of CalculationDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? bill = freezed,Object? categories = null,Object? grandTotal = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,bill: freezed == bill ? _self.bill : bill // ignore: cast_nullable_to_non_nullable
as CalculationBillModel?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CalculationCategoryModel>,grandTotal: null == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculationDetailState].
extension CalculationDetailStatePatterns on CalculationDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculationDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculationDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculationDetailState value)  $default,){
final _that = this;
switch (_that) {
case _CalculationDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculationDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _CalculationDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  CalculationBillModel? bill,  List<CalculationCategoryModel> categories,  double grandTotal,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculationDetailState() when $default != null:
return $default(_that.loaderState,_that.bill,_that.categories,_that.grandTotal,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  CalculationBillModel? bill,  List<CalculationCategoryModel> categories,  double grandTotal,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CalculationDetailState():
return $default(_that.loaderState,_that.bill,_that.categories,_that.grandTotal,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  CalculationBillModel? bill,  List<CalculationCategoryModel> categories,  double grandTotal,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CalculationDetailState() when $default != null:
return $default(_that.loaderState,_that.bill,_that.categories,_that.grandTotal,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CalculationDetailState implements CalculationDetailState {
  const _CalculationDetailState({this.loaderState = LoaderState.loading, this.bill, final  List<CalculationCategoryModel> categories = const [], this.grandTotal = 0.0, this.errorMessage}): _categories = categories;
  

@override@JsonKey() final  LoaderState loaderState;
@override final  CalculationBillModel? bill;
 final  List<CalculationCategoryModel> _categories;
@override@JsonKey() List<CalculationCategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  double grandTotal;
@override final  String? errorMessage;

/// Create a copy of CalculationDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculationDetailStateCopyWith<_CalculationDetailState> get copyWith => __$CalculationDetailStateCopyWithImpl<_CalculationDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculationDetailState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.bill, bill) || other.bill == bill)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.grandTotal, grandTotal) || other.grandTotal == grandTotal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,bill,const DeepCollectionEquality().hash(_categories),grandTotal,errorMessage);

@override
String toString() {
  return 'CalculationDetailState(loaderState: $loaderState, bill: $bill, categories: $categories, grandTotal: $grandTotal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CalculationDetailStateCopyWith<$Res> implements $CalculationDetailStateCopyWith<$Res> {
  factory _$CalculationDetailStateCopyWith(_CalculationDetailState value, $Res Function(_CalculationDetailState) _then) = __$CalculationDetailStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, CalculationBillModel? bill, List<CalculationCategoryModel> categories, double grandTotal, String? errorMessage
});




}
/// @nodoc
class __$CalculationDetailStateCopyWithImpl<$Res>
    implements _$CalculationDetailStateCopyWith<$Res> {
  __$CalculationDetailStateCopyWithImpl(this._self, this._then);

  final _CalculationDetailState _self;
  final $Res Function(_CalculationDetailState) _then;

/// Create a copy of CalculationDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? bill = freezed,Object? categories = null,Object? grandTotal = null,Object? errorMessage = freezed,}) {
  return _then(_CalculationDetailState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,bill: freezed == bill ? _self.bill : bill // ignore: cast_nullable_to_non_nullable
as CalculationBillModel?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CalculationCategoryModel>,grandTotal: null == grandTotal ? _self.grandTotal : grandTotal // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
