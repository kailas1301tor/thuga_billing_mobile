// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductsState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  ProductResponse? get response => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int? get selectedCategoryId => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get saveProductLoader => throw _privateConstructorUsedError;
  bool get updateProductLoader => throw _privateConstructorUsedError;
  bool get deleteProductLoader => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  String get sort => throw _privateConstructorUsedError;
  int? get filterCategoryId => throw _privateConstructorUsedError;
  bool get isQuickProduct => throw _privateConstructorUsedError;
  String? get selectedImagePath => throw _privateConstructorUsedError;
  List<int> get togglingProductIds => throw _privateConstructorUsedError;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductsStateCopyWith<ProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsStateCopyWith<$Res> {
  factory $ProductsStateCopyWith(
    ProductsState value,
    $Res Function(ProductsState) then,
  ) = _$ProductsStateCopyWithImpl<$Res, ProductsState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    ProductResponse? response,
    String? errorMessage,
    int? selectedCategoryId,
    String searchQuery,
    bool saveProductLoader,
    bool updateProductLoader,
    bool deleteProductLoader,
    int page,
    int pageSize,
    String sort,
    int? filterCategoryId,
    bool isQuickProduct,
    String? selectedImagePath,
    List<int> togglingProductIds,
  });
}

/// @nodoc
class _$ProductsStateCopyWithImpl<$Res, $Val extends ProductsState>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? response = freezed,
    Object? errorMessage = freezed,
    Object? selectedCategoryId = freezed,
    Object? searchQuery = null,
    Object? saveProductLoader = null,
    Object? updateProductLoader = null,
    Object? deleteProductLoader = null,
    Object? page = null,
    Object? pageSize = null,
    Object? sort = null,
    Object? filterCategoryId = freezed,
    Object? isQuickProduct = null,
    Object? selectedImagePath = freezed,
    Object? togglingProductIds = null,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            response: freezed == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as ProductResponse?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedCategoryId: freezed == selectedCategoryId
                ? _value.selectedCategoryId
                : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            saveProductLoader: null == saveProductLoader
                ? _value.saveProductLoader
                : saveProductLoader // ignore: cast_nullable_to_non_nullable
                      as bool,
            updateProductLoader: null == updateProductLoader
                ? _value.updateProductLoader
                : updateProductLoader // ignore: cast_nullable_to_non_nullable
                      as bool,
            deleteProductLoader: null == deleteProductLoader
                ? _value.deleteProductLoader
                : deleteProductLoader // ignore: cast_nullable_to_non_nullable
                      as bool,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            sort: null == sort
                ? _value.sort
                : sort // ignore: cast_nullable_to_non_nullable
                      as String,
            filterCategoryId: freezed == filterCategoryId
                ? _value.filterCategoryId
                : filterCategoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            isQuickProduct: null == isQuickProduct
                ? _value.isQuickProduct
                : isQuickProduct // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedImagePath: freezed == selectedImagePath
                ? _value.selectedImagePath
                : selectedImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            togglingProductIds: null == togglingProductIds
                ? _value.togglingProductIds
                : togglingProductIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductsStateImplCopyWith<$Res>
    implements $ProductsStateCopyWith<$Res> {
  factory _$$ProductsStateImplCopyWith(
    _$ProductsStateImpl value,
    $Res Function(_$ProductsStateImpl) then,
  ) = __$$ProductsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    ProductResponse? response,
    String? errorMessage,
    int? selectedCategoryId,
    String searchQuery,
    bool saveProductLoader,
    bool updateProductLoader,
    bool deleteProductLoader,
    int page,
    int pageSize,
    String sort,
    int? filterCategoryId,
    bool isQuickProduct,
    String? selectedImagePath,
    List<int> togglingProductIds,
  });
}

