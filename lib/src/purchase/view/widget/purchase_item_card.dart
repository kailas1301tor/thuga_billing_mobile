// lib/src/purchase/view/widget/purchase_item_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';
import '../../model/purchase_model.dart';

class PurchaseItemCard extends StatefulWidget {
  final PurchaseModel purchase;
  const PurchaseItemCard({super.key, required this.purchase});

  @override
  State<PurchaseItemCard> createState() => _PurchaseItemCardState();
}

class _PurchaseItemCardState extends State<PurchaseItemCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CommonContainer(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        borderRadius: 24.r,
        border: Border.all(color: colors.inputBorder, width: 1.w),
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon container
                CommonContainer(
                  width: 48.r,
                  height: 48.r,
                  padding: EdgeInsets.zero,
                  borderRadius: 100.r,
                  color: ColorPalette.homeStatOrangeBg,
                  boxShadow: const [],
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 22.r,
                      color: ColorPalette.homeOrangeAccent,
                    ),
                  ),
                ),
                12.horizontalSpace,
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purchase #${widget.purchase.id}',
                        style: FontPalette.base700(16, color: colors.primaryText),
                      ),
                      4.verticalSpace,
                      Text(
                        widget.purchase.purchaseDate,
                        style: FontPalette.base400(13, color: colors.secondaryText),
                      ),
                      4.verticalSpace,
                      Text(
                        '${widget.purchase.items.length} items',
                        style: FontPalette.base500(13, color: colors.secondaryText),
                      ),
                    ],
                  ),
                ),
                8.horizontalSpace,
                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.purchase.totalAmount.toCurrency(),
                      style: FontPalette.base700(16, color: colors.primary),
                    ),
                  ],
                ),
                8.horizontalSpace,
                // Chevron icon
                AnimatedRotation(
                  turns: _isExpanded ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 20.r,
                    color: ColorPalette.navInactive,
                  ),
                ),
              ],
            ),
            if (_isExpanded) ...[
              12.verticalSpace,
              const Divider(height: 1),
              8.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.purchase.items.length,
                itemBuilder: (context, index) {
                  final item = widget.purchase.items[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName,
                                style: FontPalette.base600(13, color: colors.primaryText),
                              ),
                              Text(
                                '@ ${item.price.toCurrency()} x ${item.quantity}',
                                style: FontPalette.base400(11, color: colors.secondaryText),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item.totalPrice.toCurrency(),
                          style: FontPalette.base700(13, color: colors.primaryText),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
