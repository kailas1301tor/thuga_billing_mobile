import 'package:flutter_test/flutter_test.dart';
import 'package:thuga/utils/helpers/unit_conversion_helper.dart';

void main() {
  group('isProductSelectableUnit', () {
    test('allows base units for product creation', () {
      expect(isProductSelectableUnit('kg'), isTrue);
      expect(isProductSelectableUnit('litre'), isTrue);
      expect(isProductSelectableUnit('piece'), isTrue);
      expect(isProductSelectableUnit('dozen'), isTrue);
      expect(isProductSelectableUnit('box'), isTrue);
      expect(isProductSelectableUnit('packet'), isTrue);
    });

    test('rejects sub-units for product creation', () {
      expect(isProductSelectableUnit('gram'), isFalse);
      expect(isProductSelectableUnit('milligram'), isFalse);
      expect(isProductSelectableUnit('millilitre'), isFalse);
    });
  });

  group('displayUnitLabel', () {
    test('uses short labels for billing display', () {
      expect(displayUnitLabel('milligram'), 'mg');
      expect(displayUnitLabel('gram'), 'g');
      expect(displayUnitLabel('millilitre'), 'ml');
    });
  });

  group('convertQuantity', () {
    test('converts billing units within weight category', () {
      expect(
        convertQuantity(qty: 1, fromUnit: 'kg', toUnit: 'gram'),
        1000,
      );
      expect(
        convertQuantity(qty: 500, fromUnit: 'gram', toUnit: 'kg'),
        0.5,
      );
    });

    test('converts billing units within volume category', () {
      expect(
        convertQuantity(qty: 2, fromUnit: 'litre', toUnit: 'millilitre'),
        2000,
      );
    });

    test('does not convert across categories', () {
      expect(
        convertQuantity(qty: 1, fromUnit: 'kg', toUnit: 'litre'),
        isNull,
      );
    });
  });

  group('effectiveQuantityInProductUnit', () {
    test('calculates billable quantity in product unit', () {
      expect(
        effectiveQuantityInProductUnit(
          quantity: 500,
          billingUnit: 'gram',
          productUnit: 'kg',
        ),
        0.5,
      );
    });
  });
}
