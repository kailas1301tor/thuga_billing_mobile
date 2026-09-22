import 'package:flutter_test/flutter_test.dart';
import 'package:thuga/utils/helpers/product_stock_helper.dart';

void main() {
  group('incrementStepForUnit', () {
    test('uses whole base units for kg and litre quick tap', () {
      expect(incrementStepForUnit('kg'), 1);
      expect(incrementStepForUnit('litre'), 1);
    });

    test('uses practical sub-unit steps for gram and millilitre billing', () {
      expect(incrementStepForUnit('gram'), 100);
      expect(incrementStepForUnit('millilitre'), 100);
      expect(incrementStepForUnit('milligram'), 100);
    });

    test('uses whole units for quantity-based products', () {
      expect(incrementStepForUnit('piece'), 1);
      expect(incrementStepForUnit('dozen'), 1);
      expect(incrementStepForUnit('box'), 1);
      expect(incrementStepForUnit('packet'), 1);
    });
  });
}
