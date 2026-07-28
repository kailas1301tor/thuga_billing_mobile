// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchases_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchasesState {

 LoaderState get loaderState; List<PurchaseModel> get purchases; DateTime get startDate; DateTime get endDate; String? get errorMessage;
/// Create a copy of PurchasesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchasesStateCopyWith<PurchasesState> get copyWith => _$PurchasesStateCopyWithImpl<PurchasesState>(this as PurchasesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchasesState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&const DeepCollectionEquality().equals(other.purchases, purchases)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,const DeepCollectionEquality().hash(purchases),startDate,endDate,errorMessage);

@override
String toString() {
  return 'PurchasesState(loaderState: $loaderState, purchases: $purchases, startDate: $startDate, endDate: $endDate, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PurchasesStateCopyWith<$Res>  {
  factory $PurchasesStateCopyWith(PurchasesState value, $Res Function(PurchasesState) _then) = _$PurchasesStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, List<PurchaseModel> purchases, DateTime startDate, DateTime endDate, String? errorMessage
});




}
/// @nodoc
class _$PurchasesStateCopyWithImpl<$Res>
    implements $PurchasesStateCopyWith<$Res> {
  _$PurchasesStateCopyWithImpl(this._self, this._then);

  final PurchasesState _self;
  final $Res Function(PurchasesState) _then;

/// Create a copy of PurchasesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? purchases = null,Object? startDate = null,Object? endDate = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,purchases: null == purchases ? _self.purchases : purchases // ignore: cast_nullable_to_non_nullable
as List<PurchaseModel>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchasesState].
extension PurchasesStatePatterns on PurchasesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchasesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchasesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchasesState value)  $default,){
final _that = this;
switch (_that) {
case _PurchasesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchasesState value)?  $default,){
final _that = this;
switch (_that) {
case _PurchasesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  List<PurchaseModel> purchases,  DateTime startDate,  DateTime endDate,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchasesState() when $default != null:
return $default(_that.loaderState,_that.purchases,_that.startDate,_that.endDate,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  List<PurchaseModel> purchases,  DateTime startDate,  DateTime endDate,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PurchasesState():
return $default(_that.loaderState,_that.purchases,_that.startDate,_that.endDate,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  List<PurchaseModel> purchases,  DateTime startDate,  DateTime endDate,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PurchasesState() when $default != null:
return $default(_that.loaderState,_that.purchases,_that.startDate,_that.endDate,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PurchasesState implements PurchasesState {
  const _PurchasesState({this.loaderState = LoaderState.loading, final  List<PurchaseModel> purchases = const [], required this.startDate, required this.endDate, this.errorMessage}): _purchases = purchases;
  

@override@JsonKey() final  LoaderState loaderState;
 final  List<PurchaseModel> _purchases;
@override@JsonKey() List<PurchaseModel> get purchases {
  if (_purchases is EqualUnmodifiableListView) return _purchases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_purchases);
}

@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String? errorMessage;

/// Create a copy of PurchasesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchasesStateCopyWith<_PurchasesState> get copyWith => __$PurchasesStateCopyWithImpl<_PurchasesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchasesState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&const DeepCollectionEquality().equals(other._purchases, _purchases)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,const DeepCollectionEquality().hash(_purchases),startDate,endDate,errorMessage);

@override
String toString() {
  return 'PurchasesState(loaderState: $loaderState, purchases: $purchases, startDate: $startDate, endDate: $endDate, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PurchasesStateCopyWith<$Res> implements $PurchasesStateCopyWith<$Res> {
  factory _$PurchasesStateCopyWith(_PurchasesState value, $Res Function(_PurchasesState) _then) = __$PurchasesStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, List<PurchaseModel> purchases, DateTime startDate, DateTime endDate, String? errorMessage
});




}
/// @nodoc
class __$PurchasesStateCopyWithImpl<$Res>
    implements _$PurchasesStateCopyWith<$Res> {
  __$PurchasesStateCopyWithImpl(this._self, this._then);

  final _PurchasesState _self;
  final $Res Function(_PurchasesState) _then;

/// Create a copy of PurchasesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? purchases = null,Object? startDate = null,Object? endDate = null,Object? errorMessage = freezed,}) {
  return _then(_PurchasesState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,purchases: null == purchases ? _self._purchases : purchases // ignore: cast_nullable_to_non_nullable
as List<PurchaseModel>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
