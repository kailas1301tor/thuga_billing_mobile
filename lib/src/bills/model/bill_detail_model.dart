// lib/src/bills/model/bill_detail_model.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

class BillDetailItemModel {
  const BillDetailItemModel({
    required this.id,
    required this.billId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    this.unit,
    required this.discountType,
    required this.discountValue,
    required this.discountAmount,
    this.bogoBuyQty,
    this.bogoGetQty,
  });

  final int id;
  final int billId;
  final int productId;
  final String productName;
  final double quantity;
  final String? unit;
  final double price;
  final double totalPrice;
  final String discountType;
  final double discountValue;
  final double discountAmount;
  final int? bogoBuyQty;
  final int? bogoGetQty;

  bool get hasDiscount => discountType != 'None' && discountAmount > 0;

  String get discountLabel {
    switch (discountType) {
      case 'Percentage':
        return '${discountValue.toStringAsFixed(discountValue.truncateToDouble() == discountValue ? 0 : 1)}% off';
      case 'Amount':
        return '₹${discountValue.toStringAsFixed(0)} off';
      case 'BOGO':
        return 'Buy $bogoBuyQty Get $bogoGetQty';
      case 'Slab':
        return '₹${discountValue.toStringAsFixed(0)}/unit';
      default:
        return '';
    }
  }

  factory BillDetailItemModel.fromJson(Map<String, dynamic> json) {
    final productDetails = convertToMap(json['product_details']);
    return BillDetailItemModel(
      id: convertToInt(json['id']),
      billId: convertToInt(json['bill']),
      productId: convertToInt(json['product']),
      productName: convertToString(productDetails['name']),
      quantity: convertToDouble(json['qty']),
      unit: json['unit'] != null ? convertToString(json['unit']) : null,
      price: convertToDouble(json['price']),
      totalPrice: convertToDouble(json['total_price']),
      discountType: json['discount_type'] != null
          ? convertToString(json['discount_type'])
          : 'None',
      discountValue: convertToDouble(json['discount_value']),
      discountAmount: convertToDouble(json['discount_amount']),
      bogoBuyQty: json['bogo_buy_qty'] == null
          ? null
          : convertToInt(json['bogo_buy_qty']),
      bogoGetQty: json['bogo_get_qty'] == null
          ? null
          : convertToInt(json['bogo_get_qty']),
    );
  }
}

class BillDetailModel {
  const BillDetailModel({
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
    required this.items,
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
  final List<BillDetailItemModel> items;
  final String? customerName;
  final String? customerPhone;

  factory BillDetailModel.fromJson(Map<String, dynamic> json) {
    final customerDetails = json['customer_details'] != null
        ? convertToMap(json['customer_details'])
        : null;

    return BillDetailModel(
      id: convertToInt(json['id']),
      customerId: json['customer'] == null ? null : convertToInt(json['customer']),
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
      createdAt: DateTime.tryParse(convertToString(json['created_at'])) ?? DateTime.now(),
      items: convertToList(json['items'])
          .map((e) => BillDetailItemModel.fromJson(convertToMap(e)))
          .toList(),
      customerName: customerDetails != null
          ? convertToString(customerDetails['name'])
          : null,
      customerPhone: customerDetails != null
          ? convertToString(customerDetails['phone_number'])
          : null,
    );
  }
}

class BillDetailResponseModel {
  const BillDetailResponseModel({
    required this.message,
    required this.results,
  });

  final String message;
  final BillDetailModel results;

  factory BillDetailResponseModel.fromJson(Map<String, dynamic> json) {
    final resultsMap = convertToMap(json['results']);
    return BillDetailResponseModel(
      message: convertToString(json['message']),
      results: BillDetailModel.fromJson(convertToMap(resultsMap['data'])),
    );
  }
}
