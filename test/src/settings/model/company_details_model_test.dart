import 'package:flutter_test/flutter_test.dart';
import 'package:thuga/src/settings/model/company_details_model.dart';

void main() {
  test('parses qr_code url', () {
    final m = CompanyDetailsModel.fromJson({
      'id': 1,
      'company_name': 'Shop',
      'status': 'Active',
      'address': 'a',
      'phone_number': '1',
      'is_active': true,
      'email': 'a@b.com',
      'qr_code': 'https://cdn.example/qr.png',
    });
    expect(m.qrCode, 'https://cdn.example/qr.png');
  });

  test('null and empty qr_code become null', () {
    expect(
      CompanyDetailsModel.fromJson({
        'id': 1,
        'company_name': 'Shop',
        'status': 'Active',
        'address': 'a',
        'phone_number': '1',
        'is_active': true,
        'email': 'a@b.com',
      }).qrCode,
      isNull,
    );
    expect(
      CompanyDetailsModel.fromJson({
        'id': 1,
        'company_name': 'Shop',
        'status': 'Active',
        'address': 'a',
        'phone_number': '1',
        'is_active': true,
        'email': 'a@b.com',
        'qr_code': '',
      }).qrCode,
      isNull,
    );
  });
}
