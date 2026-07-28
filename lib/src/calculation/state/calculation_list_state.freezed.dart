// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalculationListState {

 LoaderState get loaderState; List<CalculationBillSummaryModel> get bills; List<CalculationCategoryModel> get categories; String? get errorMessage;
/// Create a copy of CalculationListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculationListStateCopyWith<CalculationListState> get copyWith => _$CalculationListStateCopyWithImpl<CalculationListState>(this as CalculationListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculationListState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&const DeepCollectionEquality().equals(other.bills, bills)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,const DeepCollectionEquality().hash(bills),const DeepCollectionEquality().hash(categories),errorMessage);

@override
String toString() {
  return 'CalculationListState(loaderState: $loaderState, bills: $bills, categories: $categories, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CalculationListStateCopyWith<$Res>  {
  factory $CalculationListStateCopyWith(CalculationListState value, $Res Function(CalculationListState) _then) = _$CalculationListStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, List<CalculationBillSummaryModel> bills, List<CalculationCategoryModel> categories, String? errorMessage
});




}
/// @nodoc
class _$CalculationListStateCopyWithImpl<$Res>
    implements $CalculationListStateCopyWith<$Res> {
  _$CalculationListStateCopyWithImpl(this._self, this._then);

  final CalculationListState _self;
  final $Res Function(CalculationListState) _then;

/// Create a copy of CalculationListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? bills = null,Object? categories = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,bills: null == bills ? _self.bills : bills // ignore: cast_nullable_to_non_nullable
as List<CalculationBillSummaryModel>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CalculationCategoryModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculationListState].
extension CalculationListStatePatterns on CalculationListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculationListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculationListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculationListState value)  $default,){
final _that = this;
switch (_that) {
case _CalculationListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculationListState value)?  $default,){
final _that = this;
switch (_that) {
case _CalculationListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  List<CalculationBillSummaryModel> bills,  List<CalculationCategoryModel> categories,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculationListState() when $default != null:
return $default(_that.loaderState,_that.bills,_that.categories,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  List<CalculationBillSummaryModel> bills,  List<CalculationCategoryModel> categories,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CalculationListState():
return $default(_that.loaderState,_that.bills,_that.categories,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  List<CalculationBillSummaryModel> bills,  List<CalculationCategoryModel> categories,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CalculationListState() when $default != null:
return $default(_that.loaderState,_that.bills,_that.categories,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CalculationListState implements CalculationListState {
  const _CalculationListState({this.loaderState = LoaderState.loading, final  List<CalculationBillSummaryModel> bills = const [], final  List<CalculationCategoryModel> categories = const [], this.errorMessage}): _bills = bills,_categories = categories;
  

@override@JsonKey() final  LoaderState loaderState;
 final  List<CalculationBillSummaryModel> _bills;
@override@JsonKey() List<CalculationBillSummaryModel> get bills {
  if (_bills is EqualUnmodifiableListView) return _bills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bills);
}

 final  List<CalculationCategoryModel> _categories;
@override@JsonKey() List<CalculationCategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  String? errorMessage;

/// Create a copy of CalculationListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculationListStateCopyWith<_CalculationListState> get copyWith => __$CalculationListStateCopyWithImpl<_CalculationListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculationListState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&const DeepCollectionEquality().equals(other._bills, _bills)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,const DeepCollectionEquality().hash(_bills),const DeepCollectionEquality().hash(_categories),errorMessage);

@override
String toString() {
  return 'CalculationListState(loaderState: $loaderState, bills: $bills, categories: $categories, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CalculationListStateCopyWith<$Res> implements $CalculationListStateCopyWith<$Res> {
  factory _$CalculationListStateCopyWith(_CalculationListState value, $Res Function(_CalculationListState) _then) = __$CalculationListStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, List<CalculationBillSummaryModel> bills, List<CalculationCategoryModel> categories, String? errorMessage
});




}
/// @nodoc
class __$CalculationListStateCopyWithImpl<$Res>
    implements _$CalculationListStateCopyWith<$Res> {
  __$CalculationListStateCopyWithImpl(this._self, this._then);

  final _CalculationListState _self;
  final $Res Function(_CalculationListState) _then;

/// Create a copy of CalculationListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? bills = null,Object? categories = null,Object? errorMessage = freezed,}) {
  return _then(_CalculationListState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,bills: null == bills ? _self._bills : bills // ignore: cast_nullable_to_non_nullable
as List<CalculationBillSummaryModel>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CalculationCategoryModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
