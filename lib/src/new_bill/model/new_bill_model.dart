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
        isActive: json['status'] != null
            ? convertToString(json['status']).toLowerCase() == 'active'
            : convertToBool(json['is_active']),
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
  final BillResponseData? data;

  const BillResponse({required this.message, this.data});

  factory BillResponse.fromJson(Map<String, dynamic> json) {
    final results = json['results'] != null ? convertToMap(json['results']) : null;
    final dataMap = results != null && results['data'] != null ? convertToMap(results['data']) : null;
    return BillResponse(
      message: convertToString(json['message']),
      data: dataMap != null ? BillResponseData.fromJson(dataMap) : null,
    );
  }
}

class BillResponseData {
  final int id;
  final String orderNumber;
  final String dateString;
  final String paymentMethod;
  final String paymentStatus;
  final double totalAmount;
  final double discountAmount;

  const BillResponseData({
    required this.id,
    required this.orderNumber,
    required this.dateString,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.totalAmount,
    required this.discountAmount,
  });

  factory BillResponseData.fromJson(Map<String, dynamic> json) => BillResponseData(
        id: convertToInt(json['id']),
        orderNumber: convertToString(json['order_number']),
        dateString: convertToString(json['date']),
        paymentMethod: convertToString(json['payment_method']),
        paymentStatus: convertToString(json['payment_status']),
        totalAmount: convertToDouble(json['total_amount']),
        discountAmount: convertToDouble(json['discount_amount']),
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
    this.discountType = 'None',
    this.discountValue = 0.0,
    this.bogoBuyQty,
    this.bogoGetQty,
  });

  final int? productId;
  final String name;
  final double price;
  final int quantity;
  final String emoji;
  final String? imageUrl;
  final bool isCustom;
  final String discountType;
  final double discountValue;
  final int? bogoBuyQty;
  final int? bogoGetQty;

  /// Raw line total without any discount applied.
  double get lineTotal => price * quantity;

  /// Computed discount amount — mirrors backend Python logic exactly.
  double get discountAmount {
    double discount = 0.0;

    switch (discountType) {
      case 'Percentage':
        discount = (price * quantity) * (discountValue / 100);
      case 'Amount':
        discount = discountValue;
      case 'BOGO':
        final buyQty = bogoBuyQty ?? 0;
        final getQty = bogoGetQty ?? 0;
        if (buyQty > 0 && getQty > 0) {
          final freeUnits = (quantity ~/ (buyQty + getQty)) * getQty;
          discount = freeUnits * price;
        }
      case 'Slab':
        discount = (price - discountValue) * quantity;
      default:
        discount = 0.0;
    }

    // Avoid negative totals — cap discount at raw line total
    if (discount > lineTotal) {
      discount = lineTotal;
    }
    return discount < 0 ? 0.0 : discount;
  }

  /// Final price after discount applied.
  double get totalPrice => lineTotal - discountAmount;

  /// Whether this item has an active discount.
  bool get hasDiscount => discountType != 'None' && discountAmount > 0;

  /// Human-readable discount label for UI badges.
  String get discountLabel {
    switch (discountType) {
      case 'Percentage':
        return '${discountValue.toStringAsFixed(discountValue.truncateToDouble() == discountValue ? 0 : 1)}% off';
      case 'Amount':
        return '₹${discountValue.toStringAsFixed(0)} off';
      case 'BOGO':
        return 'Buy ${bogoBuyQty ?? 0} Get ${bogoGetQty ?? 0}';
      case 'Slab':
        return '₹${discountValue.toStringAsFixed(0)}/unit';
      default:
        return '';
    }
  }

  CartItemModel copyWith({
    int? productId,
    String? name,
    double? price,
    int? quantity,
    String? emoji,
    String? imageUrl,
    bool? isCustom,
    String? discountType,
    double? discountValue,
    int? Function()? bogoBuyQty,
    int? Function()? bogoGetQty,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      emoji: emoji ?? this.emoji,
      imageUrl: imageUrl ?? this.imageUrl,
      isCustom: isCustom ?? this.isCustom,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      bogoBuyQty: bogoBuyQty != null ? bogoBuyQty() : this.bogoBuyQty,
      bogoGetQty: bogoGetQty != null ? bogoGetQty() : this.bogoGetQty,
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
        discountType: json['discount_type'] != null
            ? convertToString(json['discount_type'])
            : 'None',
        discountValue: convertToDouble(json['discount_value']),
        bogoBuyQty: json['bogo_buy_qty'] != null
            ? convertToInt(json['bogo_buy_qty'])
            : null,
        bogoGetQty: json['bogo_get_qty'] != null
            ? convertToInt(json['bogo_get_qty'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'emoji': emoji,
        'imageUrl': imageUrl,
        'isCustom': isCustom,
        'discount_type': discountType,
        'discount_value': discountValue,
        'bogo_buy_qty': bogoBuyQty,
        'bogo_get_qty': bogoGetQty,
      };
}
