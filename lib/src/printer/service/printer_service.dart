// lib/src/printer/service/printer_service.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/src/printer/model/printer_device_model.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';
import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/src/printer/service/printer_service_mobile.dart'
    if (dart.library.html) 'package:thuga/src/printer/service/printer_service_web.dart';
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
  Future<bool> printDemoReceipt({
    required PrinterPaperSize paperSize,
    required String storeName,
  });
}

@Riverpod(keepAlive: true)
PrinterService printerService(Ref ref) {
  return createPrinterService(ref.read(printerCrashlyticsServiceProvider));
}
