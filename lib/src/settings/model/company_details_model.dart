// lib/src/settings/model/company_details_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class CompanyDetailsModel {
  final int id;
  final String companyName;
  final String status;
  final String address;
  final String phoneNumber;
  final bool isActive;
  final String email;

  CompanyDetailsModel({
    required this.id,
    required this.companyName,
    required this.status,
    required this.address,
    required this.phoneNumber,
    required this.isActive,
    required this.email,
  });

  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    final userMap = convertToMap(json['user']);
    return CompanyDetailsModel(
      id: convertToInt(json['id']),
      companyName: convertToString(json['company_name']),
      status: convertToString(json['status']),
      address: convertToString(json['address']),
      phoneNumber: convertToString(json['phone_number']),
      isActive: convertToBool(json['is_active']),
      email: convertToString(userMap['email']),
    );
  }
}
