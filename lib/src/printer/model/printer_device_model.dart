// lib/src/printer/model/printer_device_model.dart
class PrinterDeviceModel {
  const PrinterDeviceModel({
    required this.name,
    required this.address,
    this.isConnected = false,
  });

  final String name;
  final String address;
  final bool isConnected;

  String get displayName => name.trim().isEmpty ? address : name;

  PrinterDeviceModel copyWith({
    String? name,
    String? address,
    bool? isConnected,
  }) {
    return PrinterDeviceModel(
      name: name ?? this.name,
      address: address ?? this.address,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
