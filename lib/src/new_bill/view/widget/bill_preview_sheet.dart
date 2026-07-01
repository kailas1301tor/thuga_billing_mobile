// lib/src/new_bill/view/widget/bill_preview_sheet.dart
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/new_bill/model/new_bill_model.dart';
import 'package:vyapapp/src/settings/notifier/settings_notifier.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';

class BillPreviewSheet extends ConsumerStatefulWidget {
  const BillPreviewSheet({
    super.key,
    required this.orderNumber,
    required this.dateString,
    required this.paymentMethod,
    required this.customerName,
    required this.cartItems,
    required this.subtotal,
    required this.itemDiscountAmount,
    required this.billDiscountAmount,
  });

  final String orderNumber;
  final String dateString;
  final String paymentMethod;
  final String customerName;
  final List<CartItemModel> cartItems;
  final double subtotal;
  final double itemDiscountAmount;
  final double billDiscountAmount;

  @override
  ConsumerState<BillPreviewSheet> createState() => _BillPreviewSheetState();
}

class _BillPreviewSheetState extends ConsumerState<BillPreviewSheet> {
  final GlobalKey _repaintKey = GlobalKey();

  Future<void> _shareImage() async {
    try {
      final boundary = _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        showCustomErrorToast(message: 'Failed to capture bill preview');
        return;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        showCustomErrorToast(message: 'Failed to format bill image');
        return;
      }

      final pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/invoice_${widget.orderNumber}.png');
      await tempFile.writeAsBytes(pngBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(tempFile.path)],
          text: 'Invoice ${widget.orderNumber}',
        ),
      );
    } catch (e) {
      debugPrint("🔴 SHARE IMAGE ERROR: $e");
      showCustomErrorToast(message: 'Error sharing image: $e');
    }
  }

  void _shareText(String displayName) {
    final receiptBuffer = StringBuffer();
    receiptBuffer.writeln('----------------------------------');
    receiptBuffer.writeln(displayName);
    receiptBuffer.writeln('             RECEIPT');
    receiptBuffer.writeln('----------------------------------');
    receiptBuffer.writeln('Invoice No: ${widget.orderNumber}');
    receiptBuffer.writeln('Date: ${widget.dateString}');
    receiptBuffer.writeln('Customer: ${widget.customerName}');
    receiptBuffer.writeln('Payment: ${widget.paymentMethod}');
    receiptBuffer.writeln('----------------------------------');
    for (final item in widget.cartItems) {
      receiptBuffer.writeln(
        '${item.name} x${item.quantity}    ${(item.price * item.quantity).toCurrency()}',
      );
    }
    receiptBuffer.writeln('----------------------------------');
    receiptBuffer.writeln('Subtotal:           ${widget.subtotal.toCurrency()}');
    if (widget.itemDiscountAmount > 0) {
      receiptBuffer.writeln('Item Discounts:     -${widget.itemDiscountAmount.toCurrency()}');
    }
    if (widget.billDiscountAmount > 0) {
      receiptBuffer.writeln('Bill Discount:      -${widget.billDiscountAmount.toCurrency()}');
    }
    final totalDiscount = widget.itemDiscountAmount + widget.billDiscountAmount;
    receiptBuffer.writeln('Grand Total:        ${(widget.subtotal - totalDiscount).clamp(0.0, double.infinity).toCurrency()}');
    receiptBuffer.writeln('----------------------------------');
    receiptBuffer.writeln('Thank you for shopping with us!');
    receiptBuffer.writeln('Billed via Thuga App');

    SharePlus.instance.share(
      ShareParams(
        text: receiptBuffer.toString(),
        subject: 'Invoice ${widget.orderNumber}',
      ),
    );
  }

  void _showShareOptions(BuildContext context, String displayName) {
    final colors = context.appColors;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  'Share Receipt',
                  style: FontPalette.base700(16, color: colors.primaryText),
                ),
              ),
              ListTile(
                leading: Icon(Icons.image_outlined, color: colors.primary),
                title: Text('Share as Image', style: FontPalette.base600(14, color: colors.primaryText)),
                onTap: () {
                  Navigator.pop(context);
                  _shareImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.text_fields_outlined, color: colors.primary),
                title: Text('Share as Text', style: FontPalette.base600(14, color: colors.primaryText)),
                onTap: () {
                  Navigator.pop(context);
                  _shareText(displayName);
                },
              ),
              SizedBox(height: 12.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final storeName = ref.watch(
      settingsNotifierProvider.select((s) => s.settings.storeName),
    );
    final displayName = storeName.isNotEmpty ? storeName.toUpperCase() : 'THUKA';

    final orderNumber = widget.orderNumber;
    final dateString = widget.dateString;
    final paymentMethod = widget.paymentMethod;
    final customerName = widget.customerName;
    final cartItems = widget.cartItems;
    final subtotal = widget.subtotal;
    final itemDiscountAmount = widget.itemDiscountAmount;
    final billDiscountAmount = widget.billDiscountAmount;
    final totalDiscount = itemDiscountAmount + billDiscountAmount;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Receipt Card Container
          RepaintBoundary(
            key: _repaintKey,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.inputBackground,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: colors.inputBorder, width: 1.w),
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Store Brand Header
                Text(
                  displayName,
                  style: FontPalette.base700(20, color: colors.primary),
                ),
                4.verticalSpace,
                Text(
                  'RECEIPT',
                  style: FontPalette.base600(
                    11,
                    color: colors.secondaryText,
                  ).copyWith(letterSpacing: 2),
                ),
                const DottedDivider(),

                // Metadata Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMetaLabel(context, 'Invoice No'),
                          _buildMetaValue(context, orderNumber),
                          12.verticalSpace,
                          _buildMetaLabel(context, 'Customer'),
                          _buildMetaValue(context, customerName),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMetaLabel(context, 'Date'),
                          _buildMetaValue(context, dateString),
                          12.verticalSpace,
                          _buildMetaLabel(context, 'Payment Method'),
                          _buildMetaValue(context, '$paymentMethod (Paid)'),
                        ],
                      ),
                    ),
                  ],
                ),
                const DottedDivider(),

                // Items list header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Item Description',
                        style: FontPalette.base700(
                          12,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                    Text(
                      'Qty',
                      style: FontPalette.base700(
                        12,
                        color: colors.secondaryText,
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                      child: Text(
                        'Total',
                        textAlign: TextAlign.end,
                        style: FontPalette.base700(
                          12,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,

                // Items list rows
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: FontPalette.base600(
                                    14,
                                    color: colors.primaryText,
                                  ),
                                ),
                                Text(
                                  '@ ${item.price.toCurrency()}',
                                  style: FontPalette.base400(
                                    11,
                                    color: colors.secondaryText,
                                  ),
                                ),
                                if (item.hasDiscount)
                                  Text(
                                    item.discountLabel,
                                    style: FontPalette.base500(
                                      10,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            'x${item.quantity}',
                            style: FontPalette.base600(
                              14,
                              color: colors.primaryText,
                            ),
                          ),
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              item.totalPrice.toCurrency(),
                              textAlign: TextAlign.end,
                              style: FontPalette.base700(
                                14,
                                color: colors.primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const DottedDivider(),

                // Summary calculations
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: FontPalette.base500(
                        13,
                        color: colors.secondaryText,
                      ),
                    ),
                    Text(
                      subtotal.toCurrency(),
                      style: FontPalette.base600(13, color: colors.primaryText),
                    ),
                  ],
                ),
                if (itemDiscountAmount > 0) ...[
                  6.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item Discounts',
                        style: FontPalette.base500(
                          13,
                          color: colors.secondaryText,
                        ),
                      ),
                      Text(
                        '- ${itemDiscountAmount.toCurrency()}',
                        style: FontPalette.base600(
                          13,
                          color: Colors.green.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
                if (billDiscountAmount > 0) ...[
                  6.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bill Discount',
                        style: FontPalette.base500(
                          13,
                          color: colors.secondaryText,
                        ),
                      ),
                      Text(
                        '- ${billDiscountAmount.toCurrency()}',
                        style: FontPalette.base600(
                          13,
                          color: Colors.green.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Total',
                      style: FontPalette.base700(15, color: colors.primaryText),
                    ),
                    Text(
                      (subtotal - totalDiscount)
                          .clamp(0.0, double.infinity)
                          .toCurrency(),
                      style: FontPalette.base700(16, color: colors.primary),
                    ),
                  ],
                ),
                const DottedDivider(),
                16.verticalSpace,
                Text(
                  'Thank you for shopping with us!',
                  style: FontPalette.base500(12, color: colors.secondaryText),
                  textAlign: TextAlign.center,
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Billed via ',
                      style: FontPalette.base400(10, color: colors.secondaryText),
                    ),
                    Text(
                      'Thuga App',
                      style: FontPalette.base700(10, color: colors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        24.verticalSpace,

          // Action buttons
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () => _showShareOptions(context, displayName),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share_rounded,
                        size: 18.r,
                        color: colors.primary,
                      ),
                      6.horizontalSpace,
                      Text(
                        'Share',
                        style: FontPalette.base600(15, color: colors.primary),
                      ),
                    ],
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  text: 'Print Invoice',
                  radius: 12,
                  prefixIcon: Icon(
                    Icons.print_rounded,
                    size: 20.r,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showCustomToast(message: 'Sending invoice to printer...');
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          8.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildMetaLabel(BuildContext context, String text) {
    return Text(
      text,
      style: FontPalette.base400(11, color: context.appColors.secondaryText),
    );
  }

  Widget _buildMetaValue(BuildContext context, String text) {
    return Text(
      text,
      style: FontPalette.base600(13, color: context.appColors.primaryText),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]!
        : Colors.grey[300]!;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 4.0;
          final dashHeight = 1.0;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(decoration: BoxDecoration(color: colors)),
              );
            }),
          );
        },
      ),
    );
  }
}

