// lib/src/bills/view/widget/bill_detail_content.dart
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
import 'package:vyapapp/src/bills/model/bill_detail_model.dart';
import 'package:vyapapp/src/main/notifier/dropdowns_notifier.dart';
import 'package:vyapapp/src/main/model/dropdown_model.dart';
import 'package:vyapapp/src/settings/notifier/settings_notifier.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';

class BillDetailContent extends ConsumerStatefulWidget {
  const BillDetailContent({super.key, required this.billDetail});

  final BillDetailModel billDetail;

  @override
  ConsumerState<BillDetailContent> createState() => _BillDetailContentState();
}

class _BillDetailContentState extends ConsumerState<BillDetailContent> {
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
      final tempFile = File('${tempDir.path}/invoice_${widget.billDetail.orderNumber}.png');
      await tempFile.writeAsBytes(pngBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(tempFile.path)],
          text: 'Invoice ${widget.billDetail.orderNumber}',
        ),
      );
    } catch (e) {
      debugPrint("🔴 SHARE IMAGE ERROR: $e");
      showCustomErrorToast(message: 'Error sharing image: $e');
    }
  }

  void _shareText(String displayName, String customerName) {
    final receiptBuffer = StringBuffer();
    receiptBuffer.writeln('----------------------------------');
    receiptBuffer.writeln(displayName);
    receiptBuffer.writeln('             RECEIPT');
    receiptBuffer.writeln('----------------------------------');
    receiptBuffer.writeln('Invoice No: ${widget.billDetail.orderNumber}');
    receiptBuffer.writeln('Date: ${widget.billDetail.dateString}');
    receiptBuffer.writeln('Customer: $customerName');
    receiptBuffer.writeln('Payment: ${widget.billDetail.paymentMethod}');
    receiptBuffer.writeln('----------------------------------');
    for (final item in widget.billDetail.items) {
      receiptBuffer.writeln(
        '${item.productName} x${item.quantity}    ${item.totalPrice.toCurrency()}',
      );
    }
    receiptBuffer.writeln('----------------------------------');
    final itemDiscountAmount = widget.billDetail.items.fold<double>(
      0.0, (sum, item) => sum + item.discountAmount,
    );
    final subtotal = widget.billDetail.items.fold<double>(
      0.0, (sum, item) => sum + (item.price * item.quantity),
    );
    final billDiscountAmount = (widget.billDetail.discountAmount - itemDiscountAmount).clamp(0.0, double.infinity);

    receiptBuffer.writeln('Subtotal:           ${subtotal.toCurrency()}');
    if (itemDiscountAmount > 0) {
      receiptBuffer.writeln('Item Discounts:     -${itemDiscountAmount.toCurrency()}');
    }
    if (billDiscountAmount > 0) {
      receiptBuffer.writeln('Bill Discount:      -${billDiscountAmount.toCurrency()}');
    }
    receiptBuffer.writeln('Grand Total:        ${widget.billDetail.totalAmount.toCurrency()}');
    if (widget.billDetail.balance > 0.0) {
      final paidAmount = (widget.billDetail.totalAmount - widget.billDetail.balance).clamp(0.0, widget.billDetail.totalAmount);
      receiptBuffer.writeln('Amount Paid:        ${paidAmount.toCurrency()}');
      receiptBuffer.writeln('Remaining Balance:  ${widget.billDetail.balance.toCurrency()}');
    }
    receiptBuffer.writeln('----------------------------------');
    receiptBuffer.writeln('Thank you for shopping with us!');
    receiptBuffer.writeln('Billed via Thuga App');

    SharePlus.instance.share(
      ShareParams(
        text: receiptBuffer.toString(),
        subject: 'Invoice ${widget.billDetail.orderNumber}',
      ),
    );
  }

  void _showShareOptions(BuildContext context, String displayName, String customerName) {
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
                  _shareText(displayName, customerName);
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

    final customers = ref.watch(
      dropdownsNotifierProvider.select((s) => s.data.customers),
    );
    final customerName = widget.billDetail.customerId != null
        ? customers
            .firstWhere(
              (c) => c.id == widget.billDetail.customerId,
              orElse: () => DropdownCustomerModel(
                id: widget.billDetail.customerId!,
                name: 'Customer #${widget.billDetail.customerId}',
              ),
            )
            .name
        : 'Walk-in Customer';

    final itemDiscountAmount = widget.billDetail.items.fold<double>(
      0.0, (sum, item) => sum + item.discountAmount,
    );
    final subtotal = widget.billDetail.items.fold<double>(
      0.0, (sum, item) => sum + (item.price * item.quantity),
    );
    final billDiscountAmount = (widget.billDetail.discountAmount - itemDiscountAmount).clamp(0.0, double.infinity);

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: RepaintBoundary(
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMetaLabel(context, 'Invoice No'),
                                _buildMetaValue(context, widget.billDetail.orderNumber),
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
                                _buildMetaValue(context, widget.billDetail.dateString),
                                12.verticalSpace,
                                _buildMetaLabel(context, 'Payment Method'),
                                _buildMetaValue(context, '${widget.billDetail.paymentMethod} (${widget.billDetail.paymentStatus})'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const DottedDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Item Description',
                              style: FontPalette.base700(12, color: colors.secondaryText),
                            ),
                          ),
                          Text(
                            'Qty',
                            style: FontPalette.base700(12, color: colors.secondaryText),
                          ),
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              'Total',
                              textAlign: TextAlign.end,
                              style: FontPalette.base700(12, color: colors.secondaryText),
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.billDetail.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.billDetail.items[index];
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
                                        item.productName,
                                        style: FontPalette.base600(14, color: colors.primaryText),
                                      ),
                                      Text(
                                        '@ ${item.price.toCurrency()}',
                                        style: FontPalette.base400(11, color: colors.secondaryText),
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
                                  style: FontPalette.base600(14, color: colors.primaryText),
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    item.totalPrice.toCurrency(),
                                    textAlign: TextAlign.end,
                                    style: FontPalette.base700(14, color: colors.primaryText),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const DottedDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: FontPalette.base500(13, color: colors.secondaryText),
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
                              style: FontPalette.base500(13, color: colors.secondaryText),
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
                              style: FontPalette.base500(13, color: colors.secondaryText),
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
                            widget.billDetail.totalAmount.toCurrency(),
                            style: FontPalette.base700(16, color: colors.primary),
                          ),
                        ],
                      ),
                      if (widget.billDetail.balance > 0.0) ...[
                        6.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount Paid',
                              style: FontPalette.base500(
                                13,
                                color: colors.secondaryText,
                              ),
                            ),
                            Text(
                              (widget.billDetail.totalAmount - widget.billDetail.balance)
                                  .clamp(0.0, widget.billDetail.totalAmount)
                                  .toCurrency(),
                              style: FontPalette.base600(13, color: colors.primaryText),
                            ),
                          ],
                        ),
                        6.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Remaining Balance',
                              style: FontPalette.base700(
                                13,
                                color: colors.errorText,
                              ),
                            ),
                            Text(
                              widget.billDetail.balance.toCurrency(),
                              style: FontPalette.base700(13, color: colors.errorText),
                            ),
                          ],
                        ),
                      ],
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
            ),
          ),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () => _showShareOptions(context, displayName, customerName),
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
                  },
                ),
              ),
            ],
          ),
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
