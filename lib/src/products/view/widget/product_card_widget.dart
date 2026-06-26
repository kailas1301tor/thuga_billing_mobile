// lib/src/products/view/widget/product_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/common_widgets/common_nav_bar_button.dart';
import 'package:vyapapp/utils/common_widgets/common_cached_network_image.dart';
import 'package:vyapapp/src/products/model/product_crud_model.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  final ProductCrudModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasCategory = product.categoryName != null && product.categoryName!.trim().isNotEmpty;
    final categoryText = hasCategory ? product.categoryName!.trim() : 'Uncategorized';

    return CommonContainer(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: colors.surface,
      borderRadius: 16.r,
      border: Border.all(color: colors.inputBorder, width: 1.w),
      boxShadow: [
        BoxShadow(
          color: ColorPalette.black.withValues(alpha: 0.02),
          blurRadius: 8.r,
          offset: Offset(0, 4.h),
        ),
      ],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonCachedNetworkImage(
            imageUrl: product.image ?? "",
            width: 56.r,
            height: 56.r,
            memCacheWidth: 56,
            memCacheHeight: 56,
            borderRadius: 12.r,
            fit: BoxFit.cover,
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: FontPalette.base600(15, color: colors.primaryText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                6.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: hasCategory
                        ? colors.primary.withValues(alpha: 0.08)
                        : colors.inputBackground,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: hasCategory
                          ? colors.primary.withValues(alpha: 0.15)
                          : colors.inputBorder,
                      width: 0.5.w,
                    ),
                  ),
                  child: Text(
                    categoryText,
                    style: FontPalette.base500(
                      10,
                      color: hasCategory ? colors.primary : colors.secondaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                8.verticalSpace,
                Text(
                  '₹${product.price}',
                  style: FontPalette.base600(14, color: colors.primary),
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonNavBarButton(
                icon: Icon(
                  Icons.edit_rounded,
                  size: 18.r,
                  color: colors.primary,
                ),
                onTap: onEdit,
              ),
              8.verticalSpace,
              CommonNavBarButton(
                icon: Icon(
                  Icons.delete_rounded,
                  size: 18.r,
                  color: colors.errorText,
                ),
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

