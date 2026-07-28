// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'printer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrinterState {

 bool get isBluetoothSupported; bool get isBluetoothEnabled; bool get hasPermissions; bool get isScanning; bool get isConnecting; bool get isConnected; bool get isPrinting; PrinterPaperSize get paperSize; PrinterDeviceModel? get connectedPrinter; List<PrinterDeviceModel> get availablePrinters; String? get errorMessage;
/// Create a copy of PrinterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrinterStateCopyWith<PrinterState> get copyWith => _$PrinterStateCopyWithImpl<PrinterState>(this as PrinterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrinterState&&(identical(other.isBluetoothSupported, isBluetoothSupported) || other.isBluetoothSupported == isBluetoothSupported)&&(identical(other.isBluetoothEnabled, isBluetoothEnabled) || other.isBluetoothEnabled == isBluetoothEnabled)&&(identical(other.hasPermissions, hasPermissions) || other.hasPermissions == hasPermissions)&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.isConnecting, isConnecting) || other.isConnecting == isConnecting)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.isPrinting, isPrinting) || other.isPrinting == isPrinting)&&(identical(other.paperSize, paperSize) || other.paperSize == paperSize)&&(identical(other.connectedPrinter, connectedPrinter) || other.connectedPrinter == connectedPrinter)&&const DeepCollectionEquality().equals(other.availablePrinters, availablePrinters)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isBluetoothSupported,isBluetoothEnabled,hasPermissions,isScanning,isConnecting,isConnected,isPrinting,paperSize,connectedPrinter,const DeepCollectionEquality().hash(availablePrinters),errorMessage);

