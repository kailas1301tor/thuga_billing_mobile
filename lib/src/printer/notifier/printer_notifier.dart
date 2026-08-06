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

  void _logCrashlyticsAction(
    String action, {
    String? message,
    Map<String, Object?>? context,
  }) {
    unawaited(
      ref.read(printerCrashlyticsServiceProvider).logAction(
        action: action,
        message: message,
        context: context,
      ),
    );
  }

  void _reportServiceError(
    String action,
    PrinterService service, {
    Map<String, Object?>? context,
  }) {
    final error = service.lastError;
    if (error == null) {
      return;
    }

    logPrinterError(action, error, context: context);
    unawaited(
      ref.read(printerCrashlyticsServiceProvider).reportError(
        action: action,
        error: error,
        context: context,
      ),
    );
  }

  void _reportKnownFailure(
    String action,
    String code,
    String message, {
    Map<String, Object?>? context,
  }) {
    final error = PrinterError(
      code: code,
      message: message,
      userMessage: mapPrinterErrorCodeToMessage(code),
    );
    logPrinterError(action, error, context: context);
    unawaited(
      ref.read(printerCrashlyticsServiceProvider).reportError(
        action: action,
        error: error,
        context: context,
      ),
    );
  }

  Map<String, Object?> _printContext({
    required String source,
    Map<String, Object?>? extra,
  }) {
    return {
      'source': source,
      'paperSize': state.paperSize.storageValue,
      ...?extra,
    };
  }

  Map<String, Object?> _printerContext(PrinterDeviceModel printer) => {
    'name': printer.displayName,
    'address': printer.address,
  };

  String? _serviceErrorMessage(PrinterService service) {
    return service.lastError?.userMessage;
  }

  Future<PrinterDeviceModel?> _resolveSavedPrinter(PrinterService service) async {
    return state.connectedPrinter ?? await service.getSavedPrinter();
  }

  /// Syncs live Bluetooth status while keeping the saved printer in state.
  Future<void> syncPrinterState() async {
    await refreshConnectionState();
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
        connectedPrinter: savedPrinter,
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
      final savedPrinter = await _resolveSavedPrinter(service);
      state = state.copyWith(
        isConnected: isConnected,
        connectedPrinter: savedPrinter,
        errorMessage: isConnected ? null : _serviceErrorMessage(service),
      );
    } catch (error) {
      _reportUnexpected('refreshConnectionState', error);
      final service = ref.read(printerServiceProvider);
      final savedPrinter = await _resolveSavedPrinter(service);
      state = state.copyWith(
        isConnected: false,
        connectedPrinter: savedPrinter,
        errorMessage: Strings.printerUnknownError,
      );
    }
  }

  Future<bool> ensurePrinterConnected() async {
    final service = ref.read(printerServiceProvider);
    _logCrashlyticsAction('ensurePrinterConnected', message: 'started');

    await refreshConnectionState();
    if (state.isConnected) {
      _logCrashlyticsAction(
        'ensurePrinterConnected',
        message: 'already_connected',
      );
      return true;
    }

    final savedPrinter = await _resolveSavedPrinter(service);
    if (savedPrinter == null) {
      _logCrashlyticsAction(
        'ensurePrinterConnected',
        message: 'no_saved_printer',
      );
      _reportKnownFailure(
        'ensurePrinterConnected',
        PrinterErrorCodes.notConnected,
        'No saved printer during ensurePrinterConnected',
      );
      state = state.copyWith(errorMessage: Strings.printerNotConnected);
      return false;
    }

    state = state.copyWith(connectedPrinter: savedPrinter);

    final hasPermissions = await service.requestPermissions();
    if (!hasPermissions) {
      _reportServiceError('ensurePrinterConnected', service);
      _logCrashlyticsAction(
        'ensurePrinterConnected',
        message: 'permission_denied',
      );
      state = state.copyWith(
        hasPermissions: false,
        errorMessage:
            _serviceErrorMessage(service) ?? Strings.printerPermissionDenied,
      );
      return false;
    }

    final isBluetoothEnabled = await service.isBluetoothEnabled();
    if (!isBluetoothEnabled) {
      _logCrashlyticsAction(
        'ensurePrinterConnected',
        message: 'bluetooth_disabled',
      );
      _reportKnownFailure(
        'ensurePrinterConnected',
        PrinterErrorCodes.bluetoothDisabled,
        'Bluetooth disabled during ensurePrinterConnected',
        context: _printerContext(savedPrinter),
      );
      state = state.copyWith(
        hasPermissions: true,
        isBluetoothEnabled: false,
        errorMessage: Strings.printerBluetoothDisabled,
      );
      return false;
    }

    const maxAttempts = 3;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      _logCrashlyticsAction(
        'ensurePrinterConnected',
        message: 'reconnecting',
        context: {
          ..._printerContext(savedPrinter),
          'attempt': attempt,
          'maxAttempts': maxAttempts,
        },
      );
      await connectPrinter(savedPrinter, silently: true);

      if (state.isConnected) {
        _logCrashlyticsAction(
          'ensurePrinterConnected',
          message: 'success',
          context: {'attempt': attempt},
        );
        return true;
      }

      if (attempt < maxAttempts) {
        await Future<void>.delayed(const Duration(milliseconds: 400));
      }
    }

    _logCrashlyticsAction('ensurePrinterConnected', message: 'failed');
    _reportServiceError(
      'ensurePrinterConnected',
      service,
      context: {
        ..._printerContext(savedPrinter),
        'attempt': maxAttempts,
        'maxAttempts': maxAttempts,
      },
    );
    if (service.lastError == null) {
      _reportKnownFailure(
        'ensurePrinterConnected',
        PrinterErrorCodes.connectionFailed,
        'Reconnect failed after $maxAttempts attempts',
        context: {
          ..._printerContext(savedPrinter),
          'attempt': maxAttempts,
          'maxAttempts': maxAttempts,
        },
      );
    }
    state = state.copyWith(
      errorMessage:
          _serviceErrorMessage(service) ?? Strings.printerNotConnected,
    );
    return false;
  }

  Future<void> rescanPrinters() async {
    final service = ref.read(printerServiceProvider);
    _logCrashlyticsAction('rescanPrinters', message: 'started');
    try {
      final hasPermissions = await service.requestPermissions();
      if (!hasPermissions) {
        _reportServiceError('rescanPrinters', service);
        _logCrashlyticsAction(
          'rescanPrinters',
          message: 'permission_denied',
        );
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
        _reportServiceError('rescanPrinters', service);
        _logCrashlyticsAction(
          'rescanPrinters',
          message: 'bluetooth_disabled',
        );
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
      final serviceError = _serviceErrorMessage(service);
      if (serviceError != null) {
        _reportServiceError('rescanPrinters', service);
      } else {
        _logCrashlyticsAction(
          'rescanPrinters',
          message: 'completed',
          context: {'count': printers.length},
        );
      }
      state = state.copyWith(
        availablePrinters: printers,
        isScanning: false,
        errorMessage: serviceError,
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
    final printerContext = {
      ..._printerContext(printer),
      'silently': silently,
    };
    _logCrashlyticsAction(
      'connectPrinter',
      message: 'started',
      context: printerContext,
    );
    try {
      state = state.copyWith(isConnecting: true, errorMessage: null);

      final connected = await service.connectBluetooth(printer);
      final savedPrinter = await service.getSavedPrinter();
      final errorMessage = connected
          ? null
          : (_serviceErrorMessage(service) ?? Strings.printerConnectionFailed);

      if (connected) {
        _logCrashlyticsAction(
          'connectPrinter',
          message: 'success',
          context: printerContext,
        );
      } else {
        _reportServiceError(
          'connectPrinter',
          service,
          context: printerContext,
        );
        if (service.lastError == null) {
          _reportUnexpected(
            'connectPrinter',
            errorMessage ?? Strings.printerConnectionFailed,
            context: printerContext,
          );
        }
        _logCrashlyticsAction(
          'connectPrinter',
          message: 'failed',
          context: printerContext,
        );
      }

      state = state.copyWith(
        isConnecting: false,
        isConnected: connected,
        connectedPrinter: connected
            ? printer.copyWith(isConnected: true)
            : savedPrinter,
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
        context: printerContext,
      );
      _logCrashlyticsAction(
        'connectPrinter',
        message: 'unexpected_error',
        context: printerContext,
      );
      final savedPrinter = await service.getSavedPrinter();
      state = state.copyWith(
        isConnecting: false,
        isConnected: false,
        connectedPrinter: savedPrinter,
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
    _logCrashlyticsAction('disconnectPrinter', message: 'started');
    try {
      state = state.copyWith(errorMessage: null);
      await service.disconnectBluetooth();
      final serviceError = _serviceErrorMessage(service);
      if (serviceError != null) {
        _reportServiceError('disconnectPrinter', service);
        _logCrashlyticsAction(
          'disconnectPrinter',
          message: 'failed',
        );
      } else {
        _logCrashlyticsAction(
          'disconnectPrinter',
          message: 'success',
        );
      }
      state = state.copyWith(
        isConnected: false,
        connectedPrinter: null,
        errorMessage: serviceError,
      );
    } catch (error) {
      _reportUnexpected('disconnectPrinter', error);
      _logCrashlyticsAction(
        'disconnectPrinter',
        message: 'unexpected_error',
      );
      state = state.copyWith(
        isConnected: false,
        connectedPrinter: null,
        errorMessage:
            _serviceErrorMessage(service) ?? Strings.printerUnknownError,
      );
    }
  }

  /// Non-fatal breadcrumb for multi-step print flows (e.g. new bill save → print).
  void logPrintFlow({
    required String stage,
    required String source,
    Map<String, Object?>? context,
  }) {
    _logCrashlyticsAction(
      'printFlow',
      message: stage,
      context: {
        'source': source,
        'stage': stage,
        ...?context,
      },
    );
  }

  Future<bool> _attemptPrintReceipt(
    PrinterService service,
    ReceiptPrintData data, {
    required int attempt,
    required Map<String, Object?> context,
  }) async {
    final attemptContext = {
      ...context,
      'printAttempt': attempt,
      'itemCount': data.items.length,
    };

    final ready = await ensurePrinterConnected();
    if (!ready) {
      _logCrashlyticsAction(
        'printReceiptData',
        message: 'not_ready',
        context: attemptContext,
      );
      _reportServiceError('printReceiptData', service, context: attemptContext);
      if (service.lastError == null) {
        _reportKnownFailure(
          'printReceiptData',
          PrinterErrorCodes.notConnected,
          'Printer not ready before printReceiptData attempt $attempt',
          context: attemptContext,
        );
      }
      return false;
    }

    _logCrashlyticsAction(
      'printReceiptData',
      message: 'printing',
      context: attemptContext,
    );

    return service.printReceipt(
      data,
      paperSize: state.paperSize,
    );
  }

  Future<void> _applyPrintReceiptState({
    required PrinterService service,
    required bool success,
    required Map<String, Object?> context,
  }) async {
    final savedPrinter = await service.getSavedPrinter();
    final isStillConnected = success || await service.isConnected();
    state = state.copyWith(
      isPrinting: false,
      isConnected: isStillConnected,
      connectedPrinter: savedPrinter,
      errorMessage:
          success
              ? null
              : (_serviceErrorMessage(service) ?? Strings.printerPrintFailed),
    );
    _logCrashlyticsAction(
      'printReceiptData',
      message: 'state_applied',
      context: {
        ...context,
        'printed': success,
        'isConnected': isStillConnected,
        if (state.errorMessage != null) 'errorMessage': state.errorMessage,
      },
    );
  }

  Future<bool> warmUpConnection({required String source}) async {
    final savedPrinter = await ref.read(printerServiceProvider).getSavedPrinter();
    if (savedPrinter == null) {
      logPrintFlow(
        stage: 'warmup_skipped',
        source: source,
        context: {'reason': 'no_saved_printer'},
      );
      return false;
    }

    final success = await ensurePrinterConnected();
    logPrintFlow(
      stage: success ? 'warmup_success' : 'warmup_failed',
      source: source,
      context: {
        'warmupSuccess': success,
        ..._printerContext(savedPrinter),
      },
    );
    return success;
  }

  Future<bool> printReceiptData(
    ReceiptPrintData data, {
    String source = 'unknown',
  }) async {
    final service = ref.read(printerServiceProvider);
    final context = _printContext(
      source: source,
      extra: {'orderNumber': data.orderNumber},
    );
    try {
      state = state.copyWith(isPrinting: true, errorMessage: null);
      _logCrashlyticsAction(
        'printReceiptData',
        message: 'started',
        context: {
          ...context,
          'itemCount': data.items.length,
        },
      );

      var success = await _attemptPrintReceipt(
        service,
        data,
        attempt: 1,
        context: context,
      );
      if (!success) {
        _logCrashlyticsAction(
          'printReceiptData',
          message: 'print_failed_retrying',
          context: context,
        );
        await Future<void>.delayed(const Duration(milliseconds: 300));
        success = await _attemptPrintReceipt(
          service,
          data,
          attempt: 2,
          context: context,
        );
      }

      await _applyPrintReceiptState(
        service: service,
        success: success,
        context: context,
      );

      if (success) {
        _logCrashlyticsAction(
          'printReceiptData',
          message: 'success',
          context: context,
        );
      } else {
        _logCrashlyticsAction(
          'printReceiptData',
          message: 'print_failed',
          context: {
            ...context,
            'itemCount': data.items.length,
          },
        );
        _reportServiceError('printReceiptData', service, context: context);
        if (service.lastError == null) {
          _reportKnownFailure(
            'printReceiptData',
            PrinterErrorCodes.printFailed,
            'printReceipt failed after retry',
            context: context,
          );
        }
      }
      return success;
    } catch (error) {
      _reportUnexpected(
        'printReceiptData',
        error,
        context: context,
      );
      final savedPrinter = await service.getSavedPrinter();
      final isStillConnected = await service.isConnected();
      state = state.copyWith(
        isPrinting: false,
        isConnected: isStillConnected,
        connectedPrinter: savedPrinter,
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

  Future<bool> printDemoReceipt({
    required String storeName,
    String source = 'unknown',
  }) async {
    final service = ref.read(printerServiceProvider);
    final context = _printContext(source: source);
    try {
      final ready = await ensurePrinterConnected();
      if (!ready) {
        _logCrashlyticsAction(
          'printDemoReceipt',
          message: 'not_ready',
          context: context,
        );
        _reportServiceError('printDemoReceipt', service, context: context);
        if (service.lastError == null) {
          _reportKnownFailure(
            'printDemoReceipt',
            PrinterErrorCodes.notConnected,
            'Printer not ready before printDemoReceipt',
            context: context,
          );
        }
        return false;
      }

      state = state.copyWith(isPrinting: true, errorMessage: null);
      final success = await service.printDemoReceipt(
        paperSize: state.paperSize,
        storeName: storeName,
      );
      final savedPrinter = await service.getSavedPrinter();
      state = state.copyWith(
        isPrinting: false,
        isConnected: success,
        connectedPrinter: savedPrinter,
        errorMessage:
            success
                ? null
                : (_serviceErrorMessage(service) ?? Strings.printerPrintFailed),
      );
      if (success) {
        _logCrashlyticsAction(
          'printDemoReceipt',
          message: 'success',
          context: context,
        );
      } else {
        _logCrashlyticsAction(
          'printDemoReceipt',
          message: 'print_failed',
          context: context,
        );
        _reportServiceError('printDemoReceipt', service, context: context);
      }
      return success;
    } catch (error) {
      _reportUnexpected('printDemoReceipt', error, context: context);
      final savedPrinter = await service.getSavedPrinter();
      state = state.copyWith(
        isPrinting: false,
        isConnected: false,
        connectedPrinter: savedPrinter,
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
