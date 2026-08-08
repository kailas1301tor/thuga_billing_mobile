// lib/utils/helpers/unit_conversion_helper.dart

const String defaultLegacyUnitId = 'piece';

const String unitCategoryWeight = 'Weight';
const String unitCategoryVolume = 'Volume';
const String unitCategoryQuantity = 'Quantity';

const Map<String, String> _unitToCategory = {
  'kg': unitCategoryWeight,
  'gram': unitCategoryWeight,
  'milligram': unitCategoryWeight,
  'litre': unitCategoryVolume,
  'millilitre': unitCategoryVolume,
  'piece': unitCategoryQuantity,
  'dozen': unitCategoryQuantity,
  'box': unitCategoryQuantity,
  'packet': unitCategoryQuantity,
};

/// Factor to convert one unit into the category base (kg or litre).
const Map<String, double> _unitToBaseFactor = {
  'kg': 1,
  'gram': 0.001,
  'milligram': 0.000001,
  'litre': 1,
  'millilitre': 0.001,
  'piece': 1,
  'dozen': 1,
  'box': 1,
  'packet': 1,
};

/// Units allowed when creating/editing a product (base units only).
const Set<String> productSelectableUnitIds = {
  'kg',
  'litre',
  'piece',
  'dozen',
  'box',
  'packet',
};

bool isProductSelectableUnit(String? unitId) {
  if (unitId == null || unitId.isEmpty) return false;
  return productSelectableUnitIds.contains(unitId);
}

/// Short labels for billing/cart display. API payloads still use unit ids.
const Map<String, String> _unitDisplayLabels = {
  'kg': 'kg',
  'gram': 'g',
  'milligram': 'mg',
  'litre': 'L',
  'millilitre': 'ml',
};

String displayUnitLabel(String? unitId) {
  if (unitId == null || unitId.isEmpty) return '';
  return _unitDisplayLabels[unitId] ?? unitId;
}

String resolveProductUnit(String? unit) {
  final trimmed = unit?.trim();
  if (trimmed == null || trimmed.isEmpty) return defaultLegacyUnitId;
  return trimmed;
}

String? unitCategoryFor(String? unitId) {
  if (unitId == null || unitId.isEmpty) return null;
  return _unitToCategory[unitId];
}

bool allowsBillingUnitSwitch(String? unitId) {
  final category = unitCategoryFor(unitId);
  return category == unitCategoryWeight || category == unitCategoryVolume;
}

bool allowsDecimalQuantity(String? unitId) {
  return allowsBillingUnitSwitch(unitId);
}

double? convertQuantity({
  required double qty,
  required String fromUnit,
  required String toUnit,
}) {
  if (fromUnit == toUnit) return qty;

  final fromCategory = unitCategoryFor(fromUnit);
  final toCategory = unitCategoryFor(toUnit);
  if (fromCategory == null ||
      toCategory == null ||
      fromCategory != toCategory ||
      fromCategory == unitCategoryQuantity) {
    return null;
  }

  final fromFactor = _unitToBaseFactor[fromUnit];
  final toFactor = _unitToBaseFactor[toUnit];
  if (fromFactor == null || toFactor == null || toFactor == 0) return null;

  return qty * fromFactor / toFactor;
}

double effectiveQuantityInProductUnit({
  required double quantity,
  required String billingUnit,
  required String productUnit,
}) {
  if (billingUnit == productUnit) return quantity;
  return convertQuantity(
        qty: quantity,
        fromUnit: billingUnit,
        toUnit: productUnit,
      ) ??
      quantity;
}

String formatQuantityDisplay(double qty) {
  if (qty == qty.truncateToDouble()) {
    return qty.toInt().toString();
  }
  final formatted = qty.toStringAsFixed(3);
  return formatted
      .replaceAll(RegExp(r'0+$'), '')
      .replaceAll(RegExp(r'\.$'), '');
}

String formatQuantityWithUnit({
  required double quantity,
  required String? unitId,
  String Function(String unitId)? unitLabel,
}) {
  final qtyText = formatQuantityDisplay(quantity);
  if (unitId == null || unitId.isEmpty) return qtyText;
  final label = unitLabel?.call(unitId) ?? displayUnitLabel(unitId);
  return '$qtyText $label';
}
