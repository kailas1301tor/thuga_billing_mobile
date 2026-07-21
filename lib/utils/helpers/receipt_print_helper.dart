// lib/utils/helpers/receipt_print_helper.dart
import 'package:flutter_thermal_printer_plus/commands/print_builder.dart';
import 'package:flutter_thermal_printer_plus/models/paper_size.dart';
import 'package:vyapapp/res/constants/string_constants.dart';

class ReceiptPrintLineItem {
  const ReceiptPrintLineItem({
    required this.name,
    required this.unitPriceText,
    required this.quantityText,
    required this.lineTotalText,
    this.discountLabel,
  });

  final String name;
  final String unitPriceText;
  final String quantityText;
  final String lineTotalText;
  final String? discountLabel;
}

class ReceiptPrintData {
  const ReceiptPrintData({
    required this.storeName,
    required this.orderNumber,
    required this.dateString,
    required this.customerName,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.subtotalText,
    required this.grandTotalText,
    required this.balanceText,
    required this.amountPaidText,
    required this.items,
    this.itemDiscountText,
    this.billDiscountText,
    this.sgstTotalText,
    this.cgstTotalText,
    this.customerPhone,
  });

  final String storeName;
  final String orderNumber;
  final String dateString;
  final String customerName;
  final String paymentMethod;
  final String paymentStatus;
  final String subtotalText;
  final String grandTotalText;
  final String balanceText;
  final String amountPaidText;
  final List<ReceiptPrintLineItem> items;
  final String? itemDiscountText;
  final String? billDiscountText;
  final String? sgstTotalText;
  final String? cgstTotalText;
  final String? customerPhone;
}

String normalizeReceiptStoreName(String storeName) {
  final trimmed = storeName.trim();
  final normalized = trimmed.toLowerCase();
  if (trimmed.isEmpty ||
      normalized == 'tortilon bakery' ||
      normalized == 'tortillon') {
    return 'THUKA';
  }
  return trimmed.toUpperCase();
}

String buildReceiptShareText(ReceiptPrintData data) {
  final receiptBuffer = StringBuffer();
  receiptBuffer.writeln('----------------------------------');
  receiptBuffer.writeln(normalizeReceiptStoreName(data.storeName));
  receiptBuffer.writeln('             RECEIPT');
  receiptBuffer.writeln('----------------------------------');
  receiptBuffer.writeln('Invoice No: ${data.orderNumber}');
  receiptBuffer.writeln('Date: ${data.dateString}');
  receiptBuffer.writeln('Customer: ${data.customerName}');
  if (data.customerPhone?.isNotEmpty == true) {
    receiptBuffer.writeln('Phone: ${data.customerPhone}');
  }
  receiptBuffer.writeln(
    'Payment: ${data.paymentMethod} (${data.paymentStatus})',
  );
  receiptBuffer.writeln('----------------------------------');
  for (final item in data.items) {
    receiptBuffer.writeln(
      '${item.name} x${item.quantityText}    ${item.lineTotalText}',
    );
    receiptBuffer.writeln('@ ${item.unitPriceText}');
    if (item.discountLabel?.isNotEmpty == true) {
      receiptBuffer.writeln(item.discountLabel);
    }
  }
  receiptBuffer.writeln('----------------------------------');
  receiptBuffer.writeln('Subtotal:           ${data.subtotalText}');
  if (data.itemDiscountText != null) {
    receiptBuffer.writeln('Item Discounts:     -${data.itemDiscountText}');
  }
  if (data.billDiscountText != null) {
    receiptBuffer.writeln('Bill Discount:      -${data.billDiscountText}');
  }
  if (data.sgstTotalText != null) {
    receiptBuffer.writeln('${Strings.sgstTotal}:        ${data.sgstTotalText}');
  }
  if (data.cgstTotalText != null) {
    receiptBuffer.writeln('${Strings.cgstTotal}:        ${data.cgstTotalText}');
  }
  receiptBuffer.writeln('Grand Total:        ${data.grandTotalText}');
  if (data.balanceText != '₹0') {
    receiptBuffer.writeln('Amount Paid:        ${data.amountPaidText}');
    receiptBuffer.writeln('Remaining Balance:  ${data.balanceText}');
  }
  receiptBuffer.writeln('----------------------------------');
  receiptBuffer.writeln('Thank you for shopping with us!');
  receiptBuffer.writeln('Billed via Thuka App');
  return receiptBuffer.toString();
}

PrintBuilder buildReceiptPrintBuilder(
  ReceiptPrintData data, {
  PaperSize paperSize = PaperSize.mm80,
}) {
  final builder = PrintBuilder(paperSize)
    ..text(
      normalizeReceiptStoreName(data.storeName),
      align: AlignPos.center,
      fontSize: FontSize.big,
      bold: true,
    )
    ..text('RECEIPT', align: AlignPos.center, fontSize: FontSize.compressed)
    ..line()
    ..text('Invoice No: ${data.orderNumber}', bold: true)
    ..text('Date: ${data.dateString}')
    ..text('Customer: ${data.customerName}');

  if (data.customerPhone?.isNotEmpty == true) {
    builder.text('Phone: ${data.customerPhone}');
  }

  builder
    ..text('Payment: ${data.paymentMethod} (${data.paymentStatus})')
    ..line()
    ..row(
      const ['Item', 'Qty', 'Total'],
      const [56, 12, 32],
      aligns: const [ColumnAlign.left, ColumnAlign.center, ColumnAlign.right],
      wrapColumns: const [true, false, false],
      fontSize: FontSize.compressed,
    )
    ..line(char: '-');

  for (final item in data.items) {
    builder
      ..row(
        [item.name, item.quantityText, item.lineTotalText],
        const [56, 12, 32],
        aligns: const [ColumnAlign.left, ColumnAlign.center, ColumnAlign.right],
        wrapColumns: const [true, false, false],
      )
      ..text('@ ${item.unitPriceText}', fontSize: FontSize.compressed);
    if (item.discountLabel?.isNotEmpty == true) {
      builder.text(item.discountLabel!, fontSize: FontSize.compressed);
    }
  }

  builder
    ..line()
    ..text('Subtotal: ${data.subtotalText}', align: AlignPos.right);

  if (data.itemDiscountText != null) {
    builder.text(
      'Item Discounts: -${data.itemDiscountText}',
      align: AlignPos.right,
    );
  }
  if (data.billDiscountText != null) {
    builder.text(
      'Bill Discount: -${data.billDiscountText}',
      align: AlignPos.right,
    );
  }
  if (data.sgstTotalText != null) {
    builder.text(
      '${Strings.sgstTotal}: ${data.sgstTotalText}',
      align: AlignPos.right,
    );
  }
  if (data.cgstTotalText != null) {
    builder.text(
      '${Strings.cgstTotal}: ${data.cgstTotalText}',
      align: AlignPos.right,
    );
  }

  builder.text(
    'Grand Total: ${data.grandTotalText}',
    align: AlignPos.right,
    bold: true,
    fontSize: FontSize.big,
  );

  if (data.balanceText != '₹0') {
    builder
      ..text('Amount Paid: ${data.amountPaidText}', align: AlignPos.right)
      ..text('Remaining: ${data.balanceText}', align: AlignPos.right, bold: true);
  }

  builder
    ..line()
    ..text('Thank you for shopping with us!', align: AlignPos.center)
    ..text('Billed via Thuka App', align: AlignPos.center)
    ..feed(2)
    ..cut();

  return builder;
}
