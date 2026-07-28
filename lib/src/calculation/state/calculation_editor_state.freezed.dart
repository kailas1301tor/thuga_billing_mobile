// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalculationEditorState {

 LoaderState get loaderState; LoaderState get catalogLoaderState; String? get billId; String get billName; List<CalculationCustomerSectionModel> get customerSections; int? get activeCustomerId; List<CalculationCategoryModel> get categories; List<CalculationProductModel> get products; String get selectedCategory; int get selectedCategoryId; String get searchQuery; bool get isSaving; String? get errorMessage;
/// Create a copy of CalculationEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculationEditorStateCopyWith<CalculationEditorState> get copyWith => _$CalculationEditorStateCopyWithImpl<CalculationEditorState>(this as CalculationEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculationEditorState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.catalogLoaderState, catalogLoaderState) || other.catalogLoaderState == catalogLoaderState)&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.billName, billName) || other.billName == billName)&&const DeepCollectionEquality().equals(other.customerSections, customerSections)&&(identical(other.activeCustomerId, activeCustomerId) || other.activeCustomerId == activeCustomerId)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,catalogLoaderState,billId,billName,const DeepCollectionEquality().hash(customerSections),activeCustomerId,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(products),selectedCategory,selectedCategoryId,searchQuery,isSaving,errorMessage);

