// lib/src/new_bill/model/new_bill_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class CategoriesWithProductsResponse {
  final String message;
  final CategoriesWithProductsResults results;

  const CategoriesWithProductsResponse({
    required this.message,
    required this.results,
  });

  factory CategoriesWithProductsResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesWithProductsResponse(
        message: convertToString(json['message']),
        results: CategoriesWithProductsResults.fromJson(convertToMap(json['results'])),
      );
}

class CategoriesWithProductsResults {
  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int itemPerPage;
  final List<CategoryWithProductsModel> data;

  const CategoriesWithProductsResults({
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.itemPerPage,
    required this.data,
  });

  factory CategoriesWithProductsResults.fromJson(Map<String, dynamic> json) =>
      CategoriesWithProductsResults(
        totalCount: convertToInt(json['total_count']),
        totalPages: convertToInt(json['total_pages']),
        currentPage: convertToInt(json['current_page']),
        itemPerPage: convertToInt(json['item_per_page']),
        data: convertToList(json['data'])
            .map((x) => CategoryWithProductsModel.fromJson(convertToMap(x)))
            .toList(),
      );
}

class CategoryWithProductsModel {
  final int id;
  final String name;
  final bool isActive;
  final bool deleted;
  final List<ProductModel> products;

  const CategoryWithProductsModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.deleted,
    required this.products,
  });

  factory CategoryWithProductsModel.fromJson(Map<String, dynamic> json) =>
      CategoryWithProductsModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
        isActive: convertToBool(json['is_active']),
        deleted: convertToBool(json['deleted']),
        products: convertToList(json['products'])
            .map((x) => ProductModel.fromJson(convertToMap(x)))
            .toList(),
      );
}

class ProductModel {
  final int id;
  final int categoryId;
  final String categoryName;
  final String name;
  final double quantity;
  final double price;
  final String? image;
  final String? imageUrl;
  final bool isQuickProduct;
  final bool isActive;
  final bool deleted;

  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.quantity,
    required this.price,
    this.image,
    this.imageUrl,
    required this.isQuickProduct,
    required this.isActive,
    required this.deleted,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: convertToInt(json['id']),
        categoryId: convertToInt(json['category']),
        categoryName: convertToString(json['category_name']),
        name: convertToString(json['name']),
        quantity: convertToDouble(json['qty']),
        price: convertToDouble(json['price']),
        image: json['image'] != null ? convertToString(json['image']) : null,
        imageUrl: json['image_url'] != null ? convertToString(json['image_url']) : null,
        isQuickProduct: convertToBool(json['is_quick_product']),
        isActive: convertToBool(json['is_active']),
        deleted: convertToBool(json['deleted']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': categoryId,
        'category_name': categoryName,
        'name': name,
        'qty': quantity,
        'price': price.toString(),
        'image': image,
        'image_url': imageUrl,
        'is_quick_product': isQuickProduct,
        'is_active': isActive,
        'deleted': deleted,
      };
}

class BillResponse {
  final String message;

  const BillResponse({required this.message});

  factory BillResponse.fromJson(Map<String, dynamic> json) => BillResponse(
        message: convertToString(json['message']),
      );
}

class CartItemModel {
  const CartItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.emoji,
    this.imageUrl,
    this.isCustom = false,
  });

  final int? productId;
  final String name;
  final double price;
  final int quantity;
  final String emoji;
  final String? imageUrl;
  final bool isCustom;

  double get lineTotal => price * quantity;

  CartItemModel copyWith({
    int? productId,
    String? name,
    double? price,
    int? quantity,
    String? emoji,
    String? imageUrl,
    bool? isCustom,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      emoji: emoji ?? this.emoji,
      imageUrl: imageUrl ?? this.imageUrl,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        productId: json['productId'] != null ? convertToInt(json['productId']) : null,
        name: convertToString(json['name']),
        price: convertToDouble(json['price']),
        quantity: convertToInt(json['quantity']),
        emoji: convertToString(json['emoji']),
        imageUrl: json['imageUrl'] != null ? convertToString(json['imageUrl']) : null,
        isCustom: convertToBool(json['isCustom']),
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'emoji': emoji,
        'imageUrl': imageUrl,
        'isCustom': isCustom,
      };
}
