// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CategoriesState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  CategoryResponse? get response => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get saveCategoryLoader => throw _privateConstructorUsedError;
  bool get updateCategoryLoader => throw _privateConstructorUsedError;
  bool get deleteCategoryLoader => throw _privateConstructorUsedError;

  /// Create a copy of CategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoriesStateCopyWith<CategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesStateCopyWith<$Res> {
  factory $CategoriesStateCopyWith(
    CategoriesState value,
    $Res Function(CategoriesState) then,
  ) = _$CategoriesStateCopyWithImpl<$Res, CategoriesState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    CategoryResponse? response,
    String? errorMessage,
    String searchQuery,
    bool saveCategoryLoader,
    bool updateCategoryLoader,
    bool deleteCategoryLoader,
  });
}

/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res, $Val extends CategoriesState>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? response = freezed,
    Object? errorMessage = freezed,
    Object? searchQuery = null,
    Object? saveCategoryLoader = null,
    Object? updateCategoryLoader = null,
    Object? deleteCategoryLoader = null,
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
                      as CategoryResponse?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            saveCategoryLoader: null == saveCategoryLoader
                ? _value.saveCategoryLoader
                : saveCategoryLoader // ignore: cast_nullable_to_non_nullable
                      as bool,
            updateCategoryLoader: null == updateCategoryLoader
                ? _value.updateCategoryLoader
                : updateCategoryLoader // ignore: cast_nullable_to_non_nullable
                      as bool,
            deleteCategoryLoader: null == deleteCategoryLoader
                ? _value.deleteCategoryLoader
                : deleteCategoryLoader // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoriesStateImplCopyWith<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  factory _$$CategoriesStateImplCopyWith(
    _$CategoriesStateImpl value,
    $Res Function(_$CategoriesStateImpl) then,
  ) = __$$CategoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    CategoryResponse? response,
    String? errorMessage,
    String searchQuery,
    bool saveCategoryLoader,
    bool updateCategoryLoader,
    bool deleteCategoryLoader,
  });
}

/// @nodoc
class __$$CategoriesStateImplCopyWithImpl<$Res>
    extends _$CategoriesStateCopyWithImpl<$Res, _$CategoriesStateImpl>
    implements _$$CategoriesStateImplCopyWith<$Res> {
  __$$CategoriesStateImplCopyWithImpl(
    _$CategoriesStateImpl _value,
    $Res Function(_$CategoriesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? response = freezed,
    Object? errorMessage = freezed,
    Object? searchQuery = null,
    Object? saveCategoryLoader = null,
    Object? updateCategoryLoader = null,
    Object? deleteCategoryLoader = null,
  }) {
    return _then(
      _$CategoriesStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        response: freezed == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as CategoryResponse?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        saveCategoryLoader: null == saveCategoryLoader
            ? _value.saveCategoryLoader
            : saveCategoryLoader // ignore: cast_nullable_to_non_nullable
                  as bool,
        updateCategoryLoader: null == updateCategoryLoader
            ? _value.updateCategoryLoader
            : updateCategoryLoader // ignore: cast_nullable_to_non_nullable
                  as bool,
        deleteCategoryLoader: null == deleteCategoryLoader
            ? _value.deleteCategoryLoader
            : deleteCategoryLoader // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$CategoriesStateImpl implements _CategoriesState {
  const _$CategoriesStateImpl({
    this.loaderState = LoaderState.loading,
    this.response,
    this.errorMessage,
    this.searchQuery = '',
    this.saveCategoryLoader = false,
    this.updateCategoryLoader = false,
    this.deleteCategoryLoader = false,
  });

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  final CategoryResponse? response;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool saveCategoryLoader;
  @override
  @JsonKey()
  final bool updateCategoryLoader;
  @override
  @JsonKey()
  final bool deleteCategoryLoader;

  @override
  String toString() {
    return 'CategoriesState(loaderState: $loaderState, response: $response, errorMessage: $errorMessage, searchQuery: $searchQuery, saveCategoryLoader: $saveCategoryLoader, updateCategoryLoader: $updateCategoryLoader, deleteCategoryLoader: $deleteCategoryLoader)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.saveCategoryLoader, saveCategoryLoader) ||
                other.saveCategoryLoader == saveCategoryLoader) &&
            (identical(other.updateCategoryLoader, updateCategoryLoader) ||
                other.updateCategoryLoader == updateCategoryLoader) &&
            (identical(other.deleteCategoryLoader, deleteCategoryLoader) ||
                other.deleteCategoryLoader == deleteCategoryLoader));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    response,
    errorMessage,
    searchQuery,
    saveCategoryLoader,
    updateCategoryLoader,
    deleteCategoryLoader,
  );

  /// Create a copy of CategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesStateImplCopyWith<_$CategoriesStateImpl> get copyWith =>
      __$$CategoriesStateImplCopyWithImpl<_$CategoriesStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CategoriesState implements CategoriesState {
  const factory _CategoriesState({
    final LoaderState loaderState,
    final CategoryResponse? response,
    final String? errorMessage,
    final String searchQuery,
    final bool saveCategoryLoader,
    final bool updateCategoryLoader,
    final bool deleteCategoryLoader,
  }) = _$CategoriesStateImpl;

  @override
  LoaderState get loaderState;
  @override
  CategoryResponse? get response;
  @override
  String? get errorMessage;
  @override
  String get searchQuery;
  @override
  bool get saveCategoryLoader;
  @override
  bool get updateCategoryLoader;
  @override
  bool get deleteCategoryLoader;

  /// Create a copy of CategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesStateImplCopyWith<_$CategoriesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