@override
String toString() {
  return 'CalculationEditorState(loaderState: $loaderState, catalogLoaderState: $catalogLoaderState, billId: $billId, billName: $billName, customerSections: $customerSections, activeCustomerId: $activeCustomerId, categories: $categories, products: $products, selectedCategory: $selectedCategory, selectedCategoryId: $selectedCategoryId, searchQuery: $searchQuery, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CalculationEditorStateCopyWith<$Res>  {
  factory $CalculationEditorStateCopyWith(CalculationEditorState value, $Res Function(CalculationEditorState) _then) = _$CalculationEditorStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, LoaderState catalogLoaderState, String? billId, String billName, List<CalculationCustomerSectionModel> customerSections, int? activeCustomerId, List<CalculationCategoryModel> categories, List<CalculationProductModel> products, String selectedCategory, int selectedCategoryId, String searchQuery, bool isSaving, String? errorMessage
});




}
/// @nodoc
class _$CalculationEditorStateCopyWithImpl<$Res>
    implements $CalculationEditorStateCopyWith<$Res> {
  _$CalculationEditorStateCopyWithImpl(this._self, this._then);

  final CalculationEditorState _self;
  final $Res Function(CalculationEditorState) _then;

/// Create a copy of CalculationEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? catalogLoaderState = null,Object? billId = freezed,Object? billName = null,Object? customerSections = null,Object? activeCustomerId = freezed,Object? categories = null,Object? products = null,Object? selectedCategory = null,Object? selectedCategoryId = null,Object? searchQuery = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,catalogLoaderState: null == catalogLoaderState ? _self.catalogLoaderState : catalogLoaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,billId: freezed == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as String?,billName: null == billName ? _self.billName : billName // ignore: cast_nullable_to_non_nullable
as String,customerSections: null == customerSections ? _self.customerSections : customerSections // ignore: cast_nullable_to_non_nullable
as List<CalculationCustomerSectionModel>,activeCustomerId: freezed == activeCustomerId ? _self.activeCustomerId : activeCustomerId // ignore: cast_nullable_to_non_nullable
as int?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CalculationCategoryModel>,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<CalculationProductModel>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculationEditorState].
extension CalculationEditorStatePatterns on CalculationEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculationEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculationEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculationEditorState value)  $default,){
final _that = this;
switch (_that) {
case _CalculationEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculationEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _CalculationEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  LoaderState catalogLoaderState,  String? billId,  String billName,  List<CalculationCustomerSectionModel> customerSections,  int? activeCustomerId,  List<CalculationCategoryModel> categories,  List<CalculationProductModel> products,  String selectedCategory,  int selectedCategoryId,  String searchQuery,  bool isSaving,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculationEditorState() when $default != null:
return $default(_that.loaderState,_that.catalogLoaderState,_that.billId,_that.billName,_that.customerSections,_that.activeCustomerId,_that.categories,_that.products,_that.selectedCategory,_that.selectedCategoryId,_that.searchQuery,_that.isSaving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  LoaderState catalogLoaderState,  String? billId,  String billName,  List<CalculationCustomerSectionModel> customerSections,  int? activeCustomerId,  List<CalculationCategoryModel> categories,  List<CalculationProductModel> products,  String selectedCategory,  int selectedCategoryId,  String searchQuery,  bool isSaving,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CalculationEditorState():
return $default(_that.loaderState,_that.catalogLoaderState,_that.billId,_that.billName,_that.customerSections,_that.activeCustomerId,_that.categories,_that.products,_that.selectedCategory,_that.selectedCategoryId,_that.searchQuery,_that.isSaving,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  LoaderState catalogLoaderState,  String? billId,  String billName,  List<CalculationCustomerSectionModel> customerSections,  int? activeCustomerId,  List<CalculationCategoryModel> categories,  List<CalculationProductModel> products,  String selectedCategory,  int selectedCategoryId,  String searchQuery,  bool isSaving,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CalculationEditorState() when $default != null:
return $default(_that.loaderState,_that.catalogLoaderState,_that.billId,_that.billName,_that.customerSections,_that.activeCustomerId,_that.categories,_that.products,_that.selectedCategory,_that.selectedCategoryId,_that.searchQuery,_that.isSaving,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CalculationEditorState implements CalculationEditorState {
  const _CalculationEditorState({this.loaderState = LoaderState.loaded, this.catalogLoaderState = LoaderState.loading, this.billId, this.billName = '', final  List<CalculationCustomerSectionModel> customerSections = const [], this.activeCustomerId, final  List<CalculationCategoryModel> categories = const [], final  List<CalculationProductModel> products = const [], this.selectedCategory = '', this.selectedCategoryId = 0, this.searchQuery = '', this.isSaving = false, this.errorMessage}): _customerSections = customerSections,_categories = categories,_products = products;
  

@override@JsonKey() final  LoaderState loaderState;
@override@JsonKey() final  LoaderState catalogLoaderState;
@override final  String? billId;
@override@JsonKey() final  String billName;
 final  List<CalculationCustomerSectionModel> _customerSections;
@override@JsonKey() List<CalculationCustomerSectionModel> get customerSections {
  if (_customerSections is EqualUnmodifiableListView) return _customerSections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customerSections);
}

@override final  int? activeCustomerId;
 final  List<CalculationCategoryModel> _categories;
@override@JsonKey() List<CalculationCategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<CalculationProductModel> _products;
@override@JsonKey() List<CalculationProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey() final  String selectedCategory;
@override@JsonKey() final  int selectedCategoryId;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  bool isSaving;
@override final  String? errorMessage;

/// Create a copy of CalculationEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculationEditorStateCopyWith<_CalculationEditorState> get copyWith => __$CalculationEditorStateCopyWithImpl<_CalculationEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculationEditorState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.catalogLoaderState, catalogLoaderState) || other.catalogLoaderState == catalogLoaderState)&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.billName, billName) || other.billName == billName)&&const DeepCollectionEquality().equals(other._customerSections, _customerSections)&&(identical(other.activeCustomerId, activeCustomerId) || other.activeCustomerId == activeCustomerId)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,catalogLoaderState,billId,billName,const DeepCollectionEquality().hash(_customerSections),activeCustomerId,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_products),selectedCategory,selectedCategoryId,searchQuery,isSaving,errorMessage);

@override
String toString() {
  return 'CalculationEditorState(loaderState: $loaderState, catalogLoaderState: $catalogLoaderState, billId: $billId, billName: $billName, customerSections: $customerSections, activeCustomerId: $activeCustomerId, categories: $categories, products: $products, selectedCategory: $selectedCategory, selectedCategoryId: $selectedCategoryId, searchQuery: $searchQuery, isSaving: $isSaving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CalculationEditorStateCopyWith<$Res> implements $CalculationEditorStateCopyWith<$Res> {
  factory _$CalculationEditorStateCopyWith(_CalculationEditorState value, $Res Function(_CalculationEditorState) _then) = __$CalculationEditorStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, LoaderState catalogLoaderState, String? billId, String billName, List<CalculationCustomerSectionModel> customerSections, int? activeCustomerId, List<CalculationCategoryModel> categories, List<CalculationProductModel> products, String selectedCategory, int selectedCategoryId, String searchQuery, bool isSaving, String? errorMessage
});




}
/// @nodoc
class __$CalculationEditorStateCopyWithImpl<$Res>
    implements _$CalculationEditorStateCopyWith<$Res> {
  __$CalculationEditorStateCopyWithImpl(this._self, this._then);

  final _CalculationEditorState _self;
  final $Res Function(_CalculationEditorState) _then;

/// Create a copy of CalculationEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? catalogLoaderState = null,Object? billId = freezed,Object? billName = null,Object? customerSections = null,Object? activeCustomerId = freezed,Object? categories = null,Object? products = null,Object? selectedCategory = null,Object? selectedCategoryId = null,Object? searchQuery = null,Object? isSaving = null,Object? errorMessage = freezed,}) {
  return _then(_CalculationEditorState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,catalogLoaderState: null == catalogLoaderState ? _self.catalogLoaderState : catalogLoaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,billId: freezed == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as String?,billName: null == billName ? _self.billName : billName // ignore: cast_nullable_to_non_nullable
as String,customerSections: null == customerSections ? _self._customerSections : customerSections // ignore: cast_nullable_to_non_nullable
as List<CalculationCustomerSectionModel>,activeCustomerId: freezed == activeCustomerId ? _self.activeCustomerId : activeCustomerId // ignore: cast_nullable_to_non_nullable
as int?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CalculationCategoryModel>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<CalculationProductModel>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
