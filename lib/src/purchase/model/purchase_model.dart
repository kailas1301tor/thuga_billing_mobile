// lib/src/purchase/model/purchase_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class PurchaseItemModel {
  final int id;
  final int productId;
  final String productName;
  final int quantity;
  final double price;
  final double totalPrice;

  const PurchaseItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    return PurchaseItemModel(
      id: convertToInt(json['id']),
      productId: convertToInt(json['product']),
      productName: convertToString(json['product_name']),
      quantity: convertToInt(json['qty']),
      price: convertToDouble(json['price']),
      totalPrice: convertToDouble(json['total_price']),
    );
  }
}

class PurchaseModel {
  final int id;
  final String purchaseDate;
  final double totalAmount;
  final DateTime createdAt;
  final List<PurchaseItemModel> items;

  const PurchaseModel({
    required this.id,
    required this.purchaseDate,
    required this.totalAmount,
    required this.createdAt,
    required this.items,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: convertToInt(json['id']),
      purchaseDate: convertToString(json['purchase_date']),
      totalAmount: convertToDouble(json['total_amount']),
      createdAt: DateTime.tryParse(convertToString(json['created_at'])) ?? DateTime.now(),
      items: convertToList(json['items'])
          .map((e) => PurchaseItemModel.fromJson(convertToMap(e)))
          .toList(),
    );
  }
}

class PurchasesResponseModel {
  final String message;
  final List<PurchaseModel> purchases;

  const PurchasesResponseModel({
    required this.message,
    required this.purchases,
  });

  factory PurchasesResponseModel.fromJson(Map<String, dynamic> json) {
    final resultsMap = convertToMap(json['results']);
    final dataMap = convertToMap(resultsMap['data']);
    return PurchasesResponseModel(
      message: convertToString(json['message']),
      purchases: convertToList(dataMap['purchases'])
          .map((e) => PurchaseModel.fromJson(convertToMap(e)))
          .toList(),
    );
  }
}

class CreatePurchaseResponseModel {
  final String message;
  final PurchaseModel purchase;

  const CreatePurchaseResponseModel({
    required this.message,
    required this.purchase,
  });

  factory CreatePurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    final resultsMap = convertToMap(json['results']);
    final dataMap = convertToMap(resultsMap['data']);
    return CreatePurchaseResponseModel(
      message: convertToString(json['message']),
      purchase: PurchaseModel.fromJson(dataMap),
    );
  }
}
