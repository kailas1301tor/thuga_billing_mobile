// lib/src/printer/service/printer_service.dart
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_thermal_printer_plus/flutter_thermal_printer_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyapapp/src/printer/model/printer_device_model.dart';
import 'package:vyapapp/utils/helpers/receipt_print_helper.dart';

part 'printer_service.g.dart';

abstract class PrinterService {
  Future<bool> isBluetoothSupported();
  Future<bool> requestPermissions();
  Future<bool> isConnected();
  Future<List<PrinterDeviceModel>> scanBluetoothPrinters();
  Future<bool> stopBluetoothScan();
  Future<bool> connectBluetooth(PrinterDeviceModel printer);
  Future<bool> disconnectBluetooth();
  Future<PrinterDeviceModel?> getSavedPrinter();
  Future<void> clearSavedPrinter();
  Future<bool> printReceipt(ReceiptPrintData data);
}

class PrinterServiceImpl implements PrinterService {
  static const _kPrinterNameKey = 'pref_printer_name';
  static const _kPrinterAddressKey = 'pref_printer_address';

  @override
  Future<bool> isBluetoothSupported() async {
    return Platform.isAndroid || Platform.isIOS;
  }

  @override
  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();

      return statuses.values.every((status) => status.isGranted);
    }

    if (Platform.isIOS) {
      final bluetooth = await Permission.bluetooth.request();
      return bluetooth.isGranted || bluetooth.isLimited;
    }

    return false;
  }

  @override
  Future<bool> isConnected() {
    return FlutterThermalPrinterPlus.isConnected();
  }

  @override
  Future<List<PrinterDeviceModel>> scanBluetoothPrinters() async {
    final printers = await FlutterThermalPrinterPlus.scanBluetoothDevices();
    return printers
        .map(
          (printer) => PrinterDeviceModel(
            name: printer.name,
            address: printer.address,
            isConnected: printer.isConnected,
          ),
        )
        .toList();
  }

  @override
  Future<bool> stopBluetoothScan() {
    return FlutterThermalPrinterPlus.stopBluetoothScan();
  }

  @override
  Future<bool> connectBluetooth(PrinterDeviceModel printer) async {
    final isConnected = await FlutterThermalPrinterPlus.connectBluetooth(
      printer.address,
    );
    if (isConnected) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kPrinterNameKey, printer.name);
      await prefs.setString(_kPrinterAddressKey, printer.address);
    }
    return isConnected;
  }

  @override
  Future<bool> disconnectBluetooth() async {
    final result = await FlutterThermalPrinterPlus.disconnectBluetooth();
    if (result) {
      await clearSavedPrinter();
    }
    return result;
  }

  @override
  Future<PrinterDeviceModel?> getSavedPrinter() async {
    final prefs = await SharedPreferences.getInstance();
    final address = prefs.getString(_kPrinterAddressKey);
    if (address == null || address.trim().isEmpty) {
      return null;
    }

    return PrinterDeviceModel(
      name: prefs.getString(_kPrinterNameKey) ?? '',
      address: address,
    );
  }

  @override
  Future<void> clearSavedPrinter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kPrinterNameKey);
    await prefs.remove(_kPrinterAddressKey);
  }

  @override
  Future<bool> printReceipt(ReceiptPrintData data) {
    final builder = buildReceiptPrintBuilder(data);
    return FlutterThermalPrinterPlus.print(builder);
  }
}

@Riverpod(keepAlive: true)
PrinterService printerService(Ref ref) {
  return PrinterServiceImpl();
}
