// lib/src/main/model/dropdown_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';
import 'package:thuga/utils/helpers/unit_conversion_helper.dart';

class DropdownItemModel {
  final String id;
  final String name;

  const DropdownItemModel({required this.id, required this.name});

  factory DropdownItemModel.fromJson(Map<String, dynamic> json) =>
      DropdownItemModel(
        id: convertToString(json['id']),
        name: convertToString(json['name']),
      );
}

class DropdownUnitItemModel {
  final String id;
  final String name;

  const DropdownUnitItemModel({required this.id, required this.name});

  factory DropdownUnitItemModel.fromJson(Map<String, dynamic> json) =>
      DropdownUnitItemModel(
        id: convertToString(json['id']),
        name: convertToString(json['name']),
      );
}

class DropdownUnitCategoryModel {
  final String category;
  final List<DropdownUnitItemModel> items;

  const DropdownUnitCategoryModel({
    required this.category,
    required this.items,
  });

  factory DropdownUnitCategoryModel.fromJson(Map<String, dynamic> json) =>
      DropdownUnitCategoryModel(
        category: convertToString(json['category']),
        items: convertToList(json['items'])
            .map((e) => DropdownUnitItemModel.fromJson(convertToMap(e)))
            .toList(),
      );
}

class DropdownProductModel {
  final int id;
  final String name;

  const DropdownProductModel({
    required this.id,
    required this.name,
  });

  factory DropdownProductModel.fromJson(Map<String, dynamic> json) =>
      DropdownProductModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
      );
}

class DropdownCustomerModel {
  final int id;
  final String name;

  const DropdownCustomerModel({
    required this.id,
    required this.name,
  });

  factory DropdownCustomerModel.fromJson(Map<String, dynamic> json) =>
      DropdownCustomerModel(
        id: convertToInt(json['id']),
        name: convertToString(json['name']),
      );
}

class DropdownsDataModel {
  final List<DropdownProductModel> products;
  final List<DropdownCustomerModel> customers;
  final List<DropdownItemModel> paymentMethods;
  final List<DropdownItemModel> paymentStatuses;
  final List<DropdownItemModel> discountTypes;
  final List<DropdownUnitCategoryModel> units;

  const DropdownsDataModel({
    this.products = const [],
    this.customers = const [],
    this.paymentMethods = const [],
    this.paymentStatuses = const [],
    this.discountTypes = const [],
    this.units = const [],
  });

  factory DropdownsDataModel.fromJson(Map<String, dynamic> json) {
    return DropdownsDataModel(
      products: convertToList(json['products'])
          .map((e) => DropdownProductModel.fromJson(convertToMap(e)))
          .toList(),
      customers: convertToList(json['customers'])
          .map((e) => DropdownCustomerModel.fromJson(convertToMap(e)))
          .toList(),
      paymentMethods: convertToList(json['payment_methods'])
          .map((e) => DropdownItemModel.fromJson(convertToMap(e)))
          .toList(),
      paymentStatuses: convertToList(json['payment_statuses'])
          .map((e) => DropdownItemModel.fromJson(convertToMap(e)))
          .toList(),
      discountTypes: convertToList(json['discount_types'])
          .map((e) => DropdownItemModel.fromJson(convertToMap(e)))
          .toList(),
      units: convertToList(json['units'])
          .map((e) => DropdownUnitCategoryModel.fromJson(convertToMap(e)))
          .toList(),
    );
  }

  List<DropdownUnitItemModel> get allUnits =>
      units.expand((category) => category.items).toList();

  /// Base units only — used when adding a product.
  List<DropdownUnitItemModel> get selectableProductUnits => allUnits
      .where((item) => isProductSelectableUnit(item.id))
      .toList(growable: false);

  String? categoryForUnit(String? unitId) => unitCategoryFor(unitId);

  List<DropdownUnitItemModel> unitsInSameCategory(String? unitId) {
    final category = categoryForUnit(unitId);
    if (category == null) return const [];
    for (final group in units) {
      if (group.category == category) return group.items;
    }
    return const [];
  }

  String displayNameForUnit(String? unitId) {
    if (unitId == null || unitId.isEmpty) return '';
    for (final item in allUnits) {
      if (item.id == unitId) return item.name;
    }
    return unitId;
  }

  DropdownUnitItemModel? unitById(String? unitId) {
    if (unitId == null || unitId.isEmpty) return null;
    for (final item in allUnits) {
      if (item.id == unitId) return item;
    }
    return null;
  }
}