@override
String toString() {
  return 'PrinterState(isBluetoothSupported: $isBluetoothSupported, isBluetoothEnabled: $isBluetoothEnabled, hasPermissions: $hasPermissions, isScanning: $isScanning, isConnecting: $isConnecting, isConnected: $isConnected, isPrinting: $isPrinting, paperSize: $paperSize, connectedPrinter: $connectedPrinter, availablePrinters: $availablePrinters, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PrinterStateCopyWith<$Res>  {
  factory $PrinterStateCopyWith(PrinterState value, $Res Function(PrinterState) _then) = _$PrinterStateCopyWithImpl;
@useResult
$Res call({
 bool isBluetoothSupported, bool isBluetoothEnabled, bool hasPermissions, bool isScanning, bool isConnecting, bool isConnected, bool isPrinting, PrinterPaperSize paperSize, PrinterDeviceModel? connectedPrinter, List<PrinterDeviceModel> availablePrinters, String? errorMessage
});




}
/// @nodoc
class _$PrinterStateCopyWithImpl<$Res>
    implements $PrinterStateCopyWith<$Res> {
  _$PrinterStateCopyWithImpl(this._self, this._then);

  final PrinterState _self;
  final $Res Function(PrinterState) _then;

/// Create a copy of PrinterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isBluetoothSupported = null,Object? isBluetoothEnabled = null,Object? hasPermissions = null,Object? isScanning = null,Object? isConnecting = null,Object? isConnected = null,Object? isPrinting = null,Object? paperSize = null,Object? connectedPrinter = freezed,Object? availablePrinters = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isBluetoothSupported: null == isBluetoothSupported ? _self.isBluetoothSupported : isBluetoothSupported // ignore: cast_nullable_to_non_nullable
as bool,isBluetoothEnabled: null == isBluetoothEnabled ? _self.isBluetoothEnabled : isBluetoothEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasPermissions: null == hasPermissions ? _self.hasPermissions : hasPermissions // ignore: cast_nullable_to_non_nullable
as bool,isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,isConnecting: null == isConnecting ? _self.isConnecting : isConnecting // ignore: cast_nullable_to_non_nullable
as bool,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,isPrinting: null == isPrinting ? _self.isPrinting : isPrinting // ignore: cast_nullable_to_non_nullable
as bool,paperSize: null == paperSize ? _self.paperSize : paperSize // ignore: cast_nullable_to_non_nullable
as PrinterPaperSize,connectedPrinter: freezed == connectedPrinter ? _self.connectedPrinter : connectedPrinter // ignore: cast_nullable_to_non_nullable
as PrinterDeviceModel?,availablePrinters: null == availablePrinters ? _self.availablePrinters : availablePrinters // ignore: cast_nullable_to_non_nullable
as List<PrinterDeviceModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrinterState].
extension PrinterStatePatterns on PrinterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrinterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrinterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrinterState value)  $default,){
final _that = this;
switch (_that) {
case _PrinterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrinterState value)?  $default,){
final _that = this;
switch (_that) {
case _PrinterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isBluetoothSupported,  bool isBluetoothEnabled,  bool hasPermissions,  bool isScanning,  bool isConnecting,  bool isConnected,  bool isPrinting,  PrinterPaperSize paperSize,  PrinterDeviceModel? connectedPrinter,  List<PrinterDeviceModel> availablePrinters,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrinterState() when $default != null:
return $default(_that.isBluetoothSupported,_that.isBluetoothEnabled,_that.hasPermissions,_that.isScanning,_that.isConnecting,_that.isConnected,_that.isPrinting,_that.paperSize,_that.connectedPrinter,_that.availablePrinters,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isBluetoothSupported,  bool isBluetoothEnabled,  bool hasPermissions,  bool isScanning,  bool isConnecting,  bool isConnected,  bool isPrinting,  PrinterPaperSize paperSize,  PrinterDeviceModel? connectedPrinter,  List<PrinterDeviceModel> availablePrinters,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PrinterState():
return $default(_that.isBluetoothSupported,_that.isBluetoothEnabled,_that.hasPermissions,_that.isScanning,_that.isConnecting,_that.isConnected,_that.isPrinting,_that.paperSize,_that.connectedPrinter,_that.availablePrinters,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isBluetoothSupported,  bool isBluetoothEnabled,  bool hasPermissions,  bool isScanning,  bool isConnecting,  bool isConnected,  bool isPrinting,  PrinterPaperSize paperSize,  PrinterDeviceModel? connectedPrinter,  List<PrinterDeviceModel> availablePrinters,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PrinterState() when $default != null:
return $default(_that.isBluetoothSupported,_that.isBluetoothEnabled,_that.hasPermissions,_that.isScanning,_that.isConnecting,_that.isConnected,_that.isPrinting,_that.paperSize,_that.connectedPrinter,_that.availablePrinters,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PrinterState implements PrinterState {
  const _PrinterState({this.isBluetoothSupported = false, this.isBluetoothEnabled = false, this.hasPermissions = false, this.isScanning = false, this.isConnecting = false, this.isConnected = false, this.isPrinting = false, this.paperSize = PrinterPaperSize.mm80, this.connectedPrinter, final  List<PrinterDeviceModel> availablePrinters = const <PrinterDeviceModel>[], this.errorMessage}): _availablePrinters = availablePrinters;
  

@override@JsonKey() final  bool isBluetoothSupported;
@override@JsonKey() final  bool isBluetoothEnabled;
@override@JsonKey() final  bool hasPermissions;
@override@JsonKey() final  bool isScanning;
@override@JsonKey() final  bool isConnecting;
@override@JsonKey() final  bool isConnected;
@override@JsonKey() final  bool isPrinting;
@override@JsonKey() final  PrinterPaperSize paperSize;
@override final  PrinterDeviceModel? connectedPrinter;
 final  List<PrinterDeviceModel> _availablePrinters;
@override@JsonKey() List<PrinterDeviceModel> get availablePrinters {
  if (_availablePrinters is EqualUnmodifiableListView) return _availablePrinters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePrinters);
}

@override final  String? errorMessage;

/// Create a copy of PrinterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrinterStateCopyWith<_PrinterState> get copyWith => __$PrinterStateCopyWithImpl<_PrinterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrinterState&&(identical(other.isBluetoothSupported, isBluetoothSupported) || other.isBluetoothSupported == isBluetoothSupported)&&(identical(other.isBluetoothEnabled, isBluetoothEnabled) || other.isBluetoothEnabled == isBluetoothEnabled)&&(identical(other.hasPermissions, hasPermissions) || other.hasPermissions == hasPermissions)&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.isConnecting, isConnecting) || other.isConnecting == isConnecting)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.isPrinting, isPrinting) || other.isPrinting == isPrinting)&&(identical(other.paperSize, paperSize) || other.paperSize == paperSize)&&(identical(other.connectedPrinter, connectedPrinter) || other.connectedPrinter == connectedPrinter)&&const DeepCollectionEquality().equals(other._availablePrinters, _availablePrinters)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isBluetoothSupported,isBluetoothEnabled,hasPermissions,isScanning,isConnecting,isConnected,isPrinting,paperSize,connectedPrinter,const DeepCollectionEquality().hash(_availablePrinters),errorMessage);

@override
String toString() {
  return 'PrinterState(isBluetoothSupported: $isBluetoothSupported, isBluetoothEnabled: $isBluetoothEnabled, hasPermissions: $hasPermissions, isScanning: $isScanning, isConnecting: $isConnecting, isConnected: $isConnected, isPrinting: $isPrinting, paperSize: $paperSize, connectedPrinter: $connectedPrinter, availablePrinters: $availablePrinters, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PrinterStateCopyWith<$Res> implements $PrinterStateCopyWith<$Res> {
  factory _$PrinterStateCopyWith(_PrinterState value, $Res Function(_PrinterState) _then) = __$PrinterStateCopyWithImpl;
@override @useResult
$Res call({
 bool isBluetoothSupported, bool isBluetoothEnabled, bool hasPermissions, bool isScanning, bool isConnecting, bool isConnected, bool isPrinting, PrinterPaperSize paperSize, PrinterDeviceModel? connectedPrinter, List<PrinterDeviceModel> availablePrinters, String? errorMessage
});




}
/// @nodoc
class __$PrinterStateCopyWithImpl<$Res>
    implements _$PrinterStateCopyWith<$Res> {
  __$PrinterStateCopyWithImpl(this._self, this._then);

  final _PrinterState _self;
  final $Res Function(_PrinterState) _then;

/// Create a copy of PrinterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isBluetoothSupported = null,Object? isBluetoothEnabled = null,Object? hasPermissions = null,Object? isScanning = null,Object? isConnecting = null,Object? isConnected = null,Object? isPrinting = null,Object? paperSize = null,Object? connectedPrinter = freezed,Object? availablePrinters = null,Object? errorMessage = freezed,}) {
  return _then(_PrinterState(
isBluetoothSupported: null == isBluetoothSupported ? _self.isBluetoothSupported : isBluetoothSupported // ignore: cast_nullable_to_non_nullable
as bool,isBluetoothEnabled: null == isBluetoothEnabled ? _self.isBluetoothEnabled : isBluetoothEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasPermissions: null == hasPermissions ? _self.hasPermissions : hasPermissions // ignore: cast_nullable_to_non_nullable
as bool,isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,isConnecting: null == isConnecting ? _self.isConnecting : isConnecting // ignore: cast_nullable_to_non_nullable
as bool,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,isPrinting: null == isPrinting ? _self.isPrinting : isPrinting // ignore: cast_nullable_to_non_nullable
as bool,paperSize: null == paperSize ? _self.paperSize : paperSize // ignore: cast_nullable_to_non_nullable
as PrinterPaperSize,connectedPrinter: freezed == connectedPrinter ? _self.connectedPrinter : connectedPrinter // ignore: cast_nullable_to_non_nullable
as PrinterDeviceModel?,availablePrinters: null == availablePrinters ? _self._availablePrinters : availablePrinters // ignore: cast_nullable_to_non_nullable
as List<PrinterDeviceModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
