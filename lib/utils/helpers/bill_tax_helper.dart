// lib/utils/helpers/bill_tax_helper.dart
import 'package:thuga/src/new_bill/model/new_bill_model.dart';

class BillTotals {
  const BillTotals({
    required this.subtotal,
    required this.sgstTotal,
    required this.cgstTotal,
    required this.billDiscount,
    required this.grandTotal,
  });

  /// Sum of line totals after item-level discounts (taxable base).
  final double subtotal;
  final double sgstTotal;
  final double cgstTotal;
  final double billDiscount;
  final double grandTotal;
}

double computeLineSgstAmount(CartItemModel item) =>
    item.totalPrice * item.sgst / 100;

double computeLineCgstAmount(CartItemModel item) =>
    item.totalPrice * item.cgst / 100;

BillTotals computeBillTotals(List<CartItemModel> cart, double billDiscount) {
  var subtotal = 0.0;
  var sgstTotal = 0.0;
  var cgstTotal = 0.0;

  for (final item in cart) {
    subtotal += item.totalPrice;
    sgstTotal += computeLineSgstAmount(item);
    cgstTotal += computeLineCgstAmount(item);
  }

  final discountedSubtotal = (subtotal - billDiscount).clamp(0.0, double.infinity);
  final grandTotal =
      (discountedSubtotal + sgstTotal + cgstTotal).clamp(0.0, double.infinity);

  return BillTotals(
    subtotal: subtotal,
    sgstTotal: sgstTotal,
    cgstTotal: cgstTotal,
    billDiscount: billDiscount,
    grandTotal: grandTotal,
  );
}

String resolvePaymentStatus(double grandTotal, double balance) {
  if (balance <= 0) return 'Paid';
  if (balance >= grandTotal) return 'Credit';
  return 'Partially Paid';
}
