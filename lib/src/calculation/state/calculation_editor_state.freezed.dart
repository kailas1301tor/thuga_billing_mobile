// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CalculationEditorState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  LoaderState get catalogLoaderState => throw _privateConstructorUsedError;
  String? get billId => throw _privateConstructorUsedError;
  String get billName => throw _privateConstructorUsedError;
  List<CalculationCustomerSectionModel> get customerSections =>
      throw _privateConstructorUsedError;
  int? get activeCustomerId => throw _privateConstructorUsedError;
  List<CalculationCategoryModel> get categories =>
      throw _privateConstructorUsedError;
  List<CalculationProductModel> get products =>
      throw _privateConstructorUsedError;
  String get selectedCategory => throw _privateConstructorUsedError;
  int get selectedCategoryId => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CalculationEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalculationEditorStateCopyWith<CalculationEditorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculationEditorStateCopyWith<$Res> {
  factory $CalculationEditorStateCopyWith(
    CalculationEditorState value,
    $Res Function(CalculationEditorState) then,
  ) = _$CalculationEditorStateCopyWithImpl<$Res, CalculationEditorState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    LoaderState catalogLoaderState,
    String? billId,
    String billName,
    List<CalculationCustomerSectionModel> customerSections,
    int? activeCustomerId,
    List<CalculationCategoryModel> categories,
    List<CalculationProductModel> products,
    String selectedCategory,
    int selectedCategoryId,
    String searchQuery,
    bool isSaving,
    String? errorMessage,
  });
}

/// @nodoc
class _$CalculationEditorStateCopyWithImpl<
  $Res,
  $Val extends CalculationEditorState
>
    implements $CalculationEditorStateCopyWith<$Res> {
  _$CalculationEditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalculationEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? catalogLoaderState = null,
    Object? billId = freezed,
    Object? billName = null,
    Object? customerSections = null,
    Object? activeCustomerId = freezed,
    Object? categories = null,
    Object? products = null,
    Object? selectedCategory = null,
    Object? selectedCategoryId = null,
    Object? searchQuery = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            catalogLoaderState: null == catalogLoaderState
                ? _value.catalogLoaderState
                : catalogLoaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            billId: freezed == billId
                ? _value.billId
                : billId // ignore: cast_nullable_to_non_nullable
                      as String?,
            billName: null == billName
                ? _value.billName
                : billName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerSections: null == customerSections
                ? _value.customerSections
                : customerSections // ignore: cast_nullable_to_non_nullable
                      as List<CalculationCustomerSectionModel>,
            activeCustomerId: freezed == activeCustomerId
                ? _value.activeCustomerId
                : activeCustomerId // ignore: cast_nullable_to_non_nullable
                      as int?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<CalculationCategoryModel>,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<CalculationProductModel>,
            selectedCategory: null == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedCategoryId: null == selectedCategoryId
                ? _value.selectedCategoryId
                : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$CalculationEditorStateImplCopyWith<$Res>
    implements $CalculationEditorStateCopyWith<$Res> {
  factory _$$CalculationEditorStateImplCopyWith(
    _$CalculationEditorStateImpl value,
    $Res Function(_$CalculationEditorStateImpl) then,
  ) = __$$CalculationEditorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    LoaderState catalogLoaderState,
    String? billId,
    String billName,
    List<CalculationCustomerSectionModel> customerSections,
    int? activeCustomerId,
    List<CalculationCategoryModel> categories,
    List<CalculationProductModel> products,
    String selectedCategory,
    int selectedCategoryId,
    String searchQuery,
    bool isSaving,
    String? errorMessage,
  });
}

