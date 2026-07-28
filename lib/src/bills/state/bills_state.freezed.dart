// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bills_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillsState {

 LoaderState get loaderState; BillsResponseModel? get data; String get searchQuery; String get dateRangeFilter; bool get isNewestFirst; int get currentPage; int get totalPages; int get pageSize; bool get isLoadingMore; int? get updatingBillId; String? get errorMessage;
/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillsStateCopyWith<BillsState> get copyWith => _$BillsStateCopyWithImpl<BillsState>(this as BillsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.data, data) || other.data == data)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.dateRangeFilter, dateRangeFilter) || other.dateRangeFilter == dateRangeFilter)&&(identical(other.isNewestFirst, isNewestFirst) || other.isNewestFirst == isNewestFirst)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.updatingBillId, updatingBillId) || other.updatingBillId == updatingBillId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,data,searchQuery,dateRangeFilter,isNewestFirst,currentPage,totalPages,pageSize,isLoadingMore,updatingBillId,errorMessage);

@override
String toString() {
  return 'BillsState(loaderState: $loaderState, data: $data, searchQuery: $searchQuery, dateRangeFilter: $dateRangeFilter, isNewestFirst: $isNewestFirst, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, updatingBillId: $updatingBillId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $BillsStateCopyWith<$Res>  {
  factory $BillsStateCopyWith(BillsState value, $Res Function(BillsState) _then) = _$BillsStateCopyWithImpl;
@useResult
$Res call({
 LoaderState loaderState, BillsResponseModel? data, String searchQuery, String dateRangeFilter, bool isNewestFirst, int currentPage, int totalPages, int pageSize, bool isLoadingMore, int? updatingBillId, String? errorMessage
});




}
/// @nodoc
class _$BillsStateCopyWithImpl<$Res>
    implements $BillsStateCopyWith<$Res> {
  _$BillsStateCopyWithImpl(this._self, this._then);

  final BillsState _self;
  final $Res Function(BillsState) _then;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loaderState = null,Object? data = freezed,Object? searchQuery = null,Object? dateRangeFilter = null,Object? isNewestFirst = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? updatingBillId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as BillsResponseModel?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,dateRangeFilter: null == dateRangeFilter ? _self.dateRangeFilter : dateRangeFilter // ignore: cast_nullable_to_non_nullable
as String,isNewestFirst: null == isNewestFirst ? _self.isNewestFirst : isNewestFirst // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,updatingBillId: freezed == updatingBillId ? _self.updatingBillId : updatingBillId // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BillsState].
extension BillsStatePatterns on BillsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillsState value)  $default,){
final _that = this;
switch (_that) {
case _BillsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillsState value)?  $default,){
final _that = this;
switch (_that) {
case _BillsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoaderState loaderState,  BillsResponseModel? data,  String searchQuery,  String dateRangeFilter,  bool isNewestFirst,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  int? updatingBillId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillsState() when $default != null:
return $default(_that.loaderState,_that.data,_that.searchQuery,_that.dateRangeFilter,_that.isNewestFirst,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.updatingBillId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoaderState loaderState,  BillsResponseModel? data,  String searchQuery,  String dateRangeFilter,  bool isNewestFirst,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  int? updatingBillId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BillsState():
return $default(_that.loaderState,_that.data,_that.searchQuery,_that.dateRangeFilter,_that.isNewestFirst,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.updatingBillId,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoaderState loaderState,  BillsResponseModel? data,  String searchQuery,  String dateRangeFilter,  bool isNewestFirst,  int currentPage,  int totalPages,  int pageSize,  bool isLoadingMore,  int? updatingBillId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BillsState() when $default != null:
return $default(_that.loaderState,_that.data,_that.searchQuery,_that.dateRangeFilter,_that.isNewestFirst,_that.currentPage,_that.totalPages,_that.pageSize,_that.isLoadingMore,_that.updatingBillId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BillsState implements BillsState {
  const _BillsState({this.loaderState = LoaderState.loading, this.data, this.searchQuery = '', this.dateRangeFilter = 'Today', this.isNewestFirst = true, this.currentPage = 1, this.totalPages = 1, this.pageSize = 10, this.isLoadingMore = false, this.updatingBillId, this.errorMessage});
  

@override@JsonKey() final  LoaderState loaderState;
@override final  BillsResponseModel? data;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  String dateRangeFilter;
@override@JsonKey() final  bool isNewestFirst;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool isLoadingMore;
@override final  int? updatingBillId;
@override final  String? errorMessage;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillsStateCopyWith<_BillsState> get copyWith => __$BillsStateCopyWithImpl<_BillsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillsState&&(identical(other.loaderState, loaderState) || other.loaderState == loaderState)&&(identical(other.data, data) || other.data == data)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.dateRangeFilter, dateRangeFilter) || other.dateRangeFilter == dateRangeFilter)&&(identical(other.isNewestFirst, isNewestFirst) || other.isNewestFirst == isNewestFirst)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.updatingBillId, updatingBillId) || other.updatingBillId == updatingBillId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,loaderState,data,searchQuery,dateRangeFilter,isNewestFirst,currentPage,totalPages,pageSize,isLoadingMore,updatingBillId,errorMessage);

@override
String toString() {
  return 'BillsState(loaderState: $loaderState, data: $data, searchQuery: $searchQuery, dateRangeFilter: $dateRangeFilter, isNewestFirst: $isNewestFirst, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, isLoadingMore: $isLoadingMore, updatingBillId: $updatingBillId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BillsStateCopyWith<$Res> implements $BillsStateCopyWith<$Res> {
  factory _$BillsStateCopyWith(_BillsState value, $Res Function(_BillsState) _then) = __$BillsStateCopyWithImpl;
@override @useResult
$Res call({
 LoaderState loaderState, BillsResponseModel? data, String searchQuery, String dateRangeFilter, bool isNewestFirst, int currentPage, int totalPages, int pageSize, bool isLoadingMore, int? updatingBillId, String? errorMessage
});




}
/// @nodoc
class __$BillsStateCopyWithImpl<$Res>
    implements _$BillsStateCopyWith<$Res> {
  __$BillsStateCopyWithImpl(this._self, this._then);

  final _BillsState _self;
  final $Res Function(_BillsState) _then;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loaderState = null,Object? data = freezed,Object? searchQuery = null,Object? dateRangeFilter = null,Object? isNewestFirst = null,Object? currentPage = null,Object? totalPages = null,Object? pageSize = null,Object? isLoadingMore = null,Object? updatingBillId = freezed,Object? errorMessage = freezed,}) {
  return _then(_BillsState(
loaderState: null == loaderState ? _self.loaderState : loaderState // ignore: cast_nullable_to_non_nullable
as LoaderState,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as BillsResponseModel?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,dateRangeFilter: null == dateRangeFilter ? _self.dateRangeFilter : dateRangeFilter // ignore: cast_nullable_to_non_nullable
as String,isNewestFirst: null == isNewestFirst ? _self.isNewestFirst : isNewestFirst // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,updatingBillId: freezed == updatingBillId ? _self.updatingBillId : updatingBillId // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
