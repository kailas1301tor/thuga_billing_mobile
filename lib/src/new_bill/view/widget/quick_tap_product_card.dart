// lib/src/new_bill/view/widget/quick_tap_product_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import '../../model/new_bill_model.dart';

class QuickTapProductCard extends StatefulWidget {
  const QuickTapProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onTap,
    required this.onReduce,
    this.onLongPress,
    this.isOutOfStock = false,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onTap;
  final VoidCallback onReduce;
  final VoidCallback? onLongPress;
  final bool isOutOfStock;

  @override
  State<QuickTapProductCard> createState() => _QuickTapProductCardState();
}

class _QuickTapProductCardState extends State<QuickTapProductCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      lowerBound: 0.92,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isSelected = widget.quantity > 0;
    final isDisabled = widget.isOutOfStock;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: GestureDetector(
      onTapDown: (_) => _animCtrl.reverse(),
      onTapUp: (_) {
        _animCtrl.forward();
        widget.onTap();
      },
      onTapCancel: () => _animCtrl.forward(),
      onLongPress: widget.onLongPress,
      child: ScaleTransition(
        scale: _animCtrl,
        child: Container(
          margin: EdgeInsets.all(2.r),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? colors.primary : colors.inputBorder,
              width: isSelected ? 2.w : 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isSelected ? 0.04 : 0.02),
                blurRadius: 6.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Card Content (Clipped to prevent image overlapping the border curve)
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: CommonCachedNetworkImage(
                        imageUrl: widget.product.imageUrl ?? "",
                        borderRadius: 0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      color: isSelected ? colors.primary.withValues(alpha: 0.02) : colors.surface,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.product.name,
                            style: FontPalette.base700(12, color: colors.primaryText),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          2.verticalSpace,
                          Text(
                            widget.product.price.toCurrency(),
                            style: FontPalette.base600(11, color: colors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Live Quantity Badge with pop-in scale animation
              Positioned(
                top: 6.h,
                right: 6.w,
                child: AnimatedScale(
                  scale: isSelected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutBack,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    constraints: BoxConstraints(
                      minWidth: 18.r,
                      minHeight: 18.r,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.quantity}',
                      style: FontPalette.base700(
                        8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Reduce Button with pop-in scale animation
              Positioned(
                top: 6.h,
                left: 6.w,
                child: AnimatedScale(
                  scale: isSelected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutBack,
                  child: GestureDetector(
                    onTap: widget.onReduce,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      constraints: BoxConstraints(
                        minWidth: 20.r,
                        minHeight: 20.r,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.remove_rounded,
                        size: 12.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              if (isDisabled)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        Strings.outOfStock,
                        style: FontPalette.base600(9, color: colors.errorText),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
