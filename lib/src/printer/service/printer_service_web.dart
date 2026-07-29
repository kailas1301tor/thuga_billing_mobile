// lib/src/printer/service/printer_service_web.dart
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/src/printer/model/printer_device_model.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';
import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/src/printer/service/printer_service.dart';
import 'package:thuga/utils/helpers/printer_error_helper.dart';
import 'package:thuga/utils/helpers/receipt_print_helper.dart';

PrinterService createPrinterService(PrinterCrashlyticsService crashlytics) {
  return PrinterServiceWeb(crashlytics);
}

/// Web stub — Bluetooth thermal printing is mobile-only.
class PrinterServiceWeb implements PrinterService {
  PrinterServiceWeb(this._crashlytics);

  static const _kPaperSizeKey = 'pref_printer_paper_size';

  static const _unsupportedError = PrinterError(
    code: PrinterErrorCodes.bluetoothNotAvailable,
    message: 'Bluetooth printing is not supported on web',
    userMessage: Strings.bluetoothPrinterHint,
  );

  final PrinterCrashlyticsService _crashlytics;

  PrinterError? _lastError;

  @override
  PrinterError? get lastError => _lastError;

  void _setUnsupported(String action) {
    _lastError = _unsupportedError;
    logPrinterError(action, _unsupportedError);
  }

  @override
  Future<bool> isBluetoothSupported() async {
    _lastError = null;
    return false;
  }

  @override
  Future<bool> isBluetoothEnabled() async {
    _setUnsupported('isBluetoothEnabled');
    return false;
  }

  @override
  Future<bool> requestPermissions() async {
    _setUnsupported('requestPermissions');
    return false;
  }

  @override
  Future<bool> isConnected() async {
    _lastError = null;
    return false;
  }

  @override
  Future<List<PrinterDeviceModel>> scanBluetoothPrinters() async {
    _setUnsupported('scanBluetoothPrinters');
    return const [];
  }

  @override
  Future<bool> stopBluetoothScan() async {
    _lastError = null;
    return true;
  }

  @override
  Future<bool> connectBluetooth(PrinterDeviceModel printer) async {
    _setUnsupported('connectBluetooth');
    return false;
  }

  @override
  Future<bool> disconnectBluetooth() async {
    _lastError = null;
    return true;
  }

  @override
  Future<PrinterDeviceModel?> getSavedPrinter() async {
    _lastError = null;
    return null;
  }

  @override
  Future<void> clearSavedPrinter() async {
    _lastError = null;
  }

  @override
  Future<PrinterPaperSize> getPaperSize() async {
    _lastError = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      return PrinterPaperSize.fromStorageValue(
        prefs.getString(_kPaperSizeKey),
      );
    } catch (error) {
      logPrinterUnexpected('getPaperSize', error);
      unawaited(
        _crashlytics.reportUnexpected(action: 'getPaperSize', error: error),
      );
      return PrinterPaperSize.mm80;
    }
  }

  @override
  Future<void> setPaperSize(PrinterPaperSize paperSize) async {
    _lastError = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kPaperSizeKey, paperSize.storageValue);
    } catch (error) {
      logPrinterUnexpected('setPaperSize', error);
      unawaited(
        _crashlytics.reportUnexpected(action: 'setPaperSize', error: error),
      );
    }
  }

  @override
  Future<bool> printReceipt(
    ReceiptPrintData data, {
    required PrinterPaperSize paperSize,
  }) async {
    _lastError = const PrinterError(
      code: PrinterErrorCodes.bluetoothNotAvailable,
      message: 'Bluetooth printing is not supported on web',
      userMessage: Strings.printerFallbackPreview,
    );
    logPrinterError('printReceipt', _lastError!);
    return false;
  }
}
