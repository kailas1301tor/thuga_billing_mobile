// lib/utils/helpers/product_stock_helper.dart

bool isStockTracked(double? stockQuantity) => stockQuantity != null;

bool isOutOfStock(double? stockQuantity) =>
    isStockTracked(stockQuantity) && stockQuantity! <= 0;

/// Returns null when stock is not tracked (unlimited).
/// Returns 0 when out of stock.
int? maxPurchasableQuantity(double? stockQuantity) {
  if (!isStockTracked(stockQuantity)) return null;
  if (stockQuantity! <= 0) return 0;
  return stockQuantity.floor();
}

bool canIncreaseCartQuantity({
  required double? stockQuantity,
  required int cartQuantity,
}) {
  final maxQty = maxPurchasableQuantity(stockQuantity);
  if (maxQty == null) return true;
  return cartQuantity < maxQty;
}

int clampCartQuantity({
  required double? stockQuantity,
  required int requestedQty,
}) {
  if (requestedQty <= 0) return 0;
  final maxQty = maxPurchasableQuantity(stockQuantity);
  if (maxQty == null) return requestedQty;
  if (maxQty <= 0) return 0;
  return requestedQty > maxQty ? maxQty : requestedQty;
}
