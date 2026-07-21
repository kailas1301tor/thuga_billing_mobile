import 'package:flutter_test/flutter_test.dart';
import 'package:vyapapp/utils/helpers/amount_formatter.dart';

void main() {
  group('formatDisplayCurrency', () {
    test('strips trailing zeros for whole numbers', () {
      expect(formatDisplayCurrency(102), '₹102');
      expect(formatDisplayCurrency(102.0), '₹102');
    });

    test('keeps meaningful decimal digits', () {
      expect(formatDisplayCurrency(105.2), '₹105.2');
      expect(formatDisplayCurrency(105.20), '₹105.2');
      expect(formatDisplayCurrency(576.19), '₹576.19');
      expect(formatDisplayCurrency(7490.5), '₹7,490.5');
    });

    test('applies Indian grouping', () {
      expect(formatDisplayCurrency(5270), '₹5,270');
    });
  });

  group('formatDisplayPercent', () {
    test('strips trailing zeros', () {
      expect(formatDisplayPercent(0), '0%');
      expect(formatDisplayPercent(5), '5%');
      expect(formatDisplayPercent(5.2), '5.2%');
    });
  });
}
