// lib/src/bills/model/bill_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class BillModel {
  const BillModel({
    required this.billNumber,
    required this.timeLabel,
    required this.customerLabel,
    required this.itemsCount,
    required this.amount,
    required this.isPaid,
    required this.paymentMethod,
    required this.date,
  });

  final String billNumber;
  final String timeLabel;
  final String customerLabel;
  final int itemsCount;
  final double amount;
  final bool isPaid;
  final String paymentMethod;
  final DateTime date;

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      billNumber: convertToString(json['billNumber']),
      timeLabel: convertToString(json['timeLabel']),
      customerLabel: convertToString(json['customerLabel']),
      itemsCount: convertToInt(json['itemsCount']),
      amount: convertToDouble(json['amount']),
      isPaid: convertToBool(json['isPaid']),
      paymentMethod: convertToString(json['paymentMethod']),
      date: DateTime.tryParse(convertToString(json['date'])) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'billNumber': billNumber,
        'timeLabel': timeLabel,
        'customerLabel': customerLabel,
        'itemsCount': itemsCount,
        'amount': amount,
        'isPaid': isPaid,
        'paymentMethod': paymentMethod,
        'date': date.toIso8601String(),
      };
}

class BillsSummaryModel {
  const BillsSummaryModel({
    required this.totalBills,
    required this.totalSales,
    required this.avgBillValue,
    required this.pendingBills,
  });

  final int totalBills;
  final double totalSales;
  final double avgBillValue;
  final int pendingBills;

  factory BillsSummaryModel.fromJson(Map<String, dynamic> json) {
    return BillsSummaryModel(
      totalBills: convertToInt(json['totalBills']),
      totalSales: convertToDouble(json['totalSales']),
      avgBillValue: convertToDouble(json['avgBillValue']),
      pendingBills: convertToInt(json['pendingBills']),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalBills': totalBills,
        'totalSales': totalSales,
        'avgBillValue': avgBillValue,
        'pendingBills': pendingBills,
      };
}

class BillsResponseModel {
  const BillsResponseModel({
    required this.summary,
    required this.bills,
  });

  final BillsSummaryModel summary;
  final List<BillModel> bills;

  factory BillsResponseModel.fromJson(Map<String, dynamic> json) {
    return BillsResponseModel(
      summary: BillsSummaryModel.fromJson(convertToMap(json['summary'])),
      bills: convertToList(json['bills'])
          .map((e) => BillModel.fromJson(convertToMap(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'summary': summary.toJson(),
        'bills': bills.map((b) => b.toJson()).toList(),
      };
}