/// @nodoc
class __$$CalculationEditorStateImplCopyWithImpl<$Res>
    extends
        _$CalculationEditorStateCopyWithImpl<$Res, _$CalculationEditorStateImpl>
    implements _$$CalculationEditorStateImplCopyWith<$Res> {
  __$$CalculationEditorStateImplCopyWithImpl(
    _$CalculationEditorStateImpl _value,
    $Res Function(_$CalculationEditorStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalculationEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? catalogLoaderState = null,
    Object? billId = freezed,
    Object? billName = null,
    Object? customerSections = null,
    Object? activeCustomerId = freezed,
    Object? categories = null,
    Object? products = null,
    Object? selectedCategory = null,
    Object? selectedCategoryId = null,
    Object? searchQuery = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CalculationEditorStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        catalogLoaderState: null == catalogLoaderState
            ? _value.catalogLoaderState
            : catalogLoaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        billId: freezed == billId
            ? _value.billId
            : billId // ignore: cast_nullable_to_non_nullable
                  as String?,
        billName: null == billName
            ? _value.billName
            : billName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerSections: null == customerSections
            ? _value._customerSections
            : customerSections // ignore: cast_nullable_to_non_nullable
                  as List<CalculationCustomerSectionModel>,
        activeCustomerId: freezed == activeCustomerId
            ? _value.activeCustomerId
            : activeCustomerId // ignore: cast_nullable_to_non_nullable
                  as int?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<CalculationCategoryModel>,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<CalculationProductModel>,
        selectedCategory: null == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedCategoryId: null == selectedCategoryId
            ? _value.selectedCategoryId
            : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CalculationEditorStateImpl implements _CalculationEditorState {
  const _$CalculationEditorStateImpl({
    this.loaderState = LoaderState.loaded,
    this.catalogLoaderState = LoaderState.loading,
    this.billId,
    this.billName = '',
    final List<CalculationCustomerSectionModel> customerSections = const [],
    this.activeCustomerId,
    final List<CalculationCategoryModel> categories = const [],
    final List<CalculationProductModel> products = const [],
    this.selectedCategory = '',
    this.selectedCategoryId = 0,
    this.searchQuery = '',
    this.isSaving = false,
    this.errorMessage,
  }) : _customerSections = customerSections,
       _categories = categories,
       _products = products;

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  @JsonKey()
  final LoaderState catalogLoaderState;
  @override
  final String? billId;
  @override
  @JsonKey()
  final String billName;
  final List<CalculationCustomerSectionModel> _customerSections;
  @override
  @JsonKey()
  List<CalculationCustomerSectionModel> get customerSections {
    if (_customerSections is EqualUnmodifiableListView)
      return _customerSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerSections);
  }

  @override
  final int? activeCustomerId;
  final List<CalculationCategoryModel> _categories;
  @override
  @JsonKey()
  List<CalculationCategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<CalculationProductModel> _products;
  @override
  @JsonKey()
  List<CalculationProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @JsonKey()
  final String selectedCategory;
  @override
  @JsonKey()
  final int selectedCategoryId;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CalculationEditorState(loaderState: $loaderState, catalogLoaderState: $catalogLoaderState, billId: $billId, billName: $billName, customerSections: $customerSections, activeCustomerId: $activeCustomerId, categories: $categories, products: $products, selectedCategory: $selectedCategory, selectedCategoryId: $selectedCategoryId, searchQuery: $searchQuery, isSaving: $isSaving, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculationEditorStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.catalogLoaderState, catalogLoaderState) ||
                other.catalogLoaderState == catalogLoaderState) &&
            (identical(other.billId, billId) || other.billId == billId) &&
            (identical(other.billName, billName) ||
                other.billName == billName) &&
            const DeepCollectionEquality().equals(
              other._customerSections,
              _customerSections,
            ) &&
            (identical(other.activeCustomerId, activeCustomerId) ||
                other.activeCustomerId == activeCustomerId) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    catalogLoaderState,
    billId,
    billName,
    const DeepCollectionEquality().hash(_customerSections),
    activeCustomerId,
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_products),
    selectedCategory,
    selectedCategoryId,
    searchQuery,
    isSaving,
    errorMessage,
  );

  /// Create a copy of CalculationEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculationEditorStateImplCopyWith<_$CalculationEditorStateImpl>
  get copyWith =>
      __$$CalculationEditorStateImplCopyWithImpl<_$CalculationEditorStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CalculationEditorState implements CalculationEditorState {
  const factory _CalculationEditorState({
    final LoaderState loaderState,
    final LoaderState catalogLoaderState,
    final String? billId,
    final String billName,
    final List<CalculationCustomerSectionModel> customerSections,
    final int? activeCustomerId,
    final List<CalculationCategoryModel> categories,
    final List<CalculationProductModel> products,
    final String selectedCategory,
    final int selectedCategoryId,
    final String searchQuery,
    final bool isSaving,
    final String? errorMessage,
  }) = _$CalculationEditorStateImpl;

  @override
  LoaderState get loaderState;
  @override
  LoaderState get catalogLoaderState;
  @override
  String? get billId;
  @override
  String get billName;
  @override
  List<CalculationCustomerSectionModel> get customerSections;
  @override
  int? get activeCustomerId;
  @override
  List<CalculationCategoryModel> get categories;
  @override
  List<CalculationProductModel> get products;
  @override
  String get selectedCategory;
  @override
  int get selectedCategoryId;
  @override
  String get searchQuery;
  @override
  bool get isSaving;
  @override
  String? get errorMessage;

  /// Create a copy of CalculationEditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalculationEditorStateImplCopyWith<_$CalculationEditorStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
