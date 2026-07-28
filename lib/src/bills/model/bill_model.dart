// lib/src/bills/model/bill_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

class BillModel {
  const BillModel({
    required this.id,
    this.customerId,
    required this.orderNumber,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.totalAmount,
    required this.discountAmount,
    required this.balance,
    required this.dateString,
    required this.createdAt,
    this.paidDate,
    this.customerName,
    this.customerPhone,
  });

  final int id;
  final int? customerId;
  final String orderNumber;
  final String paymentMethod;
  final String paymentStatus;
  final double totalAmount;
  final double discountAmount;
  final double balance;
  final String dateString;
  final DateTime createdAt;
  final String? paidDate;
  final String? customerName;
  final String? customerPhone;

  factory BillModel.fromJson(Map<String, dynamic> json) {
    final customerDetails = json['customer_details'] != null
        ? convertToMap(json['customer_details'])
        : null;

    return BillModel(
      id: convertToInt(json['id']),
      customerId: json['customer'] == null
          ? null
          : convertToInt(json['customer']),
      orderNumber: convertToString(json['order_number']),
      paymentMethod: convertToString(json['payment_method']),
      paymentStatus: convertToString(json['payment_status']),
      totalAmount: convertToDouble(json['total_amount']),
      discountAmount: convertToDouble(json['discount_amount']),
      balance: convertToDouble(json['balance']),
      dateString: convertToString(json['date']),
      paidDate: json['paid_date'] == null
          ? null
          : convertToString(json['paid_date']),
      createdAt: DateTime.tryParse(
            convertToString(json['created_at']),
          ) ??
          DateTime.now(),
      customerName: customerDetails != null
          ? convertToString(customerDetails['name'])
          : null,
      customerPhone: customerDetails != null
          ? convertToString(customerDetails['phone_number'])
          : null,
    );
  }

  /// Computed paid amount (total minus outstanding balance).
  double get paidAmount => totalAmount - balance;

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer': customerId,
        'order_number': orderNumber,
        'payment_method': paymentMethod,
        'payment_status': paymentStatus,
        'total_amount': totalAmount.toString(),
        'discount_amount': discountAmount.toString(),
        'balance': balance.toString(),
        'date': dateString,
        if (paidDate != null) 'paid_date': paidDate,
        'created_at': createdAt.toIso8601String(),
      };
}

class BillsResults {
  const BillsResults({
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.itemPerPage,
    required this.data,
  });

  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int itemPerPage;
  final List<BillModel> data;

  factory BillsResults.fromJson(Map<String, dynamic> json) {
    return BillsResults(
      totalCount: convertToInt(json['total_count']),
      totalPages: convertToInt(json['total_pages']),
      currentPage: convertToInt(json['current_page']),
      itemPerPage: convertToInt(json['item_per_page']),
      data: convertToList(json['data'])
          .map((e) => BillModel.fromJson(convertToMap(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_count': totalCount,
        'total_pages': totalPages,
        'current_page': currentPage,
        'item_per_page': itemPerPage,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class BillsResponseModel {
  const BillsResponseModel({
    required this.message,
    required this.results,
  });

  final String message;
  final BillsResults results;

  factory BillsResponseModel.fromJson(Map<String, dynamic> json) {
    return BillsResponseModel(
      message: convertToString(json['message']),
      results: BillsResults.fromJson(convertToMap(json['results'])),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'results': results.toJson(),
      };
}
