// lib/src/printer/service/printer_service.dart
import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/src/printer/model/printer_device_model.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';
import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/utils/helpers/printer_error_helper.dart';
import 'package:thuga/utils/helpers/receipt_print_helper.dart';

part 'printer_service.g.dart';

abstract class PrinterService {
  PrinterError? get lastError;

  Future<bool> isBluetoothSupported();
  Future<bool> isBluetoothEnabled();
  Future<bool> requestPermissions();
  Future<bool> isConnected();
  Future<List<PrinterDeviceModel>> scanBluetoothPrinters();
  Future<bool> stopBluetoothScan();
  Future<bool> connectBluetooth(PrinterDeviceModel printer);
  Future<bool> disconnectBluetooth();
  Future<PrinterDeviceModel?> getSavedPrinter();
  Future<void> clearSavedPrinter();
  Future<PrinterPaperSize> getPaperSize();
  Future<void> setPaperSize(PrinterPaperSize paperSize);
  Future<bool> printReceipt(
    ReceiptPrintData data, {
    required PrinterPaperSize paperSize,
  });
}

class PrinterServiceImpl implements PrinterService {
  PrinterServiceImpl(this._crashlytics);

  static const _kPrinterNameKey = 'pref_printer_name';
  static const _kPrinterAddressKey = 'pref_printer_address';
  static const _kPaperSizeKey = 'pref_printer_paper_size';

  final PrinterCrashlyticsService _crashlytics;

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

  @override
  Future<bool> isBluetoothSupported() async {
    _clearLastError();
    return Platform.isAndroid || Platform.isIOS;
  }

  @override
  Future<bool> isBluetoothEnabled() async {
    _clearLastError();
    try {
      logPrinterAction('isBluetoothEnabled');
      final enabled = await PrintBluetoothThermal.bluetoothEnabled;
      logPrinterSuccess('isBluetoothEnabled', context: {'enabled': enabled});
      return enabled;
    } catch (error) {
      _recordError('isBluetoothEnabled', error);
      return false;
    }
  }

  @override
  Future<bool> requestPermissions() async {
    _clearLastError();
    try {
      if (Platform.isAndroid) {
        final statuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
        ].request();

        final granted = statuses.values.every((status) => status.isGranted);
        if (!granted) {
          _recordPrinterError(
            'requestPermissions',
            const PrinterError(
              code: PrinterErrorCodes.permissionDenied,
              message: 'One or more Bluetooth permissions were denied',
              userMessage: Strings.printerPermissionDenied,
            ),
          );
          return false;
        }
      } else if (Platform.isIOS) {
        final bluetooth = await Permission.bluetooth.request();
        final granted = bluetooth.isGranted || bluetooth.isLimited;
        if (!granted) {
          _recordPrinterError(
            'requestPermissions',
            const PrinterError(
              code: PrinterErrorCodes.permissionDenied,
              message: 'Bluetooth permission was denied',
              userMessage: Strings.printerPermissionDenied,
            ),
          );
          return false;
        }
      }

      final pluginGranted =
          await PrintBluetoothThermal.isPermissionBluetoothGranted;
      if (!pluginGranted) {
        _recordPrinterError(
          'requestPermissions',
          const PrinterError(
            code: PrinterErrorCodes.permissionDenied,
            message: 'Bluetooth permission was denied by the system',
            userMessage: Strings.printerPermissionDenied,
          ),
        );
      }
      return pluginGranted;
    } catch (error) {
      _recordError('requestPermissions', error);
      return false;
    }
  }

  @override
  Future<bool> isConnected() async {
    _clearLastError();
    try {
      logPrinterAction('isConnected');
      final connected = await PrintBluetoothThermal.connectionStatus;
      logPrinterSuccess('isConnected', context: {'connected': connected});
      return connected;
    } catch (error) {
      _recordError('isConnected', error);
      return false;
    }
  }

  @override
  Future<List<PrinterDeviceModel>> scanBluetoothPrinters() async {
    _clearLastError();
    try {
      logPrinterAction('scanBluetoothPrinters');
      final printers = await PrintBluetoothThermal.pairedBluetooths;
      final devices = printers
          .map(
            (printer) => PrinterDeviceModel(
              name: printer.name,
              address: printer.macAdress,
            ),
          )
          .toList();
      logPrinterSuccess(
        'scanBluetoothPrinters',
        context: {'count': devices.length},
      );
      return devices;
    } catch (error) {
      _recordError('scanBluetoothPrinters', error);
      return const [];
    }
  }

  @override
  Future<bool> stopBluetoothScan() async {
    _clearLastError();
    logPrinterAction('stopBluetoothScan');
    return true;
  }

  @override
  Future<bool> connectBluetooth(PrinterDeviceModel printer) async {
    _clearLastError();
    final context = {
      'name': printer.displayName,
      'address': printer.address,
    };
    try {
      logPrinterAction('connectBluetooth', context: context);
      final isConnected = await PrintBluetoothThermal.connect(
        macPrinterAddress: printer.address,
      );
      if (isConnected) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_kPrinterNameKey, printer.name);
        await prefs.setString(_kPrinterAddressKey, printer.address);
        logPrinterSuccess('connectBluetooth', context: context);
        return true;
      }

      _recordPrinterError(
        'connectBluetooth',
        const PrinterError(
          code: PrinterErrorCodes.connectionFailed,
          message: 'connect returned false',
          userMessage: Strings.printerConnectionFailed,
        ),
        context: context,
      );
      return false;
    } catch (error) {
      _recordError('connectBluetooth', error, context: context);
      return false;
    }
  }

  @override
  Future<bool> disconnectBluetooth() async {
    _clearLastError();
    try {
      logPrinterAction('disconnectBluetooth');
      final result = await PrintBluetoothThermal.disconnect;
      if (result) {
        await clearSavedPrinter();
        logPrinterSuccess('disconnectBluetooth');
      } else {
        _recordPrinterError(
          'disconnectBluetooth',
          const PrinterError(
            code: PrinterErrorCodes.disconnectFailed,
            message: 'disconnect returned false',
            userMessage: Strings.printerUnknownError,
          ),
        );
      }
      return result;
    } catch (error) {
      _recordError('disconnectBluetooth', error);
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
      final success = await PrintBluetoothThermal.writeBytes(bytes);
      if (success) {
        logPrinterSuccess('printReceipt', context: context);
        return true;
      }

      _recordPrinterError(
        'printReceipt',
        const PrinterError(
          code: PrinterErrorCodes.printFailed,
          message: 'writeBytes returned false',
          userMessage: Strings.printerPrintFailed,
        ),
        context: context,
      );
      return false;
    } catch (error) {
      _recordError('printReceipt', error, context: context);
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
PrinterService printerService(Ref ref) {
  return PrinterServiceImpl(ref.read(printerCrashlyticsServiceProvider));
}
