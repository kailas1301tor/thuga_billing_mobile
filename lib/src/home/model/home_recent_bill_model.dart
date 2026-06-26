// lib/src/home/model/home_recent_bill_model.dart
import 'package:vyapapp/utils/helpers/safe_converters.dart';

class HomeRecentBillModel {
  const HomeRecentBillModel({
    required this.billNumber,
    required this.timeLabel,
    required this.customerLabel,
    required this.amount,
    required this.isPaid,
    required this.paymentMethod,
    required this.paymentStatus,
    this.customerId,
  });

  final String billNumber;
  final String timeLabel;
  final String customerLabel;
  final double amount;
  final bool isPaid;
  final String paymentMethod;
  final String paymentStatus;
  final int? customerId;

  factory HomeRecentBillModel.fromJson(Map<String, dynamic> json, String customerName) {
    return HomeRecentBillModel(
      billNumber: convertToString(json['order_number']),
      timeLabel: convertToString(json['date']),
      customerLabel: customerName,
      amount: convertToDouble(json['total_amount']),
      isPaid: convertToString(json['payment_status']).toLowerCase() == 'completed' ||
          convertToString(json['payment_status']).toLowerCase() == 'success' ||
          convertToString(json['payment_status']).toLowerCase() == 'completed_paid' ||
          convertToBool(json['is_paid']),
      paymentMethod: convertToString(json['payment_method']),
      paymentStatus: convertToString(json['payment_status']),
      customerId: json['customer'] != null ? convertToInt(json['customer']) : null,
    );
  }
}
