// lib/src/new_bill/view/widget/quick_tap_cart_strip.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import '../../notifier/new_bill_notifier.dart';

class QuickTapCartStrip extends ConsumerWidget {
  const QuickTapCartStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    
    final isExpanded = ref.watch(newBillNotifierProvider.select((s) => s.isCartExpanded));
    final cart = ref.watch(newBillNotifierProvider.select((s) => s.cart));

    if (cart.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalItems = cart.fold<int>(0, (sum, item) => sum + item.quantity);
    final totalPrice = cart.fold<double>(0.0, (sum, item) => sum + item.lineTotal);

    return GestureDetector(
      onTap: () {
        ref.read(newBillNotifierProvider.notifier).toggleCartExpanded();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: colors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -3),
              blurRadius: 10,
            ),
          ],
          border: Border(
            top: BorderSide(
              color: colors.inputBorder.withValues(alpha: 0.8),
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          children: [
            // Cart Icon with Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: colors.primary,
                  size: 20.r,
                ),
                Positioned(
                  top: -6.h,
                  right: -6.w,
                  child: Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14.r,
                      minHeight: 14.r,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$totalItems',
                      style: FontPalette.base700(
                        8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            12.horizontalSpace,
            
            // Item count text
            Text(
              '$totalItems ${totalItems == 1 ? "Item" : "Items"}',
              style: FontPalette.base700(14, color: colors.primaryText),
            ),
            
            const Spacer(),
            
            // Total Price
            Text(
              '₹${totalPrice.toStringAsFixed(2)}',
              style: FontPalette.base700(16, color: colors.primary),
            ),
            8.horizontalSpace,
            
            // Chevron arrow
            Icon(
              isExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
              color: colors.secondaryText,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
