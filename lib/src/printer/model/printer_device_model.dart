// lib/src/printer/model/printer_device_model.dart
import 'package:thuga/src/printer/model/printer_connection_type.dart';

class PrinterDeviceModel {
  const PrinterDeviceModel({
    required this.name,
    required this.address,
    this.connectionType = PrinterConnectionType.bluetooth,
    this.isConnected = false,
    this.vendorId,
    this.productId,
  });

  final String name;
  final String address;
  final PrinterConnectionType connectionType;
  final bool isConnected;
  final int? vendorId;
  final int? productId;

  String get displayName => name.trim().isEmpty ? address : name;

  String get usbIdentifier {
    if (connectionType != PrinterConnectionType.usb) {
      return '';
    }
    if (address.startsWith('usb:')) {
      return address.substring(4);
    }
    return address;
  }

  static String usbAddressFor(String identifier) => 'usb:$identifier';

  PrinterDeviceModel copyWith({
    String? name,
    String? address,
    PrinterConnectionType? connectionType,
    bool? isConnected,
    int? vendorId,
    int? productId,
  }) {
    return PrinterDeviceModel(
      name: name ?? this.name,
      address: address ?? this.address,
      connectionType: connectionType ?? this.connectionType,
      isConnected: isConnected ?? this.isConnected,
      vendorId: vendorId ?? this.vendorId,
      productId: productId ?? this.productId,
    );
  }
}
