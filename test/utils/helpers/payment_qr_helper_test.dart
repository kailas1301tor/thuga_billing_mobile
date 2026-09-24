import 'package:flutter_test/flutter_test.dart';
import 'package:thuga/utils/helpers/payment_qr_helper.dart';

void main() {
  group('isAllowedPaymentQrExtension', () {
    test('allows jpg jpeg png case-insensitive', () {
      expect(isAllowedPaymentQrExtension('/a/b.JPG'), isTrue);
      expect(isAllowedPaymentQrExtension('/a/b.jpeg'), isTrue);
      expect(isAllowedPaymentQrExtension('/a/b.png'), isTrue);
    });

    test('rejects heic webp and missing extension', () {
      expect(isAllowedPaymentQrExtension('/a/b.heic'), isFalse);
      expect(isAllowedPaymentQrExtension('/a/b.webp'), isFalse);
      expect(isAllowedPaymentQrExtension('/a/b'), isFalse);
    });
  });

  group('normalizeQrCodeUrl', () {
    test('null and blank become null', () {
      expect(normalizeQrCodeUrl(null), isNull);
      expect(normalizeQrCodeUrl(''), isNull);
      expect(normalizeQrCodeUrl('   '), isNull);
    });

    test('trims non-empty url', () {
      expect(
        normalizeQrCodeUrl(' https://cdn.example/qr.png '),
        'https://cdn.example/qr.png',
      );
    });
  });
}
