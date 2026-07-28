// lib/src/home/model/home_top_product_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

enum HomeProductIconType { tea, coffee, samosa }

class HomeTopProductModel {
  const HomeTopProductModel({
    required this.name,
    required this.quantity,
    required this.unitLabel,
    required this.amount,
    required this.salesPercent,
    required this.iconType,
    required this.progressColor,
    this.imageUrl,
  });

  final String name;
  final int quantity;
  final String unitLabel;
  final double amount;
  final double salesPercent;
  final HomeProductIconType iconType;
  final int progressColor;
  final String? imageUrl;

  factory HomeTopProductModel.fromJson(Map<String, dynamic> json, int index) {
    final name = convertToString(json['name']);
    final lowerName = name.toLowerCase();

    HomeProductIconType icon = HomeProductIconType.samosa;
    if (lowerName.contains('tea') || lowerName.contains('chai')) {
      icon = HomeProductIconType.tea;
    } else if (lowerName.contains('coffee') || lowerName.contains('cafe')) {
      icon = HomeProductIconType.coffee;
    }

    const colors = [0xFF05B064, 0xFFF97316, 0xFFEAB308, 0xFF8B5CF6, 0xFFEC4899];
    final progressColor = colors[index % colors.length];

    return HomeTopProductModel(
      name: name,
      quantity: convertToInt(json['qty_sold']),
      unitLabel: 'sold',
      amount: convertToDouble(json['total_value']),
      salesPercent: convertToDouble(json['percentage_of_sales']),
      iconType: icon,
      progressColor: progressColor,
      imageUrl: json['image'] != null ? convertToString(json['image']) : null,
    );
  }
}
