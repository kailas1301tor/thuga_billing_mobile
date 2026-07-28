// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropdowns_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DropdownsState {

 LoaderState get loaderState; DropdownsDataModel get data; String? get errorMessage;
/// Create a copy of DropdownsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DropdownsStateCopyWith<DropdownsState> get copyWith => _$DropdownsStateCopyWithImpl<DropdownsState>(this as DropdownsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DropdownsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.data, data) || other.data == data)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,data,errorMessage);

@override
String toString() {
  return 'DropdownsState(loaderState: $loaderState, data: $data, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DropdownsStateCopyWith<$Res>  {
  factory $DropdownsStateCopyWith(DropdownsState value, $Res Function(DropdownsState) _then) = _$DropdownsStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, DropdownsDataModel data, String? errorMessage
});




}
/// @nodoc
class _$DropdownsStateCopyWithImpl<$Res>
    implements $DropdownsStateCopyWith<$Res> {
  _$DropdownsStateCopyWithImpl(this._self, this._then);

  final DropdownsState _self;
  final $Res Function(DropdownsState) _then;

/// Create a copy of DropdownsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? data = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DropdownsDataModel,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DropdownsState].
extension DropdownsStatePatterns on DropdownsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DropdownsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DropdownsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DropdownsState value)  $default,){
final _that = this;
switch (_that) {
case _DropdownsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DropdownsState value)?  $default,){
final _that = this;
switch (_that) {
case _DropdownsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  DropdownsDataModel data,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DropdownsState() when $default != null:
return $default(_that.loaderState,_that.data,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  DropdownsDataModel data,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DropdownsState():
return $default(_that.loaderState,_that.data,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  DropdownsDataModel data,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DropdownsState() when $default != null:
return $default(_that.loaderState,_that.data,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DropdownsState implements DropdownsState {
  const _DropdownsState({this.loaderState = LoaderState.loading, this.data = const DropdownsDataModel(), this.errorMessage});
  

@override@JsonKey() final  LoaderState loaderState;
@override@JsonKey() final  DropdownsDataModel data;
@override final  String? errorMessage;

/// Create a copy of DropdownsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DropdownsStateCopyWith<_DropdownsState> get copyWith => __$DropdownsStateCopyWithImpl<_DropdownsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DropdownsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.data, data) || other.data == data)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,data,errorMessage);

@override
String toString() {
  return 'DropdownsState(loaderState: $loaderState, data: $data, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DropdownsStateCopyWith<$Res> implements $DropdownsStateCopyWith<$Res> {
  factory _$DropdownsStateCopyWith(_DropdownsState value, $Res Function(_DropdownsState) _then) = __$DropdownsStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, DropdownsDataModel data, String? errorMessage
});




}
/// @nodoc
class __$DropdownsStateCopyWithImpl<$Res>
    implements _$DropdownsStateCopyWith<$Res> {
  __$DropdownsStateCopyWithImpl(this._self, this._then);

  final _DropdownsState _self;
  final $Res Function(_DropdownsState) _then;

/// Create a copy of DropdownsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? data = null,Object? errorMessage = freezed,}) {
  return _then(_DropdownsState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DropdownsDataModel,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
