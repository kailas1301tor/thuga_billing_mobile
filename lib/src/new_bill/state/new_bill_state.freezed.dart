// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_bill_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NewBillState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  int get billingMode =>
      throw _privateConstructorUsedError; // 0: Quick Tap, 1: Amount Entry
  String get selectedCategory => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get isSearchExpanded => throw _privateConstructorUsedError;
  bool get isCartExpanded => throw _privateConstructorUsedError;
  List<CategoryWithProductsModel> get categories =>
      throw _privateConstructorUsedError;
  List<ProductModel> get products => throw _privateConstructorUsedError;
  List<CartItemModel> get cart => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  int get billNumber => throw _privateConstructorUsedError;
  bool get isSavingBill => throw _privateConstructorUsedError;
  DropdownCustomerModel? get selectedCustomer =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of NewBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewBillStateCopyWith<NewBillState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewBillStateCopyWith<$Res> {
  factory $NewBillStateCopyWith(
    NewBillState value,
    $Res Function(NewBillState) then,
  ) = _$NewBillStateCopyWithImpl<$Res, NewBillState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    int billingMode,
    String selectedCategory,
    String searchQuery,
    bool isSearchExpanded,
    bool isCartExpanded,
    List<CategoryWithProductsModel> categories,
    List<ProductModel> products,
    List<CartItemModel> cart,
    String paymentMethod,
    int billNumber,
    bool isSavingBill,
    DropdownCustomerModel? selectedCustomer,
    String? errorMessage,
  });
}

/// @nodoc
class _$NewBillStateCopyWithImpl<$Res, $Val extends NewBillState>
    implements $NewBillStateCopyWith<$Res> {
  _$NewBillStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? billingMode = null,
    Object? selectedCategory = null,
    Object? searchQuery = null,
    Object? isSearchExpanded = null,
    Object? isCartExpanded = null,
    Object? categories = null,
    Object? products = null,
    Object? cart = null,
    Object? paymentMethod = null,
    Object? billNumber = null,
    Object? isSavingBill = null,
    Object? selectedCustomer = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            billingMode: null == billingMode
                ? _value.billingMode
                : billingMode // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedCategory: null == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as String,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            isSearchExpanded: null == isSearchExpanded
                ? _value.isSearchExpanded
                : isSearchExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCartExpanded: null == isCartExpanded
                ? _value.isCartExpanded
                : isCartExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<CategoryWithProductsModel>,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<ProductModel>,
            cart: null == cart
                ? _value.cart
                : cart // ignore: cast_nullable_to_non_nullable
                      as List<CartItemModel>,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            billNumber: null == billNumber
                ? _value.billNumber
                : billNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            isSavingBill: null == isSavingBill
                ? _value.isSavingBill
                : isSavingBill // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedCustomer: freezed == selectedCustomer
                ? _value.selectedCustomer
                : selectedCustomer // ignore: cast_nullable_to_non_nullable
                      as DropdownCustomerModel?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewBillStateImplCopyWith<$Res>
    implements $NewBillStateCopyWith<$Res> {
  factory _$$NewBillStateImplCopyWith(
    _$NewBillStateImpl value,
    $Res Function(_$NewBillStateImpl) then,
  ) = __$$NewBillStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    int billingMode,
    String selectedCategory,
    String searchQuery,
    bool isSearchExpanded,
    bool isCartExpanded,
    List<CategoryWithProductsModel> categories,
    List<ProductModel> products,
    List<CartItemModel> cart,
    String paymentMethod,
    int billNumber,
    bool isSavingBill,
    DropdownCustomerModel? selectedCustomer,
    String? errorMessage,
  });
}

