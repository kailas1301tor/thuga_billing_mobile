// lib/src/printer/notifier/printer_notifier.dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/src/printer/model/printer_device_model.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';
import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/src/printer/service/printer_service.dart';
import 'package:thuga/src/printer/state/printer_state.dart';
import 'package:thuga/utils/helpers/printer_error_helper.dart';
import 'package:thuga/utils/helpers/receipt_print_helper.dart';

part 'printer_notifier.g.dart';

@Riverpod(keepAlive: true)
class PrinterNotifier extends _$PrinterNotifier {
  @override
  PrinterState build() {
    Future.microtask(_initialize).catchError((Object error) {
      _reportUnexpected('initialize', error);
    });
    return const PrinterState();
  }

  void _reportUnexpected(
    String action,
    Object error, {
    Map<String, Object?>? context,
  }) {
    logPrinterUnexpected(action, error, context: context);
    unawaited(
      ref.read(printerCrashlyticsServiceProvider).reportUnexpected(
        action: action,
        error: error,
        context: context,
      ),
    );
  }

  String? _serviceErrorMessage(PrinterService service) {
    return service.lastError?.userMessage;
  }

  Future<void> _initialize() async {
    try {
      logPrinterAction('initialize');
      final service = ref.read(printerServiceProvider);
      final isSupported = await service.isBluetoothSupported();
      final isBluetoothEnabled = await service.isBluetoothEnabled();
      final savedPrinter = await service.getSavedPrinter();
      final paperSize = await service.getPaperSize();
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
        isBluetoothEnabled: isBluetoothEnabled,
        isConnected: isConnected,
        connectedPrinter: isConnected ? savedPrinter : null,
        paperSize: paperSize,
        errorMessage: null,
      );

      if (savedPrinter != null && !isConnected && hasPermissions) {
        await connectPrinter(savedPrinter, silently: true);
      }
    } catch (error) {
      _reportUnexpected('initialize', error);
      state = state.copyWith(
        errorMessage: Strings.printerUnknownError,
      );
    }
  }

  Future<void> setPaperSize(PrinterPaperSize paperSize) async {
    try {
      final service = ref.read(printerServiceProvider);
      await service.setPaperSize(paperSize);
      state = state.copyWith(paperSize: paperSize);
    } catch (error) {
      _reportUnexpected('setPaperSize', error);
    }
  }

  Future<void> refreshConnectionState() async {
    try {
      final service = ref.read(printerServiceProvider);
      final isConnected = await service.isConnected();
      state = state.copyWith(
        isConnected: isConnected,
        connectedPrinter: isConnected ? state.connectedPrinter : null,
        errorMessage: isConnected ? null : _serviceErrorMessage(service),
      );
    } catch (error) {
      _reportUnexpected('refreshConnectionState', error);
      state = state.copyWith(
        isConnected: false,
        connectedPrinter: null,
        errorMessage: Strings.printerUnknownError,
      );
    }
  }

  Future<void> rescanPrinters() async {
    final service = ref.read(printerServiceProvider);
    try {
      final hasPermissions = await service.requestPermissions();
      if (!hasPermissions) {
        state = state.copyWith(
          hasPermissions: false,
          isScanning: false,
          errorMessage:
              _serviceErrorMessage(service) ?? Strings.printerPermissionDenied,
        );
        return;
      }

      final isBluetoothEnabled = await service.isBluetoothEnabled();
      if (!isBluetoothEnabled) {
        state = state.copyWith(
          hasPermissions: hasPermissions,
          isBluetoothEnabled: false,
          isScanning: false,
          errorMessage: Strings.printerBluetoothDisabled,
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
      state = state.copyWith(
        availablePrinters: printers,
        isScanning: false,
        errorMessage: _serviceErrorMessage(service),
      );
    } catch (error) {
      _reportUnexpected('rescanPrinters', error);
      state = state.copyWith(
        isScanning: false,
        errorMessage: Strings.printerScanFailed,
      );
    } finally {
      if (state.isScanning) {
        state = state.copyWith(isScanning: false);
      }
    }
  }

  Future<void> connectPrinter(
    PrinterDeviceModel printer, {
    bool silently = false,
  }) async {
    final service = ref.read(printerServiceProvider);
    try {
      await refreshConnectionState();
      state = state.copyWith(isConnecting: true, errorMessage: null);

      final connected = await service.connectBluetooth(printer);
      final errorMessage = connected
          ? null
          : (_serviceErrorMessage(service) ?? Strings.printerConnectionFailed);

      state = state.copyWith(
        isConnecting: false,
        isConnected: connected,
        connectedPrinter: connected ? printer.copyWith(isConnected: true) : null,
        errorMessage: connected || silently ? null : errorMessage,
      );

      if (!connected && silently) {
        debugPrint(
          '🔴 PRINTER SILENT CONNECT FAILED: ${printer.displayName} | $errorMessage',
        );
      }
    } catch (error) {
      _reportUnexpected(
        'connectPrinter',
        error,
        context: {
          'name': printer.displayName,
          'address': printer.address,
        },
      );
      state = state.copyWith(
        isConnecting: false,
        isConnected: false,
        connectedPrinter: null,
        errorMessage: silently
            ? null
            : (_serviceErrorMessage(service) ?? Strings.printerConnectionFailed),
      );
    } finally {
      if (state.isConnecting) {
        state = state.copyWith(isConnecting: false);
      }
    }
  }

  Future<void> disconnectPrinter() async {
    final service = ref.read(printerServiceProvider);
    try {
      state = state.copyWith(errorMessage: null);
      await service.disconnectBluetooth();
      state = state.copyWith(
        isConnected: false,
        connectedPrinter: null,
        errorMessage: _serviceErrorMessage(service),
      );
    } catch (error) {
      _reportUnexpected('disconnectPrinter', error);
      state = state.copyWith(
        isConnected: false,
        connectedPrinter: null,
        errorMessage:
            _serviceErrorMessage(service) ?? Strings.printerUnknownError,
      );
    }
  }

  Future<bool> printReceiptData(ReceiptPrintData data) async {
    final service = ref.read(printerServiceProvider);
    try {
      await refreshConnectionState();
      final isConnected = await service.isConnected();
      if (!isConnected) {
        state = state.copyWith(
          isConnected: false,
          connectedPrinter: null,
          errorMessage:
              _serviceErrorMessage(service) ?? Strings.printerNotConnected,
        );
        return false;
      }

      state = state.copyWith(isPrinting: true, errorMessage: null);
      final success = await service.printReceipt(
        data,
        paperSize: state.paperSize,
      );
      state = state.copyWith(
        isPrinting: false,
        isConnected: success ? true : false,
        connectedPrinter: success ? state.connectedPrinter : null,
        errorMessage:
            success
                ? null
                : (_serviceErrorMessage(service) ?? Strings.printerPrintFailed),
      );
      return success;
    } catch (error) {
      _reportUnexpected(
        'printReceiptData',
        error,
        context: {'orderNumber': data.orderNumber},
      );
      state = state.copyWith(
        isPrinting: false,
        isConnected: false,
        connectedPrinter: null,
        errorMessage:
            _serviceErrorMessage(service) ?? Strings.printerPrintFailed,
      );
      return false;
    } finally {
      if (state.isPrinting) {
        state = state.copyWith(isPrinting: false);
      }
    }
  }
}
