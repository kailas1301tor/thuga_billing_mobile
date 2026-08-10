// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {

 LoaderState get loaderState; ProductResponse? get response; String? get errorMessage; int? get selectedCategoryId; String? get selectedCategoryName; String get searchQuery; bool get saveProductLoader; bool get updateProductLoader; bool get deleteProductLoader; int get currentPage; int get totalPages; int get pageSize; bool get isLoadingMore; String get sort; int? get filterCategoryId; bool get isQuickProduct; String? get selectedImagePath; String? get selectedUnitId; List<int> get togglingProductIds;
/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsStateCopyWith<ProductsState> get copyWith => _$ProductsStateCopyWithImpl<ProductsState>(this as ProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.response, response) || other.response == response)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedCategoryName, selectedCategoryName) || other.selectedCategoryName == selectedCategoryName)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.saveProductLoader, saveProductLoader) || other.saveProductLoader == saveProductLoader)&&(identical(other.updateProductLoader, updateProductLoader) || other.updateProductLoader == updateProductLoader)&&(identical(other.deleteProductLoader, deleteProductLoader) || other.deleteProductLoader == deleteProductLoader)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.filterCategoryId, filterCategoryId) || other.filterCategoryId == filterCategoryId)&&(identical(other.isQuickProduct, isQuickProduct) || other.isQuickProduct == isQuickProduct)&&(identical(other.selectedImagePath, selectedImagePath) || other.selectedImagePath == selectedImagePath)&&(identical(other.selectedUnitId, selectedUnitId) || other.selectedUnitId == selectedUnitId)&&const DeepCollectionEquality().equals(other.togglingProductIds, togglingProductIds));
}


@override
int get hashCode => Object.hashAll([runtimeType,loaderState,response,errorMessage,selectedCategoryId,selectedCategoryName,searchQuery,saveProductLoader,updateProductLoader,deleteProductLoader,currentPage,totalPages,pageSize,isLoadingMore,sort,filterCategoryId,isQuickProduct,selectedImagePath,selectedUnitId,const DeepCollectionEquality().hash(togglingProductIds)]);

@override
String toString() {
  return 'ProductsState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, selectedCategoryId: $selectedCategoryId, selectedCategoryName: $selectedCategoryName, searchQuery: $searchQuery, saveProductLoader: $saveProductLoader, updateProductLoader: $updateProductLoader, deleteProductLoader: $deleteProductLoader, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, sort: $sort, filterCategoryId: $filterCategoryId, isQuickProduct: $isQuickProduct, selectedImagePath: $selectedImagePath, selectedUnitId: $selectedUnitId, togglingProductIds: $togglingProductIds)';
}


}

