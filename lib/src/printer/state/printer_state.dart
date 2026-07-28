// lib/src/printer/state/printer_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thuga/src/printer/model/printer_device_model.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';

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
    @Default(PrinterPaperSize.mm80) PrinterPaperSize paperSize,
    PrinterDeviceModel? connectedPrinter,
    @Default(<PrinterDeviceModel>[]) List<PrinterDeviceModel> availablePrinters,
    String? errorMessage,
  }) = _PrinterState;
}
