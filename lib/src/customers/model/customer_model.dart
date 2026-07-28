// lib/src/customers/model/customer_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

/// GET /api/customers
class CustomerResponse {
  final String message;
  final CustomerResults results;

  const CustomerResponse({required this.message, required this.results});

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => CustomerResponse(
        message: convertToString(json['message']),
        results: CustomerResults.fromJson(convertToMap(json['results'])),
      );
}

class CustomerResults {
  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int itemPerPage;
  final List<CustomerModel> data;

  const CustomerResults({
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.itemPerPage,
    required this.data,
  });

  factory CustomerResults.fromJson(Map<String, dynamic> json) => CustomerResults(
        totalCount: convertToInt(json['total_count']),
        totalPages: convertToInt(json['total_pages']),
        currentPage: convertToInt(json['current_page']),
        itemPerPage: convertToInt(json['item_per_page']),
        data: convertToList(json['data'])
            .map((x) => CustomerModel.fromJson(convertToMap(x)))
            .toList(),
      );
}

/// POST /api/customers, PUT /api/customers?id=`id`
class CustomerAddResponse {
  final String message;
  final CustomerAddResults results;

  const CustomerAddResponse({required this.message, required this.results});

  factory CustomerAddResponse.fromJson(Map<String, dynamic> json) => CustomerAddResponse(
        message: convertToString(json['message']),
        results: CustomerAddResults.fromJson(convertToMap(json['results'])),
      );
}

class CustomerAddResults {
  final CustomerModel data;

  const CustomerAddResults({required this.data});

  factory CustomerAddResults.fromJson(Map<String, dynamic> json) => CustomerAddResults(
        data: CustomerModel.fromJson(convertToMap(json['data'])),
      );
}

/// DELETE /api/customers?id=`id`
class CustomerDeleteResponse {
  final String message;

  const CustomerDeleteResponse({required this.message});

  factory CustomerDeleteResponse.fromJson(Map<String, dynamic> json) => CustomerDeleteResponse(
        message: convertToString(json['message']),
      );
}

class CustomerModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String? email;
  final bool isActive;
  final bool deleted;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.isActive = true,
    this.deleted = false,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
        phoneNumber: convertToString(json['phone_number']),
        email: json['email'] != null ? convertToString(json['email']) : null,
        isActive: convertToBool(json['is_active']),
        deleted: convertToBool(json['deleted']),
        image: json['image'] != null ? convertToString(json['image']) : null,
        createdAt: json['created_at'] != null ? DateTime.tryParse(convertToString(json['created_at'])) : null,
        updatedAt: json['updated_at'] != null ? DateTime.tryParse(convertToString(json['updated_at'])) : null,
      );
}
