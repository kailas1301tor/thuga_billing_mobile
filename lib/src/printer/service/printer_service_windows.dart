// lib/src/printer/service/printer_service_windows.dart
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/src/printer/model/printer_connection_type.dart';
import 'package:thuga/src/printer/model/printer_device_model.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';
import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/src/printer/service/printer_service.dart';
import 'package:thuga/src/printer/service/printer_write_helper.dart';
import 'package:thuga/utils/helpers/date_formatter.dart';
import 'package:thuga/utils/helpers/printer_error_helper.dart';
import 'package:thuga/utils/helpers/receipt_print_helper.dart';
import 'package:unified_esc_pos_printer/unified_esc_pos_printer.dart' as esc;

PrinterService createWindowsPrinterService(PrinterCrashlyticsService crashlytics) {
  return PrinterServiceWindowsImpl(crashlytics);
}

class PrinterServiceWindowsImpl implements PrinterService {
  PrinterServiceWindowsImpl(this._crashlytics);

  static const _kPrinterNameKey = 'pref_printer_name';
  static const _kPrinterAddressKey = 'pref_printer_address';
  static const _kPaperSizeKey = 'pref_printer_paper_size';
  static const _kConnectionTypeKey = 'pref_printer_connection_type';

  final PrinterCrashlyticsService _crashlytics;
  final esc.PrinterManager _manager = esc.PrinterManager();

  PrinterError? _lastError;

  @override
  PrinterError? get lastError => _lastError;

  void _clearLastError() {
    _lastError = null;
  }

  void _recordError(
    String action,
    Object error, {
    Map<String, Object?>? context,
  }) {
    final printerError = PrinterError.fromObject(error);
    _lastError = printerError;
    logPrinterError(action, printerError, context: context);
    unawaited(
      _crashlytics.reportError(
        action: action,
        error: printerError,
        context: context,
      ),
    );
  }

  void _recordPrinterError(
    String action,
    PrinterError error, {
    Map<String, Object?>? context,
  }) {
    _lastError = error;
    logPrinterError(action, error, context: context);
    unawaited(
      _crashlytics.reportError(
        action: action,
        error: error,
        context: context,
      ),
    );
  }

  esc.UsbPrinterDevice _toUsbDevice(PrinterDeviceModel printer) {
    return esc.UsbPrinterDevice(
      name: printer.displayName,
      identifier: printer.usbIdentifier,
      usbPlatform: esc.UsbPlatform.desktop,
    );
  }

  PrinterDeviceModel _fromUsbDevice(esc.UsbPrinterDevice device) {
    return PrinterDeviceModel(
      name: device.name,
      address: PrinterDeviceModel.usbAddressFor(device.identifier),
      connectionType: PrinterConnectionType.usb,
    );
  }

  Future<bool> _writeBytes(
    List<int> bytes, {
    required String action,
    Map<String, Object?>? context,
  }) async {
    return writeBytesInChunks(
      bytes: bytes,
      action: action,
      context: context,
      writeChunk: (chunk) async {
        try {
          await _manager.printBytes(chunk);
          return true;
        } catch (error) {
          _recordError(action, error, context: context);
          return false;
        }
      },
      onChunkError: (error) {
        _recordPrinterError(action, error, context: context);
      },
    );
  }

  @override
  Future<bool> isBluetoothSupported() async {
    _clearLastError();
    return false;
  }

  @override
  Future<bool> isUsbSupported() async {
    _clearLastError();
    return true;
  }

  @override
  Future<bool> isBluetoothEnabled() async {
    _clearLastError();
    return false;
  }

  @override
  Future<bool> requestPermissions() async {
    _clearLastError();
    return true;
  }

  @override
  Future<bool> isConnected() async {
    _clearLastError();
    try {
      logPrinterAction('isConnected');
      final connected = _manager.isConnected;
      logPrinterSuccess('isConnected', context: {'connected': connected});
      return connected;
    } catch (error) {
      _recordError('isConnected', error);
      return false;
    }
  }

