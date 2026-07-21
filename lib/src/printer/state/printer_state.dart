// lib/src/printer/state/printer_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vyapapp/src/printer/model/printer_device_model.dart';

part 'printer_state.freezed.dart';

@freezed
sealed class PrinterState with _$PrinterState {
  const factory PrinterState({
    @Default(false) bool isBluetoothSupported,
    @Default(false) bool isBluetoothEnabled,
    @Default(false) bool hasPermissions,
    @Default(false) bool isScanning,
    @Default(false) bool isConnecting,
    @Default(false) bool isConnected,
    @Default(false) bool isPrinting,
    PrinterDeviceModel? connectedPrinter,
    @Default(<PrinterDeviceModel>[]) List<PrinterDeviceModel> availablePrinters,
    String? errorMessage,
  }) = _PrinterState;
}
