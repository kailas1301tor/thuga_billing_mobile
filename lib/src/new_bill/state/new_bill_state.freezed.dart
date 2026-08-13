// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_bill_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewBillState {

 LoaderState get loaderState; int get billingMode; String get selectedCategory; int get selectedCategoryId; String get searchQuery; bool get isSearchExpanded; bool get isCartExpanded; List<CategoryWithProductsModel> get categories; List<ProductModel> get products; List<CartItemModel> get cart; String get paymentMethod; int get billNumber; bool get isSavingBill; double get discountAmount; int get currentPage; int get totalPages; bool get isLoadingMore; bool get isSearchingProducts; String get paymentStatus; double get receivedAmount; DropdownCustomerModel? get selectedCustomer; String? get quantityPickerUnit; String? get errorMessage;
/// Create a copy of NewBillState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewBillStateCopyWith<NewBillState> get copyWith => _$NewBillStateCopyWithImpl<NewBillState>(this as NewBillState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewBillState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.billingMode, billingMode) || other.billingMode == billingMode)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSearchExpanded, isSearchExpanded) || other.isSearchExpanded == isSearchExpanded)&&(identical(other.isCartExpanded, isCartExpanded) || other.isCartExpanded == isCartExpanded)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.cart, cart)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.isSavingBill, isSavingBill) || other.isSavingBill == isSavingBill)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSearchingProducts, isSearchingProducts) || other.isSearchingProducts == isSearchingProducts)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.receivedAmount, receivedAmount) || other.receivedAmount == receivedAmount)&&(identical(other.selectedCustomer, selectedCustomer) || other.selectedCustomer == selectedCustomer)&&(identical(other.quantityPickerUnit, quantityPickerUnit) || other.quantityPickerUnit == quantityPickerUnit)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,loaderState,billingMode,selectedCategory,selectedCategoryId,searchQuery,isSearchExpanded,isCartExpanded,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(cart),paymentMethod,billNumber,isSavingBill,discountAmount,currentPage,totalPages,isLoadingMore,isSearchingProducts,paymentStatus,receivedAmount,selectedCustomer,quantityPickerUnit,errorMessage]);

