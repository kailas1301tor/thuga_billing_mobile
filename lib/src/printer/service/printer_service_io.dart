// lib/src/printer/service/printer_service_io.dart
import 'dart:io';

import 'package:thuga/src/printer/service/printer_crashlytics_service.dart';
import 'package:thuga/src/printer/service/printer_service.dart';
import 'package:thuga/src/printer/service/printer_service_mobile.dart';
import 'package:thuga/src/printer/service/printer_service_windows.dart';

PrinterService createPrinterService(PrinterCrashlyticsService crashlytics) {
  if (Platform.isWindows) {
    return createWindowsPrinterService(crashlytics);
  }
  return createMobilePrinterService(crashlytics);
}
