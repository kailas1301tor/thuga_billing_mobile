// lib/src/new_bill/view/widget/quick_tap_cart_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_cached_network_image.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';
import '../../model/new_bill_model.dart';

class QuickTapCartList extends StatelessWidget {
  const QuickTapCartList({
    super.key,
    required this.cartItems,
    required this.onIncrementQty,
    required this.onDecrementQty,
    required this.onRemoveCartItem,
    required this.onTapDiscount,
  });

  final List<CartItemModel> cartItems;
  final ValueChanged<CartItemModel> onIncrementQty;
  final ValueChanged<CartItemModel> onDecrementQty;
  final ValueChanged<CartItemModel> onRemoveCartItem;
  final ValueChanged<CartItemModel> onTapDiscount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      separatorBuilder: (_, __) => Divider(color: colors.inputBorder, height: 1.h),
      itemBuilder: (context, index) {
        final item = cartItems[index];
        final keyString = '${item.productId ?? "custom"}_${item.name}';
        
        return Dismissible(
          key: ValueKey(keyString),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Remove',
                  style: FontPalette.base700(13, color: Colors.white),
                ),
                8.horizontalSpace,
                Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                  size: 20.r,
                ),
              ],
            ),
          ),
          onDismissed: (_) {
            onRemoveCartItem(item);
          },
          child: GestureDetector(
            onTap: () => onTapDiscount(item),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  // Image or Emoji prefix
                  Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: colors.inputBackground,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                        ? CommonCachedNetworkImage(
                            imageUrl: item.imageUrl!,
                            width: 36.r,
                            height: 36.r,
                            memCacheWidth: 80,
                            memCacheHeight: 80,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              item.emoji,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                  ),
                  12.horizontalSpace,

                  // Name + Discount Badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: FontPalette.base700(14, color: colors.primaryText),
                        ),
                        if (item.hasDiscount) ...[
                          4.verticalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              '${item.discountLabel} · Save ${item.discountAmount.toCurrency()}',
                              style: FontPalette.base600(
                                10,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Qty Multiplier Label (e.g. x3)
                  Text(
                    'x${item.quantity}',
                    style: FontPalette.base500(13, color: colors.secondaryText),
                  ),
                  16.horizontalSpace,

                  // Large, easy-to-tap quantity selector
                  Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.inputBorder.withValues(alpha: 0.8), width: 1.w),
                      borderRadius: BorderRadius.circular(100.r),
                      color: colors.inputBackground,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => onDecrementQty(item),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                            child: Icon(
                              Icons.remove_rounded,
                              size: 15.r,
                              color: colors.secondaryText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            '${item.quantity}',
                            style: FontPalette.base700(13, color: colors.primaryText),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => onIncrementQty(item),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                            child: Icon(
                              Icons.add_rounded,
                              size: 15.r,
                              color: colors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.horizontalSpace,

                  // Line Total (shows discounted price if applicable)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (item.hasDiscount) ...[
                        Text(
                          item.lineTotal.toCurrency(),
                          style: FontPalette.base400(
                            11,
                            color: colors.secondaryText,
                          ).copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      ],
                      Text(
                        item.totalPrice.toCurrency(),
                        style: FontPalette.base700(
                          15,
                          color: item.hasDiscount
                              ? Colors.green.shade700
                              : colors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
