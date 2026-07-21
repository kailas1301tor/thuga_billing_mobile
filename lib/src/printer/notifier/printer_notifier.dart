// lib/src/printer/notifier/printer_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/src/printer/model/printer_device_model.dart';
import 'package:vyapapp/src/printer/service/printer_service.dart';
import 'package:vyapapp/src/printer/state/printer_state.dart';
import 'package:vyapapp/utils/helpers/receipt_print_helper.dart';

part 'printer_notifier.g.dart';

@Riverpod(keepAlive: true)
class PrinterNotifier extends _$PrinterNotifier {
  @override
  PrinterState build() {
    Future.microtask(_initialize);
    return const PrinterState();
  }

  Future<void> _initialize() async {
    final service = ref.read(printerServiceProvider);
    final isSupported = await service.isBluetoothSupported();
    final savedPrinter = await service.getSavedPrinter();
    var hasPermissions = false;
    var isConnected = false;

    if (savedPrinter != null) {
      hasPermissions = await service.requestPermissions();
      if (hasPermissions) {
        isConnected = await service.isConnected();
      }
    }

    state = state.copyWith(
      isBluetoothSupported: isSupported,
      hasPermissions: hasPermissions,
      isBluetoothEnabled: isSupported,
      isConnected: isConnected,
      connectedPrinter: isConnected ? savedPrinter : null,
      errorMessage: null,
    );

    if (savedPrinter != null && !isConnected && hasPermissions) {
      await connectPrinter(savedPrinter, silently: true);
    }
  }

  Future<void> refreshConnectionState() async {
    final service = ref.read(printerServiceProvider);
    final isConnected = await service.isConnected();
    state = state.copyWith(
      isConnected: isConnected,
      connectedPrinter: isConnected ? state.connectedPrinter : null,
    );
  }

  Future<void> rescanPrinters() async {
    final service = ref.read(printerServiceProvider);
    final hasPermissions = await service.requestPermissions();
    if (!hasPermissions) {
      state = state.copyWith(
        hasPermissions: false,
        errorMessage: 'Bluetooth permission is required to scan printers',
      );
      return;
    }

    state = state.copyWith(
      hasPermissions: true,
      isBluetoothEnabled: true,
      isScanning: true,
      errorMessage: null,
    );

    await service.stopBluetoothScan();
    final printers = await service.scanBluetoothPrinters();
    state = state.copyWith(availablePrinters: printers, isScanning: false);
  }

  Future<void> connectPrinter(
    PrinterDeviceModel printer, {
    bool silently = false,
  }) async {
    final service = ref.read(printerServiceProvider);
    state = state.copyWith(isConnecting: true, errorMessage: null);

    final connected = await service.connectBluetooth(printer);
    state = state.copyWith(
      isConnecting: false,
      isConnected: connected,
      connectedPrinter: connected ? printer.copyWith(isConnected: true) : null,
      errorMessage:
          connected || silently ? null : 'Failed to connect to printer',
    );
  }

  Future<void> disconnectPrinter() async {
    final service = ref.read(printerServiceProvider);
    await service.disconnectBluetooth();
    state = state.copyWith(
      isConnected: false,
      connectedPrinter: null,
      errorMessage: null,
    );
  }

  Future<bool> printReceiptData(ReceiptPrintData data) async {
    final service = ref.read(printerServiceProvider);
    final isConnected = await service.isConnected();
    if (!isConnected) {
      state = state.copyWith(
        isConnected: false,
        connectedPrinter: null,
        errorMessage: 'No Bluetooth printer connected',
      );
      return false;
    }

    state = state.copyWith(isPrinting: true, errorMessage: null);
    final success = await service.printReceipt(data);
    state = state.copyWith(
      isPrinting: false,
      isConnected: success ? true : state.isConnected,
      errorMessage: success ? null : 'Printer failed to print receipt',
    );
    return success;
  }
}
