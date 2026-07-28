// lib/src/main/model/dropdown_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

class DropdownItemModel {
  final String id;
  final String name;

  const DropdownItemModel({required this.id, required this.name});

  factory DropdownItemModel.fromJson(Map<String, dynamic> json) =>
      DropdownItemModel(
        id: convertToString(json['id']),
        name: convertToString(json['name']),
      );
}

class DropdownProductModel {
  final int id;
  final String name;

  const DropdownProductModel({
    required this.id,
    required this.name,
  });

  factory DropdownProductModel.fromJson(Map<String, dynamic> json) =>
      DropdownProductModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
      );
}

class DropdownCustomerModel {
  final int id;
  final String name;

  const DropdownCustomerModel({
    required this.id,
    required this.name,
  });

  factory DropdownCustomerModel.fromJson(Map<String, dynamic> json) =>
      DropdownCustomerModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
      );
}

class DropdownsDataModel {
  final List<DropdownProductModel> products;
  final List<DropdownCustomerModel> customers;
  final List<DropdownItemModel> paymentMethods;
  final List<DropdownItemModel> paymentStatuses;
  final List<DropdownItemModel> discountTypes;

  const DropdownsDataModel({
    this.products = const [],
    this.customers = const [],
    this.paymentMethods = const [],
    this.paymentStatuses = const [],
    this.discountTypes = const [],
  });

  factory DropdownsDataModel.fromJson(Map<String, dynamic> json) {
    return DropdownsDataModel(
      products: convertToList(json['products'])
          .map((e) => DropdownProductModel.fromJson(convertToMap(e)))
          .toList(),
      customers: convertToList(json['customers'])
          .map((e) => DropdownCustomerModel.fromJson(convertToMap(e)))
          .toList(),
      paymentMethods: convertToList(json['payment_methods'])
          .map((e) => DropdownItemModel.fromJson(convertToMap(e)))
          .toList(),
      paymentStatuses: convertToList(json['payment_statuses'])
          .map((e) => DropdownItemModel.fromJson(convertToMap(e)))
          .toList(),
      discountTypes: convertToList(json['discount_types'])
          .map((e) => DropdownItemModel.fromJson(convertToMap(e)))
          .toList(),
    );
  }
}
