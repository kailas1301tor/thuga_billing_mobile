// lib/src/home/model/home_dashboard_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';
import 'package:thuga/src/bills/model/bill_model.dart';
import 'home_top_product_model.dart';

class HomeDashboardModel {
  const HomeDashboardModel({
    required this.shopName,
    required this.notificationCount,
    required this.todaySales,
    required this.salesChangePercent,
    required this.billCount,
    required this.billCountDelta,
    required this.avgBillValue,
    required this.avgBillChangePercent,
    required this.bestSellerName,
    required this.bestSellerQty,
    required this.topProducts,
    required this.recentBills,
  });

  final String shopName;
  final int notificationCount;
  final double todaySales;
  final double salesChangePercent;
  final int billCount;
  final int billCountDelta;
  final double avgBillValue;
  final double avgBillChangePercent;
  final String bestSellerName;
  final int bestSellerQty;
  final List<HomeTopProductModel> topProducts;
  final List<BillModel> recentBills;

  factory HomeDashboardModel.fromJson(
    Map<String, dynamic> json, {
    required String shopName,
    required List<HomeTopProductModel> topProducts,
    required List<BillModel> recentBills,
  }) {
    final todaySalesJson = convertToMap(json['today_sales']);
    final todayBillsJson = convertToMap(json['today_bills']);
    final todayAvgBillJson = convertToMap(json['today_avg_bill']);
    final bestSellerJson = convertToMap(json['best_seller']);

    return HomeDashboardModel(
      shopName: shopName,
      notificationCount: 1,
      todaySales: convertToDouble(todaySalesJson['value']),
      salesChangePercent: convertToDouble(todaySalesJson['growth_percent']),
      billCount: convertToInt(todayBillsJson['count']),
      billCountDelta: convertToInt(todayBillsJson['growth_count']),
      avgBillValue: convertToDouble(todayAvgBillJson['value']),
      avgBillChangePercent: convertToDouble(todayAvgBillJson['growth_percent']),
      bestSellerName: convertToString(bestSellerJson['name']),
      bestSellerQty: convertToInt(bestSellerJson['qty_sold']),
      topProducts: topProducts,
      recentBills: recentBills,
    );
  }
}