  @override
  Future<PrinterConnectionType> getConnectionType() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return PrinterConnectionTypeX.fromStorageValue(
        prefs.getString(_kConnectionTypeKey),
      );
    } catch (error) {
      _recordError('getConnectionType', error);
      return PrinterConnectionType.usb;
    }
  }

  @override
  Future<void> setConnectionType(PrinterConnectionType type) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kConnectionTypeKey, type.storageValue);
      if (type != PrinterConnectionType.usb) {
        await disconnectPrinter();
        await clearSavedPrinter();
      }
    } catch (error) {
      _recordError('setConnectionType', error);
    }
  }

  @override
  Future<List<PrinterDeviceModel>> scanPrinters(
    PrinterConnectionType type,
  ) async {
    _clearLastError();
    if (type != PrinterConnectionType.usb) {
      return const [];
    }

    try {
      logPrinterAction('scanPrinters', context: {'type': type.storageValue});
      final devices = await _manager.scanPrinters(
        types: {esc.PrinterConnectionType.usb},
      );
      final printers = devices
          .whereType<esc.UsbPrinterDevice>()
          .map(_fromUsbDevice)
          .toList();
      logPrinterSuccess(
        'scanPrinters',
        context: {'count': printers.length, 'type': type.storageValue},
      );
      return printers;
    } catch (error) {
      _recordError(
        'scanPrinters',
        error,
        context: {'type': type.storageValue},
      );
      return const [];
    }
  }

  @override
  Future<bool> stopScan() async {
    _clearLastError();
    logPrinterAction('stopScan');
    return true;
  }

  @override
  Future<bool> connectPrinter(PrinterDeviceModel printer) async {
    _clearLastError();
    final context = {
      'name': printer.displayName,
      'address': printer.address,
      'connectionType': printer.connectionType.storageValue,
    };
    try {
      logPrinterAction('connectPrinter', context: context);
      await _manager.connect(_toUsbDevice(printer));
      if (_manager.isConnected) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_kPrinterNameKey, printer.name);
        await prefs.setString(_kPrinterAddressKey, printer.address);
        await prefs.setString(
          _kConnectionTypeKey,
          PrinterConnectionType.usb.storageValue,
        );
        logPrinterSuccess('connectPrinter', context: context);
        return true;
      }

      _recordPrinterError(
        'connectPrinter',
        const PrinterError(
          code: PrinterErrorCodes.connectionFailed,
          message: 'USB connect did not reach connected state',
          userMessage: Strings.printerConnectionFailed,
        ),
        context: context,
      );
      return false;
    } catch (error) {
      _recordError('connectPrinter', error, context: context);
      return false;
    }
  }

  @override
  Future<bool> disconnectPrinter() async {
    _clearLastError();
    try {
      logPrinterAction('disconnectPrinter');
      await _manager.disconnect();
      await clearSavedPrinter();
      logPrinterSuccess('disconnectPrinter');
      return true;
    } catch (error) {
      _recordError('disconnectPrinter', error);
      return false;
    }
  }

  @override
  Future<PrinterDeviceModel?> getSavedPrinter() async {
    _clearLastError();
    try {
      final prefs = await SharedPreferences.getInstance();
      final address = prefs.getString(_kPrinterAddressKey);
      if (address == null || address.trim().isEmpty) {
        return null;
      }

      return PrinterDeviceModel(
        name: prefs.getString(_kPrinterNameKey) ?? '',
        address: address,
        connectionType: PrinterConnectionTypeX.fromStorageValue(
          prefs.getString(_kConnectionTypeKey),
        ),
      );
    } catch (error) {
      _recordError('getSavedPrinter', error);
      return null;
    }
  }

  @override
  Future<void> clearSavedPrinter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kPrinterNameKey);
      await prefs.remove(_kPrinterAddressKey);
      logPrinterAction('clearSavedPrinter');
    } catch (error) {
      _recordError('clearSavedPrinter', error);
    }
  }

  @override
  Future<PrinterPaperSize> getPaperSize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return PrinterPaperSize.fromStorageValue(
        prefs.getString(_kPaperSizeKey),
      );
    } catch (error) {
      _recordError('getPaperSize', error);
      return PrinterPaperSize.mm80;
    }
  }

  @override
  Future<void> setPaperSize(PrinterPaperSize paperSize) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kPaperSizeKey, paperSize.storageValue);
      logPrinterSuccess(
        'setPaperSize',
        context: {'paperSize': paperSize.storageValue},
      );
    } catch (error) {
      _recordError('setPaperSize', error);
    }
  }

  @override
  Future<bool> printReceipt(
    ReceiptPrintData data, {
    required PrinterPaperSize paperSize,
  }) async {
    _clearLastError();
    final context = {'orderNumber': data.orderNumber};
    try {
      logPrinterAction('printReceipt', context: context);
      final bytes = await buildReceiptEscPosBytes(
        data,
        paperSize: paperSize.toEscPosPaperSize,
      );
      final success = await _writeBytes(
        bytes,
        action: 'printReceipt',
        context: context,
      );
      if (success) {
        logPrinterSuccess('printReceipt', context: context);
        return true;
      }
      return false;
    } catch (error) {
      _recordError('printReceipt', error, context: context);
      return false;
    }
  }

  String _paperWidthLabel(PrinterPaperSize paperSize) => switch (paperSize) {
    PrinterPaperSize.mm58 => Strings.paperWidth58,
    PrinterPaperSize.mm80 => Strings.paperWidth80,
  };

  @override
  Future<bool> printDemoReceipt({
    required PrinterPaperSize paperSize,
    required String storeName,
  }) async {
    _clearLastError();
    final context = {'paperSize': paperSize.storageValue};
    try {
      logPrinterAction('printDemoReceipt', context: context);
      final bytes = await buildDemoEscPosBytes(
        paperSize: paperSize.toEscPosPaperSize,
        storeName: storeName,
        dateTimeText: formatDate(DateTime.now()),
        paperWidthLabel: _paperWidthLabel(paperSize),
      );
      final success = await _writeBytes(
        bytes,
        action: 'printDemoReceipt',
        context: context,
      );
      if (success) {
        logPrinterSuccess('printDemoReceipt', context: context);
        return true;
      }
      return false;
    } catch (error) {
      _recordError('printDemoReceipt', error, context: context);
      return false;
    }
  }
}
