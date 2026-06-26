// lib/src/settings/model/settings_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class SettingsModel {
  const SettingsModel({
    required this.storeName,
    required this.email,
    required this.autoPrint,
    required this.defaultPaymentMethod,
    required this.taxRate,
  });

  final String storeName;
  final String email;
  final bool autoPrint;
  final String defaultPaymentMethod;
  final double taxRate;

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      storeName: convertToString(json['storeName']),
      email: convertToString(json['email']),
      autoPrint: convertToBool(json['autoPrint']),
      defaultPaymentMethod: convertToString(json['defaultPaymentMethod']),
      taxRate: convertToDouble(json['taxRate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'storeName': storeName,
        'email': email,
        'autoPrint': autoPrint,
        'defaultPaymentMethod': defaultPaymentMethod,
        'taxRate': taxRate,
      };

  SettingsModel copyWith({
    String? storeName,
    String? email,
    bool? autoPrint,
    String? defaultPaymentMethod,
    double? taxRate,
  }) {
    return SettingsModel(
      storeName: storeName ?? this.storeName,
      email: email ?? this.email,
      autoPrint: autoPrint ?? this.autoPrint,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
      taxRate: taxRate ?? this.taxRate,
    );
  }
}
