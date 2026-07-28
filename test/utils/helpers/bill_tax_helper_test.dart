import 'package:flutter_test/flutter_test.dart';
import 'package:thuga/src/new_bill/model/new_bill_model.dart';
import 'package:thuga/utils/helpers/bill_tax_helper.dart';

CartItemModel _item({
  required double price,
  int quantity = 1,
  double sgst = 0,
  double cgst = 0,
}) {
  return CartItemModel(
    productId: 1,
    name: 'Test',
    price: price,
    quantity: quantity,
    emoji: '📦',
    sgst: sgst,
    cgst: cgst,
  );
}

void main() {
  group('computeBillTotals', () {
    test('milk example: 40 + 6% SGST + 6% CGST = 44.80', () {
      final totals = computeBillTotals([
        _item(price: 40, sgst: 6, cgst: 6),
      ], 0);

      expect(totals.subtotal, 40);
      expect(totals.sgstTotal, closeTo(2.4, 0.001));
      expect(totals.cgstTotal, closeTo(2.4, 0.001));
      expect(totals.grandTotal, closeTo(44.8, 0.001));
    });

    test('mixed cart sums tax per line', () {
      final totals = computeBillTotals([
        _item(price: 40, sgst: 6, cgst: 6),
        _item(price: 25, sgst: 0, cgst: 0),
      ], 0);

      expect(totals.subtotal, 65);
      expect(totals.sgstTotal, closeTo(2.4, 0.001));
      expect(totals.cgstTotal, closeTo(2.4, 0.001));
      expect(totals.grandTotal, closeTo(69.8, 0.001));
    });

    test('bill discount reduces taxable subtotal before tax is added', () {
      final totals = computeBillTotals([
        _item(price: 40, sgst: 6, cgst: 6),
      ], 10);

      expect(totals.subtotal, 40);
      expect(totals.grandTotal, closeTo(34.8, 0.001));
    });
  });

  group('resolvePaymentStatus', () {
    test('maps balance to API payment status', () {
      expect(resolvePaymentStatus(100, 0), 'Paid');
      expect(resolvePaymentStatus(100, 100), 'Credit');
      expect(resolvePaymentStatus(100, 40), 'Partially Paid');
    });
  });
}
