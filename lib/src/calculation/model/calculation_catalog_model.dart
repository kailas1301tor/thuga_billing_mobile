// lib/src/calculation/model/calculation_catalog_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

class CalculationCatalogResponse {
  const CalculationCatalogResponse({
    required this.message,
    required this.results,
  });

  final String message;
  final CalculationCatalogResults results;

  factory CalculationCatalogResponse.fromJson(Map<String, dynamic> json) =>
      CalculationCatalogResponse(
        message: convertToString(json['message']),
        results: CalculationCatalogResults.fromJson(convertToMap(json['results'])),
      );
}

class CalculationCatalogResults {
  const CalculationCatalogResults({
    required this.totalPages,
    required this.currentPage,
    required this.data,
  });

  final int totalPages;
  final int currentPage;
  final List<CalculationCategoryModel> data;

  factory CalculationCatalogResults.fromJson(Map<String, dynamic> json) =>
      CalculationCatalogResults(
        totalPages: convertToInt(json['total_pages']),
        currentPage: convertToInt(json['current_page']),
        data: convertToList(json['data'])
            .map((e) => CalculationCategoryModel.fromJson(convertToMap(e)))
            .toList(),
      );
}

class CalculationCategoryModel {
  const CalculationCategoryModel({
    required this.id,
    required this.name,
    required this.products,
  });

  final int id;
  final String name;
  final List<CalculationProductModel> products;

  factory CalculationCategoryModel.fromJson(Map<String, dynamic> json) =>
      CalculationCategoryModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
        products: convertToList(json['products'])
            .map((e) => CalculationProductModel.fromJson(convertToMap(e)))
            .toList(),
      );
}

class CalculationProductModel {
  const CalculationProductModel({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.price,
    this.quantity,
    this.barcode,
    this.sgst = 0.0,
    this.cgst = 0.0,
    this.imageUrl,
  });

  final int id;
  final int categoryId;
  final String categoryName;
  final String name;
  final double price;
  final double? quantity;
  final String? barcode;
  final double sgst;
  final double cgst;
  final String? imageUrl;

  factory CalculationProductModel.fromJson(Map<String, dynamic> json) =>
      CalculationProductModel(
        id: convertToInt(json['id']),
        categoryId: convertToInt(json['category']),
        categoryName: convertToString(json['category_name']),
        name: convertToString(json['name']),
        price: convertToDouble(json['price']),
        quantity: json['qty'] == null ? null : convertToDouble(json['qty']),
        barcode: json['barcode'] != null ? convertToString(json['barcode']) : null,
        sgst: convertToDouble(json['sgst']),
        cgst: convertToDouble(json['cgst']),
        imageUrl: json['image_url'] == null
            ? null
            : convertToString(json['image_url']),
      );
}
