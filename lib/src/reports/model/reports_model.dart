// lib/src/reports/model/reports_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class ReportSummaryModel {
  const ReportSummaryModel({
    required this.totalSales,
    required this.totalBills,
    required this.avgBillValue,
    required this.pendingBills,
  });

  final double totalSales;
  final int totalBills;
  final double avgBillValue;
  final int pendingBills;

  factory ReportSummaryModel.fromJson(Map<String, dynamic> json) {
    return ReportSummaryModel(
      totalSales: convertToDouble(json['total_sales'] ?? json['totalSales']),
      totalBills: convertToInt(json['total_bills'] ?? json['totalBills']),
      avgBillValue: convertToDouble(json['average_bill_value'] ?? json['avgBillValue']),
      pendingBills: convertToInt(json['pending_bills'] ?? json['pendingBills']),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalSales': totalSales,
        'totalBills': totalBills,
        'avgBillValue': avgBillValue,
        'pendingBills': pendingBills,
      };
}

class PaymentShareModel {
  const PaymentShareModel({
    required this.paymentMethod,
    required this.amount,
    required this.percentage,
  });

  final String paymentMethod;
  final double amount;
  final double percentage;

  factory PaymentShareModel.fromJson(Map<String, dynamic> json) {
    return PaymentShareModel(
      paymentMethod: convertToString(json['paymentMethod'] ?? json['method']),
      amount: convertToDouble(json['amount']),
      percentage: convertToDouble(json['percentage']),
    );
  }

  Map<String, dynamic> toJson() => {
        'paymentMethod': paymentMethod,
        'amount': amount,
        'percentage': percentage,
      };
}

class ProductSaleModel {
  const ProductSaleModel({
    required this.name,
    required this.emoji,
    required this.quantity,
    required this.revenue,
    this.image,
  });

  final String name;
  final String emoji;
  final int quantity;
  final double revenue;
  final String? image;

  factory ProductSaleModel.fromJson(Map<String, dynamic> json) {
    return ProductSaleModel(
      name: convertToString(json['name']),
      emoji: convertToString(json['emoji'] ?? '📦'),
      quantity: convertToInt(json['qty_sold'] ?? json['quantity']),
      revenue: convertToDouble(json['total_value'] ?? json['revenue']),
      image: json['image'] != null ? convertToString(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'emoji': emoji,
        'quantity': quantity,
        'revenue': revenue,
        'image': image,
      };
}

class ChartDataPoint {
  const ChartDataPoint({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(
      label: convertToString(json['label']),
      value: convertToDouble(json['total'] ?? json['value']),
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
      };
}

class ReportsDataModel {
  const ReportsDataModel({
    required this.summary,
    required this.paymentShares,
    required this.topProducts,
    required this.chartData,
  });

  final ReportSummaryModel summary;
  final List<PaymentShareModel> paymentShares;
  final List<ProductSaleModel> topProducts;
  final List<ChartDataPoint> chartData;

  factory ReportsDataModel.fromJson(Map<String, dynamic> json) {
    return ReportsDataModel(
      summary: ReportSummaryModel.fromJson(json),
      paymentShares: convertToList(json['payment_mode_share'] ?? json['paymentShares'])
          .map((e) => PaymentShareModel.fromJson(convertToMap(e)))
          .toList(),
      topProducts: convertToList(json['top_selling_products'] ?? json['topProducts'])
          .map((e) => ProductSaleModel.fromJson(convertToMap(e)))
          .toList(),
      chartData: convertToList(json['sales_analytics'] ?? json['chartData'])
          .map((e) => ChartDataPoint.fromJson(convertToMap(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'summary': summary.toJson(),
        'paymentShares': paymentShares.map((e) => e.toJson()).toList(),
        'topProducts': topProducts.map((e) => e.toJson()).toList(),
        'chartData': chartData.map((e) => e.toJson()).toList(),
      };
}
