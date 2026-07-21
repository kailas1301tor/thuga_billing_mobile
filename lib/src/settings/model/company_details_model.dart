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
  final String? startWorkingHour;
  final String? endWorkingHour;

  CompanyDetailsModel({
    required this.id,
    required this.companyName,
    required this.status,
    required this.address,
    required this.phoneNumber,
    required this.isActive,
    required this.email,
    this.startWorkingHour,
    this.endWorkingHour,
  });

  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    final userMap = convertToMap(json['user']);
    final startRaw = json['start_working_hour'];
    final endRaw = json['end_working_hour'];
    return CompanyDetailsModel(
      id: convertToInt(json['id']),
      companyName: convertToString(json['company_name']),
      status: convertToString(json['status']),
      address: convertToString(json['address']),
      phoneNumber: convertToString(json['phone_number']),
      isActive: convertToBool(json['is_active']),
      email: convertToString(userMap['email']).isNotEmpty
          ? convertToString(userMap['email'])
          : convertToString(json['email']),
      startWorkingHour: startRaw == null ? null : convertToString(startRaw),
      endWorkingHour: endRaw == null ? null : convertToString(endRaw),
    );
  }
}
