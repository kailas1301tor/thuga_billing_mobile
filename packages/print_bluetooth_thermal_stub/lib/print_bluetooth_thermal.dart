// packages/print_bluetooth_thermal_stub/lib/print_bluetooth_thermal.dart
library print_bluetooth_thermal;

class BluetoothInfo {
  const BluetoothInfo({
    required this.name,
    required this.macAdress,
  });

  final String name;
  final String macAdress;
}

abstract final class PrintBluetoothThermal {
  static Future<bool> get bluetoothEnabled async => false;

  static Future<bool> get isPermissionBluetoothGranted async => false;

  static Future<bool> get connectionStatus async => false;

  static Future<List<BluetoothInfo>> get pairedBluetooths async =>
      const <BluetoothInfo>[];

  static Future<bool> connect({required String macPrinterAddress}) async =>
      false;

  static Future<bool> get disconnect async => false;

  static Future<bool> writeBytes(List<int> bytes) async => false;
}
