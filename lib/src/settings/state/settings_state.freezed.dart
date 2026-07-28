// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 LoaderState get loaderState; SettingsModel get settings; CompanyDetailsModel? get companyDetails; TimeOfDay get startWorkingTime; TimeOfDay get endWorkingTime; String? get errorMessage;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.companyDetails, companyDetails) || other.companyDetails == companyDetails)&&(identical(other.startWorkingTime, startWorkingTime) || other.startWorkingTime == startWorkingTime)&&(identical(other.endWorkingTime, endWorkingTime) || other.endWorkingTime == endWorkingTime)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,settings,companyDetails,startWorkingTime,endWorkingTime,errorMessage);

@override
String toString() {
  return 'SettingsState(loaderState: $loaderState, settings: $settings, companyDetails: $companyDetails, startWorkingTime: $startWorkingTime, endWorkingTime: $endWorkingTime, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, SettingsModel settings, CompanyDetailsModel? companyDetails, TimeOfDay startWorkingTime, TimeOfDay endWorkingTime, String? errorMessage
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? settings = null,Object? companyDetails = freezed,Object? startWorkingTime = null,Object? endWorkingTime = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SettingsModel,companyDetails: freezed == companyDetails ? _self.companyDetails : companyDetails // ignore: cast_nullable_to_non_nullable
as CompanyDetailsModel?,startWorkingTime: null == startWorkingTime ? _self.startWorkingTime : startWorkingTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,endWorkingTime: null == endWorkingTime ? _self.endWorkingTime : endWorkingTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  SettingsModel settings,  CompanyDetailsModel? companyDetails,  TimeOfDay startWorkingTime,  TimeOfDay endWorkingTime,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.loaderState,_that.settings,_that.companyDetails,_that.startWorkingTime,_that.endWorkingTime,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  SettingsModel settings,  CompanyDetailsModel? companyDetails,  TimeOfDay startWorkingTime,  TimeOfDay endWorkingTime,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.loaderState,_that.settings,_that.companyDetails,_that.startWorkingTime,_that.endWorkingTime,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  SettingsModel settings,  CompanyDetailsModel? companyDetails,  TimeOfDay startWorkingTime,  TimeOfDay endWorkingTime,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.loaderState,_that.settings,_that.companyDetails,_that.startWorkingTime,_that.endWorkingTime,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.loaderState = LoaderState.loaded, required this.settings, this.companyDetails, this.startWorkingTime = defaultStartWorkingTime, this.endWorkingTime = defaultEndWorkingTime, this.errorMessage});
  

@override@JsonKey() final  LoaderState loaderState;
@override final  SettingsModel settings;
@override final  CompanyDetailsModel? companyDetails;
@override@JsonKey() final  TimeOfDay startWorkingTime;
@override@JsonKey() final  TimeOfDay endWorkingTime;
@override final  String? errorMessage;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.companyDetails, companyDetails) || other.companyDetails == companyDetails)&&(identical(other.startWorkingTime, startWorkingTime) || other.startWorkingTime == startWorkingTime)&&(identical(other.endWorkingTime, endWorkingTime) || other.endWorkingTime == endWorkingTime)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,settings,companyDetails,startWorkingTime,endWorkingTime,errorMessage);

@override
String toString() {
  return 'SettingsState(loaderState: $loaderState, settings: $settings, companyDetails: $companyDetails, startWorkingTime: $startWorkingTime, endWorkingTime: $endWorkingTime, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, SettingsModel settings, CompanyDetailsModel? companyDetails, TimeOfDay startWorkingTime, TimeOfDay endWorkingTime, String? errorMessage
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? settings = null,Object? companyDetails = freezed,Object? startWorkingTime = null,Object? endWorkingTime = null,Object? errorMessage = freezed,}) {
  return _then(_SettingsState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SettingsModel,companyDetails: freezed == companyDetails ? _self.companyDetails : companyDetails // ignore: cast_nullable_to_non_nullable
as CompanyDetailsModel?,startWorkingTime: null == startWorkingTime ? _self.startWorkingTime : startWorkingTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,endWorkingTime: null == endWorkingTime ? _self.endWorkingTime : endWorkingTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