/// @nodoc
class __$$ProductsStateImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$ProductsStateImpl>
    implements _$$ProductsStateImplCopyWith<$Res> {
  __$$ProductsStateImplCopyWithImpl(
    _$ProductsStateImpl _value,
    $Res Function(_$ProductsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? response = freezed,
    Object? errorMessage = freezed,
    Object? selectedCategoryId = freezed,
    Object? searchQuery = null,
    Object? saveProductLoader = null,
    Object? updateProductLoader = null,
    Object? deleteProductLoader = null,
    Object? page = null,
    Object? pageSize = null,
    Object? sort = null,
    Object? filterCategoryId = freezed,
    Object? isQuickProduct = null,
    Object? selectedImagePath = freezed,
    Object? togglingProductIds = null,
  }) {
    return _then(
      _$ProductsStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        response: freezed == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as ProductResponse?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedCategoryId: freezed == selectedCategoryId
            ? _value.selectedCategoryId
            : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        saveProductLoader: null == saveProductLoader
            ? _value.saveProductLoader
            : saveProductLoader // ignore: cast_nullable_to_non_nullable
                  as bool,
        updateProductLoader: null == updateProductLoader
            ? _value.updateProductLoader
            : updateProductLoader // ignore: cast_nullable_to_non_nullable
                  as bool,
        deleteProductLoader: null == deleteProductLoader
            ? _value.deleteProductLoader
            : deleteProductLoader // ignore: cast_nullable_to_non_nullable
                  as bool,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        sort: null == sort
            ? _value.sort
            : sort // ignore: cast_nullable_to_non_nullable
                  as String,
        filterCategoryId: freezed == filterCategoryId
            ? _value.filterCategoryId
            : filterCategoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        isQuickProduct: null == isQuickProduct
            ? _value.isQuickProduct
            : isQuickProduct // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedImagePath: freezed == selectedImagePath
            ? _value.selectedImagePath
            : selectedImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        togglingProductIds: null == togglingProductIds
            ? _value._togglingProductIds
            : togglingProductIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc

class _$ProductsStateImpl implements _ProductsState {
  const _$ProductsStateImpl({
    this.loaderState = LoaderState.loading,
    this.response,
    this.errorMessage,
    this.selectedCategoryId,
    this.searchQuery = '',
    this.saveProductLoader = false,
    this.updateProductLoader = false,
    this.deleteProductLoader = false,
    this.page = 1,
    this.pageSize = 10,
    this.sort = 'lowest',
    this.filterCategoryId,
    this.isQuickProduct = true,
    this.selectedImagePath,
    final List<int> togglingProductIds = const [],
  }) : _togglingProductIds = togglingProductIds;

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  final ProductResponse? response;
  @override
  final String? errorMessage;
  @override
  final int? selectedCategoryId;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool saveProductLoader;
  @override
  @JsonKey()
  final bool updateProductLoader;
  @override
  @JsonKey()
  final bool deleteProductLoader;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final String sort;
  @override
  final int? filterCategoryId;
  @override
  @JsonKey()
  final bool isQuickProduct;
  @override
  final String? selectedImagePath;
  final List<int> _togglingProductIds;
  @override
  @JsonKey()
  List<int> get togglingProductIds {
    if (_togglingProductIds is EqualUnmodifiableListView)
      return _togglingProductIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_togglingProductIds);
  }

  @override
  String toString() {
    return 'ProductsState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, selectedCategoryId: $selectedCategoryId, searchQuery: $searchQuery, saveProductLoader: $saveProductLoader, updateProductLoader: $updateProductLoader, deleteProductLoader: $deleteProductLoader, page: $page, pageSize: $pageSize, sort: $sort, filterCategoryId: $filterCategoryId, isQuickProduct: $isQuickProduct, selectedImagePath: $selectedImagePath, togglingProductIds: $togglingProductIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.saveProductLoader, saveProductLoader) ||
                other.saveProductLoader == saveProductLoader) &&
            (identical(other.updateProductLoader, updateProductLoader) ||
                other.updateProductLoader == updateProductLoader) &&
            (identical(other.deleteProductLoader, deleteProductLoader) ||
                other.deleteProductLoader == deleteProductLoader) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.filterCategoryId, filterCategoryId) ||
                other.filterCategoryId == filterCategoryId) &&
            (identical(other.isQuickProduct, isQuickProduct) ||
                other.isQuickProduct == isQuickProduct) &&
            (identical(other.selectedImagePath, selectedImagePath) ||
                other.selectedImagePath == selectedImagePath) &&
            const DeepCollectionEquality().equals(
              other._togglingProductIds,
              _togglingProductIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    response,
    errorMessage,
    selectedCategoryId,
    searchQuery,
    saveProductLoader,
    updateProductLoader,
    deleteProductLoader,
    page,
    pageSize,
    sort,
    filterCategoryId,
    isQuickProduct,
    selectedImagePath,
    const DeepCollectionEquality().hash(_togglingProductIds),
  );

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      __$$ProductsStateImplCopyWithImpl<_$ProductsStateImpl>(this, _$identity);
}

abstract class _ProductsState implements ProductsState {
  const factory _ProductsState({
    final LoaderState loaderState,
    final ProductResponse? response,
    final String? errorMessage,
    final int? selectedCategoryId,
    final String searchQuery,
    final bool saveProductLoader,
    final bool updateProductLoader,
    final bool deleteProductLoader,
    final int page,
    final int pageSize,
    final String sort,
    final int? filterCategoryId,
    final bool isQuickProduct,
    final String? selectedImagePath,
    final List<int> togglingProductIds,
  }) = _$ProductsStateImpl;

  @override
  LoaderState get loaderState;
  @override
  ProductResponse? get response;
  @override
  String? get errorMessage;
  @override
  int? get selectedCategoryId;
  @override
  String get searchQuery;
  @override
  bool get saveProductLoader;
  @override
  bool get updateProductLoader;
  @override
  bool get deleteProductLoader;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  String get sort;
  @override
  int? get filterCategoryId;
  @override
  bool get isQuickProduct;
  @override
  String? get selectedImagePath;
  @override
  List<int> get togglingProductIds;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