/// @nodoc
class __$$NewBillStateImplCopyWithImpl<$Res>
    extends _$NewBillStateCopyWithImpl<$Res, _$NewBillStateImpl>
    implements _$$NewBillStateImplCopyWith<$Res> {
  __$$NewBillStateImplCopyWithImpl(
    _$NewBillStateImpl _value,
    $Res Function(_$NewBillStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? billingMode = null,
    Object? selectedCategory = null,
    Object? searchQuery = null,
    Object? isSearchExpanded = null,
    Object? isCartExpanded = null,
    Object? categories = null,
    Object? products = null,
    Object? cart = null,
    Object? paymentMethod = null,
    Object? billNumber = null,
    Object? isSavingBill = null,
    Object? selectedCustomer = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$NewBillStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        billingMode: null == billingMode
            ? _value.billingMode
            : billingMode // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedCategory: null == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as String,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        isSearchExpanded: null == isSearchExpanded
            ? _value.isSearchExpanded
            : isSearchExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCartExpanded: null == isCartExpanded
            ? _value.isCartExpanded
            : isCartExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<CategoryWithProductsModel>,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<ProductModel>,
        cart: null == cart
            ? _value._cart
            : cart // ignore: cast_nullable_to_non_nullable
                  as List<CartItemModel>,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        billNumber: null == billNumber
            ? _value.billNumber
            : billNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        isSavingBill: null == isSavingBill
            ? _value.isSavingBill
            : isSavingBill // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedCustomer: freezed == selectedCustomer
            ? _value.selectedCustomer
            : selectedCustomer // ignore: cast_nullable_to_non_nullable
                  as DropdownCustomerModel?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NewBillStateImpl implements _NewBillState {
  const _$NewBillStateImpl({
    this.loaderState = LoaderState.loaded,
    this.billingMode = 0,
    this.selectedCategory = '',
    this.searchQuery = '',
    this.isSearchExpanded = false,
    this.isCartExpanded = false,
    final List<CategoryWithProductsModel> categories = const [],
    final List<ProductModel> products = const [],
    final List<CartItemModel> cart = const [],
    this.paymentMethod = 'Cash',
    this.billNumber = 1046,
    this.isSavingBill = false,
    this.selectedCustomer,
    this.errorMessage,
  }) : _categories = categories,
       _products = products,
       _cart = cart;

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  @JsonKey()
  final int billingMode;
  // 0: Quick Tap, 1: Amount Entry
  @override
  @JsonKey()
  final String selectedCategory;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool isSearchExpanded;
  @override
  @JsonKey()
  final bool isCartExpanded;
  final List<CategoryWithProductsModel> _categories;
  @override
  @JsonKey()
  List<CategoryWithProductsModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<ProductModel> _products;
  @override
  @JsonKey()
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<CartItemModel> _cart;
  @override
  @JsonKey()
  List<CartItemModel> get cart {
    if (_cart is EqualUnmodifiableListView) return _cart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cart);
  }

  @override
  @JsonKey()
  final String paymentMethod;
  @override
  @JsonKey()
  final int billNumber;
  @override
  @JsonKey()
  final bool isSavingBill;
  @override
  final DropdownCustomerModel? selectedCustomer;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'NewBillState(loaderState: $loaderState, billingMode: $billingMode, selectedCategory: $selectedCategory, searchQuery: $searchQuery, isSearchExpanded: $isSearchExpanded, isCartExpanded: $isCartExpanded, categories: $categories, products: $products, cart: $cart, paymentMethod: $paymentMethod, billNumber: $billNumber, isSavingBill: $isSavingBill, selectedCustomer: $selectedCustomer, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewBillStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.billingMode, billingMode) ||
                other.billingMode == billingMode) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isSearchExpanded, isSearchExpanded) ||
                other.isSearchExpanded == isSearchExpanded) &&
            (identical(other.isCartExpanded, isCartExpanded) ||
                other.isCartExpanded == isCartExpanded) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._cart, _cart) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.billNumber, billNumber) ||
                other.billNumber == billNumber) &&
            (identical(other.isSavingBill, isSavingBill) ||
                other.isSavingBill == isSavingBill) &&
            (identical(other.selectedCustomer, selectedCustomer) ||
                other.selectedCustomer == selectedCustomer) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    billingMode,
    selectedCategory,
    searchQuery,
    isSearchExpanded,
    isCartExpanded,
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_cart),
    paymentMethod,
    billNumber,
    isSavingBill,
    selectedCustomer,
    errorMessage,
  );

  /// Create a copy of NewBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewBillStateImplCopyWith<_$NewBillStateImpl> get copyWith =>
      __$$NewBillStateImplCopyWithImpl<_$NewBillStateImpl>(this, _$identity);
}

abstract class _NewBillState implements NewBillState {
  const factory _NewBillState({
    final LoaderState loaderState,
    final int billingMode,
    final String selectedCategory,
    final String searchQuery,
    final bool isSearchExpanded,
    final bool isCartExpanded,
    final List<CategoryWithProductsModel> categories,
    final List<ProductModel> products,
    final List<CartItemModel> cart,
    final String paymentMethod,
    final int billNumber,
    final bool isSavingBill,
    final DropdownCustomerModel? selectedCustomer,
    final String? errorMessage,
  }) = _$NewBillStateImpl;

  @override
  LoaderState get loaderState;
  @override
  int get billingMode; // 0: Quick Tap, 1: Amount Entry
  @override
  String get selectedCategory;
  @override
  String get searchQuery;
  @override
  bool get isSearchExpanded;
  @override
  bool get isCartExpanded;
  @override
  List<CategoryWithProductsModel> get categories;
  @override
  List<ProductModel> get products;
  @override
  List<CartItemModel> get cart;
  @override
  String get paymentMethod;
  @override
  int get billNumber;
  @override
  bool get isSavingBill;
  @override
  DropdownCustomerModel? get selectedCustomer;
  @override
  String? get errorMessage;

  /// Create a copy of NewBillState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewBillStateImplCopyWith<_$NewBillStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