@override
String toString() {
  return 'NewBillState(loaderState: $loaderState, billingMode: $billingMode, selectedCategory: $selectedCategory, selectedCategoryId: $selectedCategoryId, searchQuery: $searchQuery, isSearchExpanded: $isSearchExpanded, isCartExpanded: $isCartExpanded, categories: $categories, products: $products, cart: $cart, paymentMethod: $paymentMethod, billNumber: $billNumber, isSavingBill: $isSavingBill, discountAmount: $discountAmount, currentPage: $currentPage, totalPages: $totalPages, isLoadingMore: $isLoadingMore, isSearchingProducts: $isSearchingProducts, paymentStatus: $paymentStatus, receivedAmount: $receivedAmount, selectedCustomer: $selectedCustomer, quantityPickerUnit: $quantityPickerUnit, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $NewBillStateCopyWith<$Res>  {
  factory $NewBillStateCopyWith(NewBillState value, $Res Function(NewBillState) _then) = _$NewBillStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, int billingMode, String selectedCategory, int selectedCategoryId, String searchQuery, bool isSearchExpanded, bool isCartExpanded, List<CategoryWithProductsModel> categories, List<ProductModel> products, List<CartItemModel> cart, String paymentMethod, int billNumber, bool isSavingBill, double discountAmount, int currentPage, int totalPages, bool isLoadingMore, bool isSearchingProducts, String paymentStatus, double receivedAmount, DropdownCustomerModel? selectedCustomer, String? quantityPickerUnit, String? errorMessage
});




}
/// @nodoc
class _$NewBillStateCopyWithImpl<$Res>
    implements $NewBillStateCopyWith<$Res> {
  _$NewBillStateCopyWithImpl(this._self, this._then);

  final NewBillState _self;
  final $Res Function(NewBillState) _then;

/// Create a copy of NewBillState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? billingMode = null,Object? selectedCategory = null,Object? selectedCategoryId = null,Object? searchQuery = null,Object? isSearchExpanded = null,Object? isCartExpanded = null,Object? categories = null,Object? products = null,Object? cart = null,Object? paymentMethod = null,Object? billNumber = null,Object? isSavingBill = null,Object? discountAmount = null,Object? currentPage = null,Object? totalPages = null,Object? isLoadingMore = null,Object? isSearchingProducts = null,Object? paymentStatus = null,Object? receivedAmount = null,Object? selectedCustomer = freezed,Object? quantityPickerUnit = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,billingMode: null == billingMode ? _self.billingMode : billingMode // ignore: cast_nullable_to_non_nullable
as int,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSearchExpanded: null == isSearchExpanded ? _self.isSearchExpanded : isSearchExpanded // ignore: cast_nullable_to_non_nullable
as bool,isCartExpanded: null == isCartExpanded ? _self.isCartExpanded : isCartExpanded // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryWithProductsModel>,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as List<CartItemModel>,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as int,isSavingBill: null == isSavingBill ? _self.isSavingBill : isSavingBill // ignore: cast_nullable_to_non_nullable
as bool,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSearchingProducts: null == isSearchingProducts ? _self.isSearchingProducts : isSearchingProducts // ignore: cast_nullable_to_non_nullable
as bool,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,receivedAmount: null == receivedAmount ? _self.receivedAmount : receivedAmount // ignore: cast_nullable_to_non_nullable
as double,selectedCustomer: freezed == selectedCustomer ? _self.selectedCustomer : selectedCustomer // ignore: cast_nullable_to_non_nullable
as DropdownCustomerModel?,quantityPickerUnit: freezed == quantityPickerUnit ? _self.quantityPickerUnit : quantityPickerUnit // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewBillState].
extension NewBillStatePatterns on NewBillState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewBillState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewBillState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewBillState value)  $default,){
final _that = this;
switch (_that) {
case _NewBillState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewBillState value)?  $default,){
final _that = this;
switch (_that) {
case _NewBillState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  int billingMode,  String selectedCategory,  int selectedCategoryId,  String searchQuery,  bool isSearchExpanded,  bool isCartExpanded,  List<CategoryWithProductsModel> categories,  List<ProductModel> products,  List<CartItemModel> cart,  String paymentMethod,  int billNumber,  bool isSavingBill,  double discountAmount,  int currentPage,  int totalPages,  bool isLoadingMore,  bool isSearchingProducts,  String paymentStatus,  double receivedAmount,  DropdownCustomerModel? selectedCustomer,  String? quantityPickerUnit,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewBillState() when $default != null:
return $default(_that.loaderState,_that.billingMode,_that.selectedCategory,_that.selectedCategoryId,_that.searchQuery,_that.isSearchExpanded,_that.isCartExpanded,_that.categories,_that.products,_that.cart,_that.paymentMethod,_that.billNumber,_that.isSavingBill,_that.discountAmount,_that.currentPage,_that.totalPages,_that.isLoadingMore,_that.isSearchingProducts,_that.paymentStatus,_that.receivedAmount,_that.selectedCustomer,_that.quantityPickerUnit,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  int billingMode,  String selectedCategory,  int selectedCategoryId,  String searchQuery,  bool isSearchExpanded,  bool isCartExpanded,  List<CategoryWithProductsModel> categories,  List<ProductModel> products,  List<CartItemModel> cart,  String paymentMethod,  int billNumber,  bool isSavingBill,  double discountAmount,  int currentPage,  int totalPages,  bool isLoadingMore,  bool isSearchingProducts,  String paymentStatus,  double receivedAmount,  DropdownCustomerModel? selectedCustomer,  String? quantityPickerUnit,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _NewBillState():
return $default(_that.loaderState,_that.billingMode,_that.selectedCategory,_that.selectedCategoryId,_that.searchQuery,_that.isSearchExpanded,_that.isCartExpanded,_that.categories,_that.products,_that.cart,_that.paymentMethod,_that.billNumber,_that.isSavingBill,_that.discountAmount,_that.currentPage,_that.totalPages,_that.isLoadingMore,_that.isSearchingProducts,_that.paymentStatus,_that.receivedAmount,_that.selectedCustomer,_that.quantityPickerUnit,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  int billingMode,  String selectedCategory,  int selectedCategoryId,  String searchQuery,  bool isSearchExpanded,  bool isCartExpanded,  List<CategoryWithProductsModel> categories,  List<ProductModel> products,  List<CartItemModel> cart,  String paymentMethod,  int billNumber,  bool isSavingBill,  double discountAmount,  int currentPage,  int totalPages,  bool isLoadingMore,  bool isSearchingProducts,  String paymentStatus,  double receivedAmount,  DropdownCustomerModel? selectedCustomer,  String? quantityPickerUnit,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _NewBillState() when $default != null:
return $default(_that.loaderState,_that.billingMode,_that.selectedCategory,_that.selectedCategoryId,_that.searchQuery,_that.isSearchExpanded,_that.isCartExpanded,_that.categories,_that.products,_that.cart,_that.paymentMethod,_that.billNumber,_that.isSavingBill,_that.discountAmount,_that.currentPage,_that.totalPages,_that.isLoadingMore,_that.isSearchingProducts,_that.paymentStatus,_that.receivedAmount,_that.selectedCustomer,_that.quantityPickerUnit,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _NewBillState implements NewBillState {
  const _NewBillState({this.loaderState = LoaderState.loaded, this.billingMode = 0, this.selectedCategory = '', this.selectedCategoryId = 0, this.searchQuery = '', this.isSearchExpanded = false, this.isCartExpanded = false, final  List<CategoryWithProductsModel> categories = const [], final  List<ProductModel> products = const [], final  List<CartItemModel> cart = const [], this.paymentMethod = 'Cash', this.billNumber = 1046, this.isSavingBill = false, this.discountAmount = 0.0, this.currentPage = 1, this.totalPages = 1, this.isLoadingMore = false, this.isSearchingProducts = false, this.paymentStatus = 'Paid', this.receivedAmount = 0.0, this.selectedCustomer, this.quantityPickerUnit, this.errorMessage}): _categories = categories,_products = products,_cart = cart;
  

@override@JsonKey() final  LoaderState loaderState;
@override@JsonKey() final  int billingMode;
@override@JsonKey() final  String selectedCategory;
@override@JsonKey() final  int selectedCategoryId;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  bool isSearchExpanded;
@override@JsonKey() final  bool isCartExpanded;
 final  List<CategoryWithProductsModel> _categories;
@override@JsonKey() List<CategoryWithProductsModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<ProductModel> _products;
@override@JsonKey() List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<CartItemModel> _cart;
@override@JsonKey() List<CartItemModel> get cart {
  if (_cart is EqualUnmodifiableListView) return _cart;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cart);
}

@override@JsonKey() final  String paymentMethod;
@override@JsonKey() final  int billNumber;
@override@JsonKey() final  bool isSavingBill;
@override@JsonKey() final  double discountAmount;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isSearchingProducts;
@override@JsonKey() final  String paymentStatus;
@override@JsonKey() final  double receivedAmount;
@override final  DropdownCustomerModel? selectedCustomer;
@override final  String? quantityPickerUnit;
@override final  String? errorMessage;

/// Create a copy of NewBillState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewBillStateCopyWith<_NewBillState> get copyWith => __$NewBillStateCopyWithImpl<_NewBillState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewBillState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.billingMode, billingMode) || other.billingMode == billingMode)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSearchExpanded, isSearchExpanded) || other.isSearchExpanded == isSearchExpanded)&&(identical(other.isCartExpanded, isCartExpanded) || other.isCartExpanded == isCartExpanded)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._cart, _cart)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.isSavingBill, isSavingBill) || other.isSavingBill == isSavingBill)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSearchingProducts, isSearchingProducts) || other.isSearchingProducts == isSearchingProducts)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.receivedAmount, receivedAmount) || other.receivedAmount == receivedAmount)&&(identical(other.selectedCustomer, selectedCustomer) || other.selectedCustomer == selectedCustomer)&&(identical(other.quantityPickerUnit, quantityPickerUnit) || other.quantityPickerUnit == quantityPickerUnit)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,loaderState,billingMode,selectedCategory,selectedCategoryId,searchQuery,isSearchExpanded,isCartExpanded,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_cart),paymentMethod,billNumber,isSavingBill,discountAmount,currentPage,totalPages,isLoadingMore,isSearchingProducts,paymentStatus,receivedAmount,selectedCustomer,quantityPickerUnit,errorMessage]);

@override
String toString() {
  return 'NewBillState(loaderState: $loaderState, billingMode: $billingMode, selectedCategory: $selectedCategory, selectedCategoryId: $selectedCategoryId, searchQuery: $searchQuery, isSearchExpanded: $isSearchExpanded, isCartExpanded: $isCartExpanded, categories: $categories, products: $products, cart: $cart, paymentMethod: $paymentMethod, billNumber: $billNumber, isSavingBill: $isSavingBill, discountAmount: $discountAmount, currentPage: $currentPage, totalPages: $totalPages, isLoadingMore: $isLoadingMore, isSearchingProducts: $isSearchingProducts, paymentStatus: $paymentStatus, receivedAmount: $receivedAmount, selectedCustomer: $selectedCustomer, quantityPickerUnit: $quantityPickerUnit, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NewBillStateCopyWith<$Res> implements $NewBillStateCopyWith<$Res> {
  factory _$NewBillStateCopyWith(_NewBillState value, $Res Function(_NewBillState) _then) = __$NewBillStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, int billingMode, String selectedCategory, int selectedCategoryId, String searchQuery, bool isSearchExpanded, bool isCartExpanded, List<CategoryWithProductsModel> categories, List<ProductModel> products, List<CartItemModel> cart, String paymentMethod, int billNumber, bool isSavingBill, double discountAmount, int currentPage, int totalPages, bool isLoadingMore, bool isSearchingProducts, String paymentStatus, double receivedAmount, DropdownCustomerModel? selectedCustomer, String? quantityPickerUnit, String? errorMessage
});




}
/// @nodoc
class __$NewBillStateCopyWithImpl<$Res>
    implements _$NewBillStateCopyWith<$Res> {
  __$NewBillStateCopyWithImpl(this._self, this._then);

  final _NewBillState _self;
  final $Res Function(_NewBillState) _then;

/// Create a copy of NewBillState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? billingMode = null,Object? selectedCategory = null,Object? selectedCategoryId = null,Object? searchQuery = null,Object? isSearchExpanded = null,Object? isCartExpanded = null,Object? categories = null,Object? products = null,Object? cart = null,Object? paymentMethod = null,Object? billNumber = null,Object? isSavingBill = null,Object? discountAmount = null,Object? currentPage = null,Object? totalPages = null,Object? isLoadingMore = null,Object? isSearchingProducts = null,Object? paymentStatus = null,Object? receivedAmount = null,Object? selectedCustomer = freezed,Object? quantityPickerUnit = freezed,Object? errorMessage = freezed,}) {
  return _then(_NewBillState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,billingMode: null == billingMode ? _self.billingMode : billingMode // ignore: cast_nullable_to_non_nullable
as int,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSearchExpanded: null == isSearchExpanded ? _self.isSearchExpanded : isSearchExpanded // ignore: cast_nullable_to_non_nullable
as bool,isCartExpanded: null == isCartExpanded ? _self.isCartExpanded : isCartExpanded // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryWithProductsModel>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,cart: null == cart ? _self._cart : cart // ignore: cast_nullable_to_non_nullable
as List<CartItemModel>,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as int,isSavingBill: null == isSavingBill ? _self.isSavingBill : isSavingBill // ignore: cast_nullable_to_non_nullable
as bool,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSearchingProducts: null == isSearchingProducts ? _self.isSearchingProducts : isSearchingProducts // ignore: cast_nullable_to_non_nullable
as bool,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,receivedAmount: null == receivedAmount ? _self.receivedAmount : receivedAmount // ignore: cast_nullable_to_non_nullable
as double,selectedCustomer: freezed == selectedCustomer ? _self.selectedCustomer : selectedCustomer // ignore: cast_nullable_to_non_nullable
as DropdownCustomerModel?,quantityPickerUnit: freezed == quantityPickerUnit ? _self.quantityPickerUnit : quantityPickerUnit // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
