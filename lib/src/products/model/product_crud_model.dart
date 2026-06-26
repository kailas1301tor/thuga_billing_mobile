// lib/src/products/model/product_crud_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

/// GET /api/products
class ProductResponse {
  final String message;
  final ProductResults results;

  const ProductResponse({required this.message, required this.results});

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        message: convertToString(json['message']),
        results: ProductResults.fromJson(convertToMap(json['results'])),
      );
}

class ProductResults {
  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int itemPerPage;
  final List<ProductCrudModel> data;

  const ProductResults({
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.itemPerPage,
    required this.data,
  });

  factory ProductResults.fromJson(Map<String, dynamic> json) => ProductResults(
        totalCount: convertToInt(json['total_count']),
        totalPages: convertToInt(json['total_pages']),
        currentPage: convertToInt(json['current_page']),
        itemPerPage: convertToInt(json['item_per_page']),
        data: convertToList(json['data'])
            .map((x) => ProductCrudModel.fromJson(convertToMap(x)))
            .toList(),
      );
}

/// POST /api/products, PUT /api/products?id=`id`
class ProductAddResponse {
  final String message;
  final ProductAddResults results;

  const ProductAddResponse({required this.message, required this.results});

  factory ProductAddResponse.fromJson(Map<String, dynamic> json) => ProductAddResponse(
        message: convertToString(json['message']),
        results: ProductAddResults.fromJson(convertToMap(json['results'])),
      );
}

class ProductAddResults {
  final ProductCrudModel data;

  const ProductAddResults({required this.data});

  factory ProductAddResults.fromJson(Map<String, dynamic> json) => ProductAddResults(
        data: ProductCrudModel.fromJson(convertToMap(json['data'])),
      );
}

/// DELETE /api/products?id=`id`
class ProductDeleteResponse {
  final String message;

  const ProductDeleteResponse({required this.message});

  factory ProductDeleteResponse.fromJson(Map<String, dynamic> json) => ProductDeleteResponse(
        message: convertToString(json['message']),
      );
}

class ProductCrudModel {
  final int id;
  final int? categoryId;
  final String? categoryName;
  final String name;
  final double quantity;
  final double price;
  final bool isQuickProduct;
  final bool isActive;
  final bool deleted;
  final String? image;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductCrudModel({
    required this.id,
    this.categoryId,
    this.categoryName,
    required this.name,
    required this.quantity,
    required this.price,
    this.isQuickProduct = false,
    this.isActive = true,
    this.deleted = false,
    this.image,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductCrudModel.fromJson(Map<String, dynamic> json) => ProductCrudModel(
        id: convertToInt(json['id']),
        categoryId: convertToInt(json['category']),
        categoryName: convertToString(json['category_name']),
        name: convertToString(json['name']),
        quantity: convertToDouble(json['qty']),
        price: convertToDouble(json['price']),
        isQuickProduct: convertToBool(json['is_quick_product']),
        isActive: convertToBool(json['is_active']),
        deleted: convertToBool(json['deleted']),
        image: json['image'] != null ? convertToString(json['image']) : null,
        imageUrl: json['image_url'] != null ? convertToString(json['image_url']) : null,
        createdAt: json['created_at'] != null ? DateTime.tryParse(convertToString(json['created_at'])) : null,
        updatedAt: json['updated_at'] != null ? DateTime.tryParse(convertToString(json['updated_at'])) : null,
      );
}
