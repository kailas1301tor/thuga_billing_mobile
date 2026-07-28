// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoriesState {

 LoaderState get loaderState; CategoryResponse? get response; String? get errorMessage; String get searchQuery; int get currentPage; int get totalPages; int get pageSize; bool get isLoadingMore; bool get saveCategoryLoader; bool get updateCategoryLoader; bool get deleteCategoryLoader;
/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesStateCopyWith<CategoriesState> get copyWith => _$CategoriesStateCopyWithImpl<CategoriesState>(this as CategoriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.response, response) || other.response == response)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.saveCategoryLoader, saveCategoryLoader) || other.saveCategoryLoader == saveCategoryLoader)&&(identical(other.updateCategoryLoader, updateCategoryLoader) || other.updateCategoryLoader == updateCategoryLoader)&&(identical(other.deleteCategoryLoader, deleteCategoryLoader) || other.deleteCategoryLoader == deleteCategoryLoader));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,response,errorMessage,searchQuery,currentPage,totalPages,pageSize,isLoadingMore,saveCategoryLoader,updateCategoryLoader,deleteCategoryLoader);

@override
String toString() {
  return 'CategoriesState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, searchQuery: $searchQuery, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, saveCategoryLoader: $saveCategoryLoader, updateCategoryLoader: $updateCategoryLoader, deleteCategoryLoader: $deleteCategoryLoader)';
}


}

/// @nodoc
abstract mixin class $CategoriesStateCopyWith<$Res>  {
  factory $CategoriesStateCopyWith(CategoriesState value, $Res Function(CategoriesState) _then) = _$CategoriesStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, CategoryResponse? response, String? errorMessage, String searchQuery, int currentPage, int totalPages, int pageSize, bool isLoadingMore, bool saveCategoryLoader, bool updateCategoryLoader, bool deleteCategoryLoader
});




}
/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._self, this._then);

  final CategoriesState _self;
  final $Res Function(CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? response = freezed,Object? errorMessage = freezed,Object? searchQuery = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? saveCategoryLoader = null,Object? updateCategoryLoader = null,Object? deleteCategoryLoader = null,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as CategoryResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,saveCategoryLoader: null == saveCategoryLoader ? _self.saveCategoryLoader : saveCategoryLoader // ignore: cast_nullable_to_non_nullable
as bool,updateCategoryLoader: null == updateCategoryLoader ? _self.updateCategoryLoader : updateCategoryLoader // ignore: cast_nullable_to_non_nullable
as bool,deleteCategoryLoader: null == deleteCategoryLoader ? _self.deleteCategoryLoader : deleteCategoryLoader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoriesState].
extension CategoriesStatePatterns on CategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoriesState value)  $default,){
final _that = this;
switch (_that) {
case _CategoriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoriesState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  CategoryResponse? response,  String? errorMessage,  String searchQuery,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  bool saveCategoryLoader,  bool updateCategoryLoader,  bool deleteCategoryLoader)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.searchQuery,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.saveCategoryLoader,_that.updateCategoryLoader,_that.deleteCategoryLoader);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  CategoryResponse? response,  String? errorMessage,  String searchQuery,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  bool saveCategoryLoader,  bool updateCategoryLoader,  bool deleteCategoryLoader)  $default,) {final _that = this;
switch (_that) {
case _CategoriesState():
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.searchQuery,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.saveCategoryLoader,_that.updateCategoryLoader,_that.deleteCategoryLoader);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  CategoryResponse? response,  String? errorMessage,  String searchQuery,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  bool saveCategoryLoader,  bool updateCategoryLoader,  bool deleteCategoryLoader)?  $default,) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.searchQuery,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.saveCategoryLoader,_that.updateCategoryLoader,_that.deleteCategoryLoader);case _:
  return null;

}
}

}

/// @nodoc


class _CategoriesState implements CategoriesState {
  const _CategoriesState({this.loaderState = LoaderState.loading, this.response, this.errorMessage, this.searchQuery = '', this.currentPage = 1, this.totalPages = 1, this.pageSize = 10, this.isLoadingMore = false, this.saveCategoryLoader = false, this.updateCategoryLoader = false, this.deleteCategoryLoader = false});
  

@override@JsonKey() final  LoaderState loaderState;
@override final  CategoryResponse? response;
@override final  String? errorMessage;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool saveCategoryLoader;
@override@JsonKey() final  bool updateCategoryLoader;
@override@JsonKey() final  bool deleteCategoryLoader;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesStateCopyWith<_CategoriesState> get copyWith => __$CategoriesStateCopyWithImpl<_CategoriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.response, response) || other.response == response)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.saveCategoryLoader, saveCategoryLoader) || other.saveCategoryLoader == saveCategoryLoader)&&(identical(other.updateCategoryLoader, updateCategoryLoader) || other.updateCategoryLoader == updateCategoryLoader)&&(identical(other.deleteCategoryLoader, deleteCategoryLoader) || other.deleteCategoryLoader == deleteCategoryLoader));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,response,errorMessage,searchQuery,currentPage,totalPages,pageSize,isLoadingMore,saveCategoryLoader,updateCategoryLoader,deleteCategoryLoader);

@override
String toString() {
  return 'CategoriesState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, searchQuery: $searchQuery, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, saveCategoryLoader: $saveCategoryLoader, updateCategoryLoader: $updateCategoryLoader, deleteCategoryLoader: $deleteCategoryLoader)';
}


}

/// @nodoc
abstract mixin class _$CategoriesStateCopyWith<$Res> implements $CategoriesStateCopyWith<$Res> {
  factory _$CategoriesStateCopyWith(_CategoriesState value, $Res Function(_CategoriesState) _then) = __$CategoriesStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, CategoryResponse? response, String? errorMessage, String searchQuery, int currentPage, int totalPages, int pageSize, bool isLoadingMore, bool saveCategoryLoader, bool updateCategoryLoader, bool deleteCategoryLoader
});




}
/// @nodoc
class __$CategoriesStateCopyWithImpl<$Res>
    implements _$CategoriesStateCopyWith<$Res> {
  __$CategoriesStateCopyWithImpl(this._self, this._then);

  final _CategoriesState _self;
  final $Res Function(_CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? response = freezed,Object? errorMessage = freezed,Object? searchQuery = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? saveCategoryLoader = null,Object? updateCategoryLoader = null,Object? deleteCategoryLoader = null,}) {
  return _then(_CategoriesState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as CategoryResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,saveCategoryLoader: null == saveCategoryLoader ? _self.saveCategoryLoader : saveCategoryLoader // ignore: cast_nullable_to_non_nullable
as bool,updateCategoryLoader: null == updateCategoryLoader ? _self.updateCategoryLoader : updateCategoryLoader // ignore: cast_nullable_to_non_nullable
as bool,deleteCategoryLoader: null == deleteCategoryLoader ? _self.deleteCategoryLoader : deleteCategoryLoader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
