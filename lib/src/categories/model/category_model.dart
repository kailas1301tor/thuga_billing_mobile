// lib/src/categories/model/category_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

/// GET /api/categories
class CategoryResponse {
  final String message;
  final CategoryResults results;

  const CategoryResponse({required this.message, required this.results});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        message: convertToString(json['message']),
        results: CategoryResults.fromJson(convertToMap(json['results'])),
      );
}

class CategoryResults {
  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int itemPerPage;
  final List<CategoryModel> data;

  const CategoryResults({
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.itemPerPage,
    required this.data,
  });

  factory CategoryResults.fromJson(Map<String, dynamic> json) => CategoryResults(
        totalCount: convertToInt(json['total_count']),
        totalPages: convertToInt(json['total_pages']),
        currentPage: convertToInt(json['current_page']),
        itemPerPage: convertToInt(json['item_per_page']),
        data: convertToList(json['data'])
            .map((x) => CategoryModel.fromJson(convertToMap(x)))
            .toList(),
      );
}

/// POST /api/categories, PUT /api/categories?id=`id`
class CategoryAddResponse {
  final String message;
  final CategoryAddResults results;

  const CategoryAddResponse({required this.message, required this.results});

  factory CategoryAddResponse.fromJson(Map<String, dynamic> json) => CategoryAddResponse(
        message: convertToString(json['message']),
        results: CategoryAddResults.fromJson(convertToMap(json['results'])),
      );
}

class CategoryAddResults {
  final CategoryModel data;

  const CategoryAddResults({required this.data});

  factory CategoryAddResults.fromJson(Map<String, dynamic> json) => CategoryAddResults(
        data: CategoryModel.fromJson(convertToMap(json['data'])),
      );
}

/// DELETE /api/categories?id=`id`
class CategoryDeleteResponse {
  final String message;

  const CategoryDeleteResponse({required this.message});

  factory CategoryDeleteResponse.fromJson(Map<String, dynamic> json) => CategoryDeleteResponse(
        message: convertToString(json['message']),
      );
}

class CategoryModel {
  final int id;
  final String name;
  final bool isActive;
  final bool deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    this.isActive = true,
    this.deleted = false,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
        isActive: convertToBool(json['is_active']),
        deleted: convertToBool(json['deleted']),
        createdAt: json['created_at'] != null ? DateTime.tryParse(convertToString(json['created_at'])) : null,
        updatedAt: json['updated_at'] != null ? DateTime.tryParse(convertToString(json['updated_at'])) : null,
      );
}
