// lib/utils/helpers/receipt_print_helper.dart
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:thuga/res/constants/string_constants.dart';

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
    this.storePhone,
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
  final String? storePhone;
}

String? formatReceiptStorePhoneLine(String? storePhone) {
  final trimmed = storePhone?.trim() ?? '';
  if (trimmed.isEmpty) {
    return null;
  }
  return '${Strings.receiptStorePhoneLabel}: $trimmed';
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

/// Thermal ESC/POS printers encode with Latin-1 by default and reject
/// characters such as ₹ (U+20B9). UI/share text can keep Unicode symbols.
String sanitizeEscPosText(String text) {
  final buffer = StringBuffer();
  for (final codeUnit in text.runes) {
    if (codeUnit == 0x20B9) {
      buffer.write('Rs.');
      continue;
    }
    if (codeUnit <= 0xFF) {
      buffer.writeCharCode(codeUnit);
      continue;
    }
    buffer.write('?');
  }
  return buffer.toString();
}

String buildReceiptShareText(ReceiptPrintData data) {
  final receiptBuffer = StringBuffer();
  receiptBuffer.writeln('----------------------------------');
  receiptBuffer.writeln(normalizeReceiptStoreName(data.storeName));
  final storePhoneLine = formatReceiptStorePhoneLine(data.storePhone);
  if (storePhoneLine != null) {
    receiptBuffer.writeln('          $storePhoneLine');
  }
  receiptBuffer.writeln('             RECEIPT');
  receiptBuffer.writeln('----------------------------------');
  receiptBuffer.writeln('Invoice No: ${data.orderNumber}');
  receiptBuffer.writeln('Date: ${data.dateString}');
  receiptBuffer.writeln('Customer: ${data.customerName}');
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
  receiptBuffer.writeln(Strings.billedViaApp);
  return receiptBuffer.toString();
}

const _itemColWidth = 7;
const _qtyColWidth = 1;
const _totalColWidth = 4;

const _compressedStyle = PosStyles(fontType: PosFontType.fontB);
const _headerRowStyle = PosStyles(
  fontType: PosFontType.fontB,
  bold: true,
);
const _titleStyle = PosStyles(
  align: PosAlign.center,
  bold: true,
  height: PosTextSize.size2,
  width: PosTextSize.size2,
);
const _receiptLabelStyle = PosStyles(
  align: PosAlign.center,
  fontType: PosFontType.fontB,
);
const _grandTotalStyle = PosStyles(
  align: PosAlign.right,
  bold: true,
  height: PosTextSize.size2,
  width: PosTextSize.size2,
);
const _rightBoldStyle = PosStyles(align: PosAlign.right, bold: true);
const _rightStyle = PosStyles(align: PosAlign.right);
const _centerStyle = PosStyles(align: PosAlign.center);

Future<List<int>> buildReceiptEscPosBytes(
  ReceiptPrintData data, {
  required PaperSize paperSize,
}) async {
  String escPos(String text) => sanitizeEscPosText(text);

  final profile = await CapabilityProfile.load();
  final generator = Generator(paperSize, profile);
  final bytes = <int>[];

  bytes.addAll(generator.reset());
  bytes.addAll(
    generator.text(
      escPos(normalizeReceiptStoreName(data.storeName)),
      styles: _titleStyle,
    ),
  );
  final storePhoneLine = formatReceiptStorePhoneLine(data.storePhone);
  if (storePhoneLine != null) {
    bytes.addAll(
      generator.text(
        escPos(storePhoneLine),
        styles: _centerStyle,
      ),
    );
  }
  bytes.addAll(
    generator.text('RECEIPT', styles: _receiptLabelStyle),
  );
  bytes.addAll(generator.hr());
  bytes.addAll(
    generator.text(
      escPos('Invoice No: ${data.orderNumber}'),
      styles: const PosStyles(bold: true),
    ),
  );
  bytes.addAll(generator.text(escPos('Date: ${data.dateString}')));
  bytes.addAll(generator.text(escPos('Customer: ${data.customerName}')));

  bytes.addAll(
    generator.text(
      escPos('Payment: ${data.paymentMethod} (${data.paymentStatus})'),
    ),
  );
  bytes.addAll(generator.hr());
  bytes.addAll(
    generator.row(
      [
        PosColumn(text: 'Item', width: _itemColWidth, styles: _headerRowStyle),
        PosColumn(
          text: 'Qty',
          width: _qtyColWidth,
          styles: _headerRowStyle.copyWith(align: PosAlign.center),
        ),
        PosColumn(
          text: 'Total',
          width: _totalColWidth,
          styles: _headerRowStyle.copyWith(align: PosAlign.right),
        ),
      ],
    ),
  );
  bytes.addAll(generator.hr(ch: '-'));

  for (final item in data.items) {
    bytes.addAll(
      generator.row(
        [
          PosColumn(text: escPos(item.name), width: _itemColWidth),
          PosColumn(
            text: escPos(item.quantityText),
            width: _qtyColWidth,
            styles: const PosStyles(align: PosAlign.center),
          ),
          PosColumn(
            text: escPos(item.lineTotalText),
            width: _totalColWidth,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ],
      ),
    );
    bytes.addAll(
      generator.text(
        escPos('@ ${item.unitPriceText}'),
        styles: _compressedStyle,
      ),
    );
    if (item.discountLabel?.isNotEmpty == true) {
      bytes.addAll(
        generator.text(
          escPos(item.discountLabel!),
          styles: _compressedStyle,
        ),
      );
    }
  }

  bytes.addAll(generator.hr());
  bytes.addAll(
    generator.text(
      escPos('Subtotal: ${data.subtotalText}'),
      styles: _rightStyle,
    ),
  );

  if (data.itemDiscountText != null) {
    bytes.addAll(
      generator.text(
        escPos('Item Discounts: -${data.itemDiscountText}'),
        styles: _rightStyle,
      ),
    );
  }
  if (data.billDiscountText != null) {
    bytes.addAll(
      generator.text(
        escPos('Bill Discount: -${data.billDiscountText}'),
        styles: _rightStyle,
      ),
    );
  }
  if (data.sgstTotalText != null) {
    bytes.addAll(
      generator.text(
        escPos('${Strings.sgstTotal}: ${data.sgstTotalText}'),
        styles: _rightStyle,
      ),
    );
  }
  if (data.cgstTotalText != null) {
    bytes.addAll(
      generator.text(
        escPos('${Strings.cgstTotal}: ${data.cgstTotalText}'),
        styles: _rightStyle,
      ),
    );
  }

  bytes.addAll(
    generator.text(
      escPos('Grand Total: ${data.grandTotalText}'),
      styles: _grandTotalStyle,
    ),
  );

  if (data.balanceText != '₹0') {
    bytes.addAll(
      generator.text(
        escPos('Amount Paid: ${data.amountPaidText}'),
        styles: _rightStyle,
      ),
    );
    bytes.addAll(
      generator.text(
        escPos('Remaining: ${data.balanceText}'),
        styles: _rightBoldStyle,
      ),
    );
  }

  bytes.addAll(generator.hr());
  bytes.addAll(
    generator.text(
      'Thank you for shopping with us!',
      styles: _centerStyle,
    ),
  );
  bytes.addAll(
    generator.text(Strings.billedViaApp, styles: _centerStyle),
  );
  bytes.addAll(generator.feed(2));
  bytes.addAll(generator.cut());

  return bytes;
}

Future<List<int>> buildDemoEscPosBytes({
  required PaperSize paperSize,
  required String storeName,
  required String dateTimeText,
  required String paperWidthLabel,
}) async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(paperSize, profile);
  final bytes = <int>[];

  bytes.addAll(generator.reset());
  bytes.addAll(
    generator.text(
      normalizeReceiptStoreName(storeName),
      styles: _titleStyle,
    ),
  );
  bytes.addAll(
    generator.text(Strings.printerTestLabel, styles: _receiptLabelStyle),
  );
  bytes.addAll(generator.hr());
  bytes.addAll(generator.text(dateTimeText, styles: _centerStyle));
  bytes.addAll(
    generator.text(
      '${Strings.paperWidth}: $paperWidthLabel',
      styles: _centerStyle,
    ),
  );
  bytes.addAll(generator.feed(2));
  bytes.addAll(generator.cut());

  return bytes;
}
