// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {

 LoaderState get loaderState; DateTime get startDate; DateTime get endDate; String? get selectedPreset; ReportsDataModel? get data; String? get errorMessage;
/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsStateCopyWith<ReportsState> get copyWith => _$ReportsStateCopyWithImpl<ReportsState>(this as ReportsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.selectedPreset, selectedPreset) || other.selectedPreset == selectedPreset)&&(identical(other.data, data) || other.data == data)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,startDate,endDate,selectedPreset,data,errorMessage);

@override
String toString() {
  return 'ReportsState(loaderState: $loaderState, startDate: $startDate, endDate: $endDate, selectedPreset: $selectedPreset, data: $data, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ReportsStateCopyWith<$Res>  {
  factory $ReportsStateCopyWith(ReportsState value, $Res Function(ReportsState) _then) = _$ReportsStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, DateTime startDate, DateTime endDate, String? selectedPreset, ReportsDataModel? data, String? errorMessage
});




}
/// @nodoc
class _$ReportsStateCopyWithImpl<$Res>
    implements $ReportsStateCopyWith<$Res> {
  _$ReportsStateCopyWithImpl(this._self, this._then);

  final ReportsState _self;
  final $Res Function(ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? startDate = null,Object? endDate = null,Object? selectedPreset = freezed,Object? data = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,selectedPreset: freezed == selectedPreset ? _self.selectedPreset : selectedPreset // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ReportsDataModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsState value)  $default,){
final _that = this;
switch (_that) {
case _ReportsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  DateTime startDate,  DateTime endDate,  String? selectedPreset,  ReportsDataModel? data,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.loaderState,_that.startDate,_that.endDate,_that.selectedPreset,_that.data,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  DateTime startDate,  DateTime endDate,  String? selectedPreset,  ReportsDataModel? data,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReportsState():
return $default(_that.loaderState,_that.startDate,_that.endDate,_that.selectedPreset,_that.data,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  DateTime startDate,  DateTime endDate,  String? selectedPreset,  ReportsDataModel? data,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReportsState() when $default != null:
return $default(_that.loaderState,_that.startDate,_that.endDate,_that.selectedPreset,_that.data,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsState implements ReportsState {
  const _ReportsState({this.loaderState = LoaderState.loaded, required this.startDate, required this.endDate, this.selectedPreset = 'Today', this.data, this.errorMessage});
  

@override@JsonKey() final  LoaderState loaderState;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override@JsonKey() final  String? selectedPreset;
@override final  ReportsDataModel? data;
@override final  String? errorMessage;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsStateCopyWith<_ReportsState> get copyWith => __$ReportsStateCopyWithImpl<_ReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.selectedPreset, selectedPreset) || other.selectedPreset == selectedPreset)&&(identical(other.data, data) || other.data == data)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,startDate,endDate,selectedPreset,data,errorMessage);

@override
String toString() {
  return 'ReportsState(loaderState: $loaderState, startDate: $startDate, endDate: $endDate, selectedPreset: $selectedPreset, data: $data, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReportsStateCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory _$ReportsStateCopyWith(_ReportsState value, $Res Function(_ReportsState) _then) = __$ReportsStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, DateTime startDate, DateTime endDate, String? selectedPreset, ReportsDataModel? data, String? errorMessage
});




}
/// @nodoc
class __$ReportsStateCopyWithImpl<$Res>
    implements _$ReportsStateCopyWith<$Res> {
  __$ReportsStateCopyWithImpl(this._self, this._then);

  final _ReportsState _self;
  final $Res Function(_ReportsState) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? startDate = null,Object? endDate = null,Object? selectedPreset = freezed,Object? data = freezed,Object? errorMessage = freezed,}) {
  return _then(_ReportsState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,selectedPreset: freezed == selectedPreset ? _self.selectedPreset : selectedPreset // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ReportsDataModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
