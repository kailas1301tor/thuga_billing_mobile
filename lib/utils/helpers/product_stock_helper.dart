// lib/utils/helpers/product_stock_helper.dart
import 'package:thuga/utils/helpers/unit_conversion_helper.dart';

bool isStockTracked(double? stockQuantity) => stockQuantity != null;

bool isOutOfStock(double? stockQuantity) =>
    isStockTracked(stockQuantity) && stockQuantity! <= 0;

/// Returns null when stock is not tracked (unlimited).
/// Returns 0 when out of stock.
double? maxPurchasableQuantity(double? stockQuantity) {
  if (!isStockTracked(stockQuantity)) return null;
  if (stockQuantity! <= 0) return 0;
  return stockQuantity;
}

bool canIncreaseCartQuantity({
  required double? stockQuantity,
  required double cartQuantityInProductUnit,
  double incrementInProductUnit = 1,
}) {
  final maxQty = maxPurchasableQuantity(stockQuantity);
  if (maxQty == null) return true;
  return cartQuantityInProductUnit + incrementInProductUnit <= maxQty + 1e-9;
}

double clampCartQuantityInProductUnit({
  required double? stockQuantity,
  required double requestedQtyInProductUnit,
}) {
  if (requestedQtyInProductUnit <= 0) return 0;
  final maxQty = maxPurchasableQuantity(stockQuantity);
  if (maxQty == null) return requestedQtyInProductUnit;
  if (maxQty <= 0) return 0;
  return requestedQtyInProductUnit > maxQty ? maxQty : requestedQtyInProductUnit;
}

double clampBillingQuantity({
  required double? stockQuantity,
  required double requestedBillingQty,
  required String billingUnit,
  required String productUnit,
}) {
  if (requestedBillingQty <= 0) return 0;

  final requestedInProductUnit = effectiveQuantityInProductUnit(
    quantity: requestedBillingQty,
    billingUnit: billingUnit,
    productUnit: productUnit,
  );

  final cappedInProductUnit = clampCartQuantityInProductUnit(
    stockQuantity: stockQuantity,
    requestedQtyInProductUnit: requestedInProductUnit,
  );

  if (cappedInProductUnit <= 0) return 0;
  if (billingUnit == productUnit) return cappedInProductUnit;

  final convertedBack = convertQuantity(
    qty: cappedInProductUnit,
    fromUnit: productUnit,
    toUnit: billingUnit,
  );

  return convertedBack ?? requestedBillingQty;
}

double incrementStepForUnit(String? unitId) {
  final unit = resolveProductUnit(unitId);
  return switch (unit) {
    'kg' || 'litre' => 1,
    'gram' || 'millilitre' => 100,
    'milligram' => 100,
    _ => 1,
  };
}