/// @nodoc
abstract mixin class $ProductsStateCopyWith<$Res>  {
  factory $ProductsStateCopyWith(ProductsState value, $Res Function(ProductsState) _then) = _$ProductsStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, ProductResponse? response, String? errorMessage, int? selectedCategoryId, String? selectedCategoryName, String searchQuery, bool saveProductLoader, bool updateProductLoader, bool deleteProductLoader, int currentPage, int totalPages, int pageSize, bool isLoadingMore, String sort, int? filterCategoryId, bool isQuickProduct, String? selectedImagePath, String? selectedUnitId, List<int> togglingProductIds
});




}
/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._self, this._then);

  final ProductsState _self;
  final $Res Function(ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? response = freezed,Object? errorMessage = freezed,Object? selectedCategoryId = freezed,Object? selectedCategoryName = freezed,Object? searchQuery = null,Object? saveProductLoader = null,Object? updateProductLoader = null,Object? deleteProductLoader = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? sort = null,Object? filterCategoryId = freezed,Object? isQuickProduct = null,Object? selectedImagePath = freezed,Object? selectedUnitId = freezed,Object? togglingProductIds = null,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ProductResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int?,selectedCategoryName: freezed == selectedCategoryName ? _self.selectedCategoryName : selectedCategoryName // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,saveProductLoader: null == saveProductLoader ? _self.saveProductLoader : saveProductLoader // ignore: cast_nullable_to_non_nullable
as bool,updateProductLoader: null == updateProductLoader ? _self.updateProductLoader : updateProductLoader // ignore: cast_nullable_to_non_nullable
as bool,deleteProductLoader: null == deleteProductLoader ? _self.deleteProductLoader : deleteProductLoader // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,filterCategoryId: freezed == filterCategoryId ? _self.filterCategoryId : filterCategoryId // ignore: cast_nullable_to_non_nullable
as int?,isQuickProduct: null == isQuickProduct ? _self.isQuickProduct : isQuickProduct // ignore: cast_nullable_to_non_nullable
as bool,selectedImagePath: freezed == selectedImagePath ? _self.selectedImagePath : selectedImagePath // ignore: cast_nullable_to_non_nullable
as String?,selectedUnitId: freezed == selectedUnitId ? _self.selectedUnitId : selectedUnitId // ignore: cast_nullable_to_non_nullable
as String?,togglingProductIds: null == togglingProductIds ? _self.togglingProductIds : togglingProductIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductsState value)  $default,){
final _that = this;
switch (_that) {
case _ProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  ProductResponse? response,  String? errorMessage,  int? selectedCategoryId,  String? selectedCategoryName,  String searchQuery,  bool saveProductLoader,  bool updateProductLoader,  bool deleteProductLoader,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  String sort,  int? filterCategoryId,  bool isQuickProduct,  String? selectedImagePath,  String? selectedUnitId,  List<int> togglingProductIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.selectedCategoryId,_that.selectedCategoryName,_that.searchQuery,_that.saveProductLoader,_that.updateProductLoader,_that.deleteProductLoader,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.sort,_that.filterCategoryId,_that.isQuickProduct,_that.selectedImagePath,_that.selectedUnitId,_that.togglingProductIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  ProductResponse? response,  String? errorMessage,  int? selectedCategoryId,  String? selectedCategoryName,  String searchQuery,  bool saveProductLoader,  bool updateProductLoader,  bool deleteProductLoader,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  String sort,  int? filterCategoryId,  bool isQuickProduct,  String? selectedImagePath,  String? selectedUnitId,  List<int> togglingProductIds)  $default,) {final _that = this;
switch (_that) {
case _ProductsState():
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.selectedCategoryId,_that.selectedCategoryName,_that.searchQuery,_that.saveProductLoader,_that.updateProductLoader,_that.deleteProductLoader,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.sort,_that.filterCategoryId,_that.isQuickProduct,_that.selectedImagePath,_that.selectedUnitId,_that.togglingProductIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  ProductResponse? response,  String? errorMessage,  int? selectedCategoryId,  String? selectedCategoryName,  String searchQuery,  bool saveProductLoader,  bool updateProductLoader,  bool deleteProductLoader,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  String sort,  int? filterCategoryId,  bool isQuickProduct,  String? selectedImagePath,  String? selectedUnitId,  List<int> togglingProductIds)?  $default,) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.loaderState,_that.response,_that.errorMessage,_that.selectedCategoryId,_that.selectedCategoryName,_that.searchQuery,_that.saveProductLoader,_that.updateProductLoader,_that.deleteProductLoader,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.sort,_that.filterCategoryId,_that.isQuickProduct,_that.selectedImagePath,_that.selectedUnitId,_that.togglingProductIds);case _:
  return null;

}
}

}

/// @nodoc


class _ProductsState implements ProductsState {
  const _ProductsState({this.loaderState = LoaderState.loading, this.response, this.errorMessage, this.selectedCategoryId, this.selectedCategoryName, this.searchQuery = '', this.saveProductLoader = false, this.updateProductLoader = false, this.deleteProductLoader = false, this.currentPage = 1, this.totalPages = 1, this.pageSize = 10, this.isLoadingMore = false, this.sort = 'lowest', this.filterCategoryId, this.isQuickProduct = true, this.selectedImagePath, this.selectedUnitId, final  List<int> togglingProductIds = const []}): _togglingProductIds = togglingProductIds;
  

@override@JsonKey() final  LoaderState loaderState;
@override final  ProductResponse? response;
@override final  String? errorMessage;
@override final  int? selectedCategoryId;
@override final  String? selectedCategoryName;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  bool saveProductLoader;
@override@JsonKey() final  bool updateProductLoader;
@override@JsonKey() final  bool deleteProductLoader;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  String sort;
@override final  int? filterCategoryId;
@override@JsonKey() final  bool isQuickProduct;
@override final  String? selectedImagePath;
@override final  String? selectedUnitId;
 final  List<int> _togglingProductIds;
@override@JsonKey() List<int> get togglingProductIds {
  if (_togglingProductIds is EqualUnmodifiableListView) return _togglingProductIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_togglingProductIds);
}


