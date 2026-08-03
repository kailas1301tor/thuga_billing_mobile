// lib/src/printer/service/printer_service.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/src/printer/model/printer_connection_type.dart';
import 'package:thuga/src/printer/model/printer_device_model.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';
import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/src/printer/service/printer_service_io.dart'
    if (dart.library.html) 'package:thuga/src/printer/service/printer_service_web.dart';
import 'package:thuga/utils/helpers/printer_error_helper.dart';
import 'package:thuga/utils/helpers/receipt_print_helper.dart';

part 'printer_service.g.dart';

abstract class PrinterService {
  PrinterError? get lastError;

  Future<bool> isBluetoothSupported();
  Future<bool> isUsbSupported();
  Future<bool> isBluetoothEnabled();
  Future<bool> requestPermissions();
  Future<bool> isConnected();
  Future<PrinterConnectionType> getConnectionType();
  Future<void> setConnectionType(PrinterConnectionType type);
  Future<List<PrinterDeviceModel>> scanPrinters(PrinterConnectionType type);
  Future<bool> stopScan();
  Future<bool> connectPrinter(PrinterDeviceModel printer);
  Future<bool> disconnectPrinter();
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
