// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bills_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BillsState {
  LoaderState get loaderState => throw _privateConstructorUsedError;
  BillsResponseModel? get data => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  String get dateRangeFilter => throw _privateConstructorUsedError;
  bool get isNewestFirst => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  int? get updatingBillId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of BillsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillsStateCopyWith<BillsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillsStateCopyWith<$Res> {
  factory $BillsStateCopyWith(
    BillsState value,
    $Res Function(BillsState) then,
  ) = _$BillsStateCopyWithImpl<$Res, BillsState>;
  @useResult
  $Res call({
    LoaderState loaderState,
    BillsResponseModel? data,
    String searchQuery,
    String dateRangeFilter,
    bool isNewestFirst,
    int currentPage,
    int totalPages,
    int pageSize,
    bool isLoadingMore,
    int? updatingBillId,
    String? errorMessage,
  });
}

/// @nodoc
class _$BillsStateCopyWithImpl<$Res, $Val extends BillsState>
    implements $BillsStateCopyWith<$Res> {
  _$BillsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? data = freezed,
    Object? searchQuery = null,
    Object? dateRangeFilter = null,
    Object? isNewestFirst = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? isLoadingMore = null,
    Object? updatingBillId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            loaderState: null == loaderState
                ? _value.loaderState
                : loaderState // ignore: cast_nullable_to_non_nullable
                      as LoaderState,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as BillsResponseModel?,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            dateRangeFilter: null == dateRangeFilter
                ? _value.dateRangeFilter
                : dateRangeFilter // ignore: cast_nullable_to_non_nullable
                      as String,
            isNewestFirst: null == isNewestFirst
                ? _value.isNewestFirst
                : isNewestFirst // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            updatingBillId: freezed == updatingBillId
                ? _value.updatingBillId
                : updatingBillId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$BillsStateImplCopyWith<$Res>
    implements $BillsStateCopyWith<$Res> {
  factory _$$BillsStateImplCopyWith(
    _$BillsStateImpl value,
    $Res Function(_$BillsStateImpl) then,
  ) = __$$BillsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LoaderState loaderState,
    BillsResponseModel? data,
    String searchQuery,
    String dateRangeFilter,
    bool isNewestFirst,
    int currentPage,
    int totalPages,
    int pageSize,
    bool isLoadingMore,
    int? updatingBillId,
    String? errorMessage,
  });
}

/// @nodoc
class __$$BillsStateImplCopyWithImpl<$Res>
    extends _$BillsStateCopyWithImpl<$Res, _$BillsStateImpl>
    implements _$$BillsStateImplCopyWith<$Res> {
  __$$BillsStateImplCopyWithImpl(
    _$BillsStateImpl _value,
    $Res Function(_$BillsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loaderState = null,
    Object? data = freezed,
    Object? searchQuery = null,
    Object? dateRangeFilter = null,
    Object? isNewestFirst = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? isLoadingMore = null,
    Object? updatingBillId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$BillsStateImpl(
        loaderState: null == loaderState
            ? _value.loaderState
            : loaderState // ignore: cast_nullable_to_non_nullable
                  as LoaderState,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as BillsResponseModel?,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        dateRangeFilter: null == dateRangeFilter
            ? _value.dateRangeFilter
            : dateRangeFilter // ignore: cast_nullable_to_non_nullable
                  as String,
        isNewestFirst: null == isNewestFirst
            ? _value.isNewestFirst
            : isNewestFirst // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        updatingBillId: freezed == updatingBillId
            ? _value.updatingBillId
            : updatingBillId // ignore: cast_nullable_to_non_nullable
                  as int?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$BillsStateImpl implements _BillsState {
  const _$BillsStateImpl({
    this.loaderState = LoaderState.loading,
    this.data,
    this.searchQuery = '',
    this.dateRangeFilter = 'Today',
    this.isNewestFirst = true,
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = 10,
    this.isLoadingMore = false,
    this.updatingBillId,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final LoaderState loaderState;
  @override
  final BillsResponseModel? data;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final String dateRangeFilter;
  @override
  @JsonKey()
  final bool isNewestFirst;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final int? updatingBillId;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'BillsState(loaderState: $loaderState, data: $data, searchQuery: $searchQuery, dateRangeFilter: $dateRangeFilter, isNewestFirst: $isNewestFirst, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, updatingBillId: $updatingBillId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillsStateImpl &&
            (identical(other.loaderState, loaderState) ||
                other.loaderState == loaderState) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.dateRangeFilter, dateRangeFilter) ||
                other.dateRangeFilter == dateRangeFilter) &&
            (identical(other.isNewestFirst, isNewestFirst) ||
                other.isNewestFirst == isNewestFirst) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.updatingBillId, updatingBillId) ||
                other.updatingBillId == updatingBillId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    loaderState,
    data,
    searchQuery,
    dateRangeFilter,
    isNewestFirst,
    currentPage,
    totalPages,
    pageSize,
    isLoadingMore,
    updatingBillId,
    errorMessage,
  );

  /// Create a copy of BillsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillsStateImplCopyWith<_$BillsStateImpl> get copyWith =>
      __$$BillsStateImplCopyWithImpl<_$BillsStateImpl>(this, _$identity);
}

abstract class _BillsState implements BillsState {
  const factory _BillsState({
    final LoaderState loaderState,
    final BillsResponseModel? data,
    final String searchQuery,
    final String dateRangeFilter,
    final bool isNewestFirst,
    final int currentPage,
    final int totalPages,
    final int pageSize,
    final bool isLoadingMore,
    final int? updatingBillId,
    final String? errorMessage,
  }) = _$BillsStateImpl;

  @override
  LoaderState get loaderState;
  @override
  BillsResponseModel? get data;
  @override
  String get searchQuery;
  @override
  String get dateRangeFilter;
  @override
  bool get isNewestFirst;
  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  int get pageSize;
  @override
  bool get isLoadingMore;
  @override
  int? get updatingBillId;
  @override
  String? get errorMessage;

  /// Create a copy of BillsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillsStateImplCopyWith<_$BillsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