/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsStateCopyWith<_ProductsState> get copyWith => __$ProductsStateCopyWithImpl<_ProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.response, response) || other.response == response)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedCategoryName, selectedCategoryName) || other.selectedCategoryName == selectedCategoryName)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.saveProductLoader, saveProductLoader) || other.saveProductLoader == saveProductLoader)&&(identical(other.updateProductLoader, updateProductLoader) || other.updateProductLoader == updateProductLoader)&&(identical(other.deleteProductLoader, deleteProductLoader) || other.deleteProductLoader == deleteProductLoader)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.filterCategoryId, filterCategoryId) || other.filterCategoryId == filterCategoryId)&&(identical(other.isQuickProduct, isQuickProduct) || other.isQuickProduct == isQuickProduct)&&(identical(other.selectedImagePath, selectedImagePath) || other.selectedImagePath == selectedImagePath)&&(identical(other.selectedUnitId, selectedUnitId) || other.selectedUnitId == selectedUnitId)&&const DeepCollectionEquality().equals(other._togglingProductIds, _togglingProductIds));
}


@override
int get hashCode => Object.hashAll([runtimeType,loaderState,response,errorMessage,selectedCategoryId,selectedCategoryName,searchQuery,saveProductLoader,updateProductLoader,deleteProductLoader,currentPage,totalPages,pageSize,isLoadingMore,sort,filterCategoryId,isQuickProduct,selectedImagePath,selectedUnitId,const DeepCollectionEquality().hash(_togglingProductIds)]);

@override
String toString() {
  return 'ProductsState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, selectedCategoryId: $selectedCategoryId, selectedCategoryName: $selectedCategoryName, searchQuery: $searchQuery, saveProductLoader: $saveProductLoader, updateProductLoader: $updateProductLoader, deleteProductLoader: $deleteProductLoader, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, sort: $sort, filterCategoryId: $filterCategoryId, isQuickProduct: $isQuickProduct, selectedImagePath: $selectedImagePath, selectedUnitId: $selectedUnitId, togglingProductIds: $togglingProductIds)';
}


}

/// @nodoc
abstract mixin class _$ProductsStateCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsStateCopyWith(_ProductsState value, $Res Function(_ProductsState) _then) = __$ProductsStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, ProductResponse? response, String? errorMessage, int? selectedCategoryId, String? selectedCategoryName, String searchQuery, bool saveProductLoader, bool updateProductLoader, bool deleteProductLoader, int currentPage, int totalPages, int pageSize, bool isLoadingMore, String sort, int? filterCategoryId, bool isQuickProduct, String? selectedImagePath, String? selectedUnitId, List<int> togglingProductIds
});




}
/// @nodoc
class __$ProductsStateCopyWithImpl<$Res>
    implements _$ProductsStateCopyWith<$Res> {
  __$ProductsStateCopyWithImpl(this._self, this._then);

  final _ProductsState _self;
  final $Res Function(_ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? response = freezed,Object? errorMessage = freezed,Object? selectedCategoryId = freezed,Object? selectedCategoryName = freezed,Object? searchQuery = null,Object? saveProductLoader = null,Object? updateProductLoader = null,Object? deleteProductLoader = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? sort = null,Object? filterCategoryId = freezed,Object? isQuickProduct = null,Object? selectedImagePath = freezed,Object? selectedUnitId = freezed,Object? togglingProductIds = null,}) {
  return _then(_ProductsState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ProductResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int?,selectedCategoryName: freezed == selectedCategoryName ? _self.selectedCategoryName : selectedCategoryName // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,saveProductLoader: null == saveProductLoader ? _self.saveProductLoader : saveProductLoader // ignore: cast_nullable_to_non_nullable
as bool,updateProductLoader: null == updateProductLoader ? _self.updateProductLoader : updateProductLoader // ignore: cast_nullable_to_non_nullable
as bool,deleteProductLoader: null == deleteProductLoader ? _self.deleteProductLoader : deleteProductLoader // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,filterCategoryId: freezed == filterCategoryId ? _self.filterCategoryId : filterCategoryId // ignore: cast_nullable_to_non_nullable
as int?,isQuickProduct: null == isQuickProduct ? _self.isQuickProduct : isQuickProduct // ignore: cast_nullable_to_non_nullable
as bool,selectedImagePath: freezed == selectedImagePath ? _self.selectedImagePath : selectedImagePath // ignore: cast_nullable_to_non_nullable
as String?,selectedUnitId: freezed == selectedUnitId ? _self.selectedUnitId : selectedUnitId // ignore: cast_nullable_to_non_nullable
as String?,togglingProductIds: null == togglingProductIds ? _self._togglingProductIds : togglingProductIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
