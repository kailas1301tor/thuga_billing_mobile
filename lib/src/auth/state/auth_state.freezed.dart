// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 LoaderState get loaderState; bool get logoutLoader; String? get emailErrorText; String? get passwordErrorText; String? get phoneErrorText; String? get companyNameErrorText; String? get addressErrorText; AuthModel? get authModel;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.logoutLoader, logoutLoader) || other.logoutLoader == logoutLoader)&&(identical(other.emailErrorText, emailErrorText) || other.emailErrorText == emailErrorText)&&(identical(other.passwordErrorText, passwordErrorText) || other.passwordErrorText == passwordErrorText)&&(identical(other.phoneErrorText, phoneErrorText) || other.phoneErrorText == phoneErrorText)&&(identical(other.companyNameErrorText, companyNameErrorText) || other.companyNameErrorText == companyNameErrorText)&&(identical(other.addressErrorText, addressErrorText) || other.addressErrorText == addressErrorText)&&(identical(other.authModel, authModel) || other.authModel == authModel));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,logoutLoader,emailErrorText,passwordErrorText,phoneErrorText,companyNameErrorText,addressErrorText,authModel);

@override
String toString() {
  return 'AuthState(loaderState: $loaderState, logoutLoader: $logoutLoader, emailErrorText: $emailErrorText, passwordErrorText: $passwordErrorText, phoneErrorText: $phoneErrorText, companyNameErrorText: $companyNameErrorText, addressErrorText: $addressErrorText, authModel: $authModel)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, bool logoutLoader, String? emailErrorText, String? passwordErrorText, String? phoneErrorText, String? companyNameErrorText, String? addressErrorText, AuthModel? authModel
});




}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? logoutLoader = null,Object? emailErrorText = freezed,Object? passwordErrorText = freezed,Object? phoneErrorText = freezed,Object? companyNameErrorText = freezed,Object? addressErrorText = freezed,Object? authModel = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,logoutLoader: null == logoutLoader ? _self.logoutLoader : logoutLoader // ignore: cast_nullable_to_non_nullable
as bool,emailErrorText: freezed == emailErrorText ? _self.emailErrorText : emailErrorText // ignore: cast_nullable_to_non_nullable
as String?,passwordErrorText: freezed == passwordErrorText ? _self.passwordErrorText : passwordErrorText // ignore: cast_nullable_to_non_nullable
as String?,phoneErrorText: freezed == phoneErrorText ? _self.phoneErrorText : phoneErrorText // ignore: cast_nullable_to_non_nullable
as String?,companyNameErrorText: freezed == companyNameErrorText ? _self.companyNameErrorText : companyNameErrorText // ignore: cast_nullable_to_non_nullable
as String?,addressErrorText: freezed == addressErrorText ? _self.addressErrorText : addressErrorText // ignore: cast_nullable_to_non_nullable
as String?,authModel: freezed == authModel ? _self.authModel : authModel // ignore: cast_nullable_to_non_nullable
as AuthModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  bool logoutLoader,  String? emailErrorText,  String? passwordErrorText,  String? phoneErrorText,  String? companyNameErrorText,  String? addressErrorText,  AuthModel? authModel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.loaderState,_that.logoutLoader,_that.emailErrorText,_that.passwordErrorText,_that.phoneErrorText,_that.companyNameErrorText,_that.addressErrorText,_that.authModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  bool logoutLoader,  String? emailErrorText,  String? passwordErrorText,  String? phoneErrorText,  String? companyNameErrorText,  String? addressErrorText,  AuthModel? authModel)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.loaderState,_that.logoutLoader,_that.emailErrorText,_that.passwordErrorText,_that.phoneErrorText,_that.companyNameErrorText,_that.addressErrorText,_that.authModel);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  bool logoutLoader,  String? emailErrorText,  String? passwordErrorText,  String? phoneErrorText,  String? companyNameErrorText,  String? addressErrorText,  AuthModel? authModel)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.loaderState,_that.logoutLoader,_that.emailErrorText,_that.passwordErrorText,_that.phoneErrorText,_that.companyNameErrorText,_that.addressErrorText,_that.authModel);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.loaderState = LoaderState.loaded, this.logoutLoader = false, this.emailErrorText, this.passwordErrorText, this.phoneErrorText, this.companyNameErrorText, this.addressErrorText, this.authModel});
  

@override@JsonKey() final  LoaderState loaderState;
@override@JsonKey() final  bool logoutLoader;
@override final  String? emailErrorText;
@override final  String? passwordErrorText;
@override final  String? phoneErrorText;
@override final  String? companyNameErrorText;
@override final  String? addressErrorText;
@override final  AuthModel? authModel;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.logoutLoader, logoutLoader) || other.logoutLoader == logoutLoader)&&(identical(other.emailErrorText, emailErrorText) || other.emailErrorText == emailErrorText)&&(identical(other.passwordErrorText, passwordErrorText) || other.passwordErrorText == passwordErrorText)&&(identical(other.phoneErrorText, phoneErrorText) || other.phoneErrorText == phoneErrorText)&&(identical(other.companyNameErrorText, companyNameErrorText) || other.companyNameErrorText == companyNameErrorText)&&(identical(other.addressErrorText, addressErrorText) || other.addressErrorText == addressErrorText)&&(identical(other.authModel, authModel) || other.authModel == authModel));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,logoutLoader,emailErrorText,passwordErrorText,phoneErrorText,companyNameErrorText,addressErrorText,authModel);

@override
String toString() {
  return 'AuthState(loaderState: $loaderState, logoutLoader: $logoutLoader, emailErrorText: $emailErrorText, passwordErrorText: $passwordErrorText, phoneErrorText: $phoneErrorText, companyNameErrorText: $companyNameErrorText, addressErrorText: $addressErrorText, authModel: $authModel)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, bool logoutLoader, String? emailErrorText, String? passwordErrorText, String? phoneErrorText, String? companyNameErrorText, String? addressErrorText, AuthModel? authModel
});




}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? logoutLoader = null,Object? emailErrorText = freezed,Object? passwordErrorText = freezed,Object? phoneErrorText = freezed,Object? companyNameErrorText = freezed,Object? addressErrorText = freezed,Object? authModel = freezed,}) {
  return _then(_AuthState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,logoutLoader: null == logoutLoader ? _self.logoutLoader : logoutLoader // ignore: cast_nullable_to_non_nullable
as bool,emailErrorText: freezed == emailErrorText ? _self.emailErrorText : emailErrorText // ignore: cast_nullable_to_non_nullable
as String?,passwordErrorText: freezed == passwordErrorText ? _self.passwordErrorText : passwordErrorText // ignore: cast_nullable_to_non_nullable
as String?,phoneErrorText: freezed == phoneErrorText ? _self.phoneErrorText : phoneErrorText // ignore: cast_nullable_to_non_nullable
as String?,companyNameErrorText: freezed == companyNameErrorText ? _self.companyNameErrorText : companyNameErrorText // ignore: cast_nullable_to_non_nullable
as String?,addressErrorText: freezed == addressErrorText ? _self.addressErrorText : addressErrorText // ignore: cast_nullable_to_non_nullable
as String?,authModel: freezed == authModel ? _self.authModel : authModel // ignore: cast_nullable_to_non_nullable
as AuthModel?,
  ));
}


}

// dart format on
