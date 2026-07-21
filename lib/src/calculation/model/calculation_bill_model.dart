// lib/src/calculation/model/calculation_bill_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class CalculationLineItemModel {
  const CalculationLineItemModel({
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.categoryName,
    required this.quantity,
  });

  final int productId;
  final String productName;
  final int categoryId;
  final String categoryName;
  final int quantity;

  CalculationLineItemModel copyWith({int? quantity}) =>
      CalculationLineItemModel(
        productId: productId,
        productName: productName,
        categoryId: categoryId,
        categoryName: categoryName,
        quantity: quantity ?? this.quantity,
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'category_id': categoryId,
        'category_name': categoryName,
        'quantity': quantity,
      };

  factory CalculationLineItemModel.fromJson(Map<String, dynamic> json) =>
      CalculationLineItemModel(
        productId: convertToInt(json['product_id']),
        productName: convertToString(json['product_name']),
        categoryId: convertToInt(json['category_id']),
        categoryName: convertToString(json['category_name']),
        quantity: convertToInt(json['quantity']),
      );
}

class CalculationCustomerSectionModel {
  const CalculationCustomerSectionModel({
    required this.customerId,
    required this.customerName,
    this.items = const [],
  });

  final int customerId;
  final String customerName;
  final List<CalculationLineItemModel> items;

  CalculationCustomerSectionModel copyWith({
    String? customerName,
    List<CalculationLineItemModel>? items,
  }) =>
      CalculationCustomerSectionModel(
        customerId: customerId,
        customerName: customerName ?? this.customerName,
        items: items ?? this.items,
      );

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'customer_name': customerName,
        'items': items.map((e) => e.toJson()).toList(),
      };

  factory CalculationCustomerSectionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      CalculationCustomerSectionModel(
        customerId: convertToInt(json['customer_id']),
        customerName: convertToString(json['customer_name']),
        items: convertToList(json['items'])
            .map((e) => CalculationLineItemModel.fromJson(convertToMap(e)))
            .toList(),
      );
}

class CalculationBillModel {
  const CalculationBillModel({
    required this.id,
    required this.name,
    required this.customerSections,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final List<CalculationCustomerSectionModel> customerSections;
  final DateTime createdAt;
  final DateTime updatedAt;

  int get customerCount => customerSections.length;

  int get itemCount => customerSections.fold<int>(
        0,
        (sum, section) => sum + section.items.length,
      );

  CalculationBillModel copyWith({
    String? name,
    List<CalculationCustomerSectionModel>? customerSections,
    DateTime? updatedAt,
  }) =>
      CalculationBillModel(
        id: id,
        name: name ?? this.name,
        customerSections: customerSections ?? this.customerSections,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'customer_sections':
            customerSections.map((e) => e.toJson()).toList(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory CalculationBillModel.fromJson(Map<String, dynamic> json) =>
      CalculationBillModel(
        id: convertToString(json['id']),
        name: convertToString(json['name']),
        customerSections: convertToList(json['customer_sections'])
            .map(
              (e) => CalculationCustomerSectionModel.fromJson(convertToMap(e)),
            )
            .toList(),
        createdAt: DateTime.tryParse(convertToString(json['created_at'])) ??
            DateTime.now(),
        updatedAt: DateTime.tryParse(convertToString(json['updated_at'])) ??
            DateTime.now(),
      );
}

class CalculationBillSummaryModel {
  const CalculationBillSummaryModel({
    required this.bill,
    required this.grandTotal,
  });

  final CalculationBillModel bill;
  final double grandTotal;
}
