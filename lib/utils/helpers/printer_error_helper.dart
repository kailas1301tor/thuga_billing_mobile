// lib/utils/helpers/printer_error_helper.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:thuga/res/constants/string_constants.dart';

/// Native platform error codes returned by the thermal printer plugin.
abstract final class PrinterErrorCodes {
  static const bluetoothDisabled = 'BLUETOOTH_DISABLED';
  static const bluetoothNotAvailable = 'BLUETOOTH_NOT_AVAILABLE';
  static const permissionDenied = 'PERMISSION_DENIED';
  static const connectionFailed = 'CONNECTION_FAILED';
  static const deviceNotFound = 'DEVICE_NOT_FOUND';
  static const notConnected = 'NOT_CONNECTED';
  static const printFailed = 'PRINT_FAILED';
  static const disconnectFailed = 'DISCONNECT_FAILED';
  static const stopScanFailed = 'STOP_SCAN_FAILED';
  static const invalidArgument = 'INVALID_ARGUMENT';
}

/// Parsed printer error with platform code and user-facing message.
class PrinterError {
  const PrinterError({
    required this.code,
    required this.message,
    required this.userMessage,
    this.details,
  });

  final String code;
  final String message;
  final String userMessage;
  final Object? details;

  factory PrinterError.fromObject(Object error) {
    if (error is PlatformException) {
      return PrinterError.fromPlatformException(error);
    }

    final message = error.toString();
    final codeMatch = RegExp(
      r'code=([A-Z_]+)',
    ).firstMatch(message);
    final code = codeMatch?.group(1) ?? 'UNKNOWN';

    return PrinterError(
      code: code,
      message: message,
      userMessage: mapPrinterErrorCodeToMessage(code),
      details: error,
    );
  }

  factory PrinterError.fromPlatformException(PlatformException exception) {
    final code = exception.code.isNotEmpty ? exception.code : 'UNKNOWN';
    return PrinterError(
      code: code,
      message: exception.message ?? exception.toString(),
      userMessage: mapPrinterErrorCodeToMessage(code),
      details: exception.details,
    );
  }
}

String mapPrinterErrorCodeToMessage(String code) {
  return switch (code) {
    PrinterErrorCodes.bluetoothDisabled ||
    PrinterErrorCodes.bluetoothNotAvailable =>
      Strings.printerBluetoothDisabled,
    PrinterErrorCodes.permissionDenied => Strings.printerPermissionDenied,
    PrinterErrorCodes.connectionFailed => Strings.printerConnectionFailed,
    PrinterErrorCodes.deviceNotFound => Strings.printerDeviceNotFound,
    PrinterErrorCodes.notConnected => Strings.printerNotConnected,
    PrinterErrorCodes.printFailed => Strings.printerPrintFailed,
    PrinterErrorCodes.stopScanFailed ||
    PrinterErrorCodes.invalidArgument ||
    'SCAN_FAILED' =>
      Strings.printerScanFailed,
    _ => Strings.printerUnknownError,
  };
}

void logPrinterAction(String action, {Map<String, Object?>? context}) {
  final details = context?.entries
      .map((entry) => '${entry.key}=${entry.value}')
      .join(' ');
  debugPrint(
    details == null || details.isEmpty
        ? '🔵 PRINTER ACTION: $action'
        : '🔵 PRINTER ACTION: $action | $details',
  );
}

void logPrinterSuccess(String action, {Map<String, Object?>? context}) {
  final details = context?.entries
      .map((entry) => '${entry.key}=${entry.value}')
      .join(' ');
  debugPrint(
    details == null || details.isEmpty
        ? '🟢 PRINTER SUCCESS: $action'
        : '🟢 PRINTER SUCCESS: $action | $details',
  );
}

void logPrinterError(
  String action,
  PrinterError error, {
  Map<String, Object?>? context,
}) {
  final contextDetails = context?.entries
      .map((entry) => '${entry.key}=${entry.value}')
      .join(' ');
  final suffix = contextDetails == null || contextDetails.isEmpty
      ? ''
      : ' | $contextDetails';
  debugPrint(
    '🔴 PRINTER ERROR: $action | code=${error.code} | message=${error.message}$suffix',
  );
  if (error.details != null) {
    debugPrint('🔴 PRINTER ERROR DETAILS: ${error.details}');
  }
}

void logPrinterUnexpected(
  String action,
  Object error, {
  Map<String, Object?>? context,
}) {
  final contextDetails = context?.entries
      .map((entry) => '${entry.key}=${entry.value}')
      .join(' ');
  final suffix = contextDetails == null || contextDetails.isEmpty
      ? ''
      : ' | $contextDetails';
  debugPrint('🔴 PRINTER UNEXPECTED: $action | $error$suffix');
}
