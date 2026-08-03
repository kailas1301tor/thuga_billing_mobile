// lib/src/printer/model/printer_connection_type.dart
enum PrinterConnectionType {
  bluetooth,
  usb,
}

extension PrinterConnectionTypeX on PrinterConnectionType {
  String get storageValue => switch (this) {
    PrinterConnectionType.bluetooth => 'bluetooth',
    PrinterConnectionType.usb => 'usb',
  };

  static PrinterConnectionType fromStorageValue(String? value) {
    return switch (value) {
      'usb' => PrinterConnectionType.usb,
      _ => PrinterConnectionType.bluetooth,
    };
  }
}
