// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomersState {

 LoaderState get loaderState; CustomerResponse? get response; String? get errorMessage; String get searchQuery; int get currentPage; int get totalPages; int get pageSize; bool get isLoadingMore; bool get saveCustomerLoader; bool get updateCustomerLoader; bool get deleteCustomerLoader;
/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomersStateCopyWith<CustomersState> get copyWith => _$CustomersStateCopyWithImpl<CustomersState>(this as CustomersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomersState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.response, response) || other.response == response)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.saveCustomerLoader, saveCustomerLoader) || other.saveCustomerLoader == saveCustomerLoader)&&(identical(other.updateCustomerLoader, updateCustomerLoader) || other.updateCustomerLoader == updateCustomerLoader)&&(identical(other.deleteCustomerLoader, deleteCustomerLoader) || other.deleteCustomerLoader == deleteCustomerLoader));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,response,errorMessage,searchQuery,currentPage,totalPages,pageSize,isLoadingMore,saveCustomerLoader,updateCustomerLoader,deleteCustomerLoader);

@override
String toString() {
  return 'CustomersState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, searchQuery: $searchQuery, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, saveCustomerLoader: $saveCustomerLoader, updateCustomerLoader: $updateCustomerLoader, deleteCustomerLoader: $deleteCustomerLoader)';
}


}

/// @nodoc
abstract mixin class $CustomersStateCopyWith<$Res>  {
  factory $CustomersStateCopyWith(CustomersState value, $Res Function(CustomersState) _then) = _$CustomersStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, CustomerResponse? response, String? errorMessage, String searchQuery, int currentPage, int totalPages, int pageSize, bool isLoadingMore, bool saveCustomerLoader, bool updateCustomerLoader, bool deleteCustomerLoader
});




}
/// @nodoc
class _$CustomersStateCopyWithImpl<$Res>
    implements $CustomersStateCopyWith<$Res> {
  _$CustomersStateCopyWithImpl(this._self, this._then);

  final CustomersState _self;
  final $Res Function(CustomersState) _then;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? response = freezed,Object? errorMessage = freezed,Object? searchQuery = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? saveCustomerLoader = null,Object? updateCustomerLoader = null,Object? deleteCustomerLoader = null,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as CustomerResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,saveCustomerLoader: null == saveCustomerLoader ? _self.saveCustomerLoader : saveCustomerLoader // ignore: cast_nullable_to_non_nullable
as bool,updateCustomerLoader: null == updateCustomerLoader ? _self.updateCustomerLoader : updateCustomerLoader // ignore: cast_nullable_to_non_nullable
as bool,deleteCustomerLoader: null == deleteCustomerLoader ? _self.deleteCustomerLoader : deleteCustomerLoader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomersState].
extension CustomersStatePatterns on CustomersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomersState value)  $default,){
final _that = this;
switch (_that) {
case _CustomersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomersState value)?  $default,){
final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  CustomerResponse? response,  String? errorMessage,  String searchQuery,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  bool saveCustomerLoader,  bool updateCustomerLoader,  bool deleteCustomerLoader)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.searchQuery,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.saveCustomerLoader,_that.updateCustomerLoader,_that.deleteCustomerLoader);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  CustomerResponse? response,  String? errorMessage,  String searchQuery,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  bool saveCustomerLoader,  bool updateCustomerLoader,  bool deleteCustomerLoader)  $default,) {final _that = this;
switch (_that) {
case _CustomersState():
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.searchQuery,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.saveCustomerLoader,_that.updateCustomerLoader,_that.deleteCustomerLoader);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  CustomerResponse? response,  String? errorMessage,  String searchQuery,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  bool saveCustomerLoader,  bool updateCustomerLoader,  bool deleteCustomerLoader)?  $default,) {final _that = this;
switch (_that) {
case _CustomersState() when $default != null:
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.searchQuery,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.saveCustomerLoader,_that.updateCustomerLoader,_that.deleteCustomerLoader);case _:
  return null;

}
}

}

/// @nodoc


class _CustomersState implements CustomersState {
  const _CustomersState({this.loaderState = LoaderState.loading, this.response, this.errorMessage, this.searchQuery = '', this.currentPage = 1, this.totalPages = 1, this.pageSize = 10, this.isLoadingMore = false, this.saveCustomerLoader = false, this.updateCustomerLoader = false, this.deleteCustomerLoader = false});
  

@override@JsonKey() final  LoaderState loaderState;
@override final  CustomerResponse? response;
@override final  String? errorMessage;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool saveCustomerLoader;
@override@JsonKey() final  bool updateCustomerLoader;
@override@JsonKey() final  bool deleteCustomerLoader;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomersStateCopyWith<_CustomersState> get copyWith => __$CustomersStateCopyWithImpl<_CustomersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomersState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.response, response) || other.response == response)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.saveCustomerLoader, saveCustomerLoader) || other.saveCustomerLoader == saveCustomerLoader)&&(identical(other.updateCustomerLoader, updateCustomerLoader) || other.updateCustomerLoader == updateCustomerLoader)&&(identical(other.deleteCustomerLoader, deleteCustomerLoader) || other.deleteCustomerLoader == deleteCustomerLoader));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,response,errorMessage,searchQuery,currentPage,totalPages,pageSize,isLoadingMore,saveCustomerLoader,updateCustomerLoader,deleteCustomerLoader);

@override
String toString() {
  return 'CustomersState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, searchQuery: $searchQuery, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, saveCustomerLoader: $saveCustomerLoader, updateCustomerLoader: $updateCustomerLoader, deleteCustomerLoader: $deleteCustomerLoader)';
}


}

/// @nodoc
abstract mixin class _$CustomersStateCopyWith<$Res> implements $CustomersStateCopyWith<$Res> {
  factory _$CustomersStateCopyWith(_CustomersState value, $Res Function(_CustomersState) _then) = __$CustomersStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, CustomerResponse? response, String? errorMessage, String searchQuery, int currentPage, int totalPages, int pageSize, bool isLoadingMore, bool saveCustomerLoader, bool updateCustomerLoader, bool deleteCustomerLoader
});




}
/// @nodoc
class __$CustomersStateCopyWithImpl<$Res>
    implements _$CustomersStateCopyWith<$Res> {
  __$CustomersStateCopyWithImpl(this._self, this._then);

  final _CustomersState _self;
  final $Res Function(_CustomersState) _then;

/// Create a copy of CustomersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? response = freezed,Object? errorMessage = freezed,Object? searchQuery = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? saveCustomerLoader = null,Object? updateCustomerLoader = null,Object? deleteCustomerLoader = null,}) {
  return _then(_CustomersState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as CustomerResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,saveCustomerLoader: null == saveCustomerLoader ? _self.saveCustomerLoader : saveCustomerLoader // ignore: cast_nullable_to_non_nullable
as bool,updateCustomerLoader: null == updateCustomerLoader ? _self.updateCustomerLoader : updateCustomerLoader // ignore: cast_nullable_to_non_nullable
as bool,deleteCustomerLoader: null == deleteCustomerLoader ? _self.deleteCustomerLoader : deleteCustomerLoader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
