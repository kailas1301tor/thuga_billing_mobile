// lib/src/calculation/view/widget/calculation_product_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import '../../model/calculation_catalog_model.dart';

class CalculationProductTile extends StatelessWidget {
  const CalculationProductTile({
    super.key,
    required this.product,
    required this.quantity,
    required this.onTap,
    required this.onReduce,
  });

  final CalculationProductModel product;
  final int quantity;
  final VoidCallback onTap;
  final VoidCallback onReduce;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isSelected = quantity > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.inputBorder,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: product.imageUrl != null &&
                            product.imageUrl!.isNotEmpty
                        ? CommonCachedNetworkImage(
                            imageUrl: product.imageUrl,
                            width: double.infinity,
                            height: 56.h,
                            borderRadius: 8.r,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Icon(
                              Icons.inventory_2_outlined,
                              size: 28.r,
                              color: colors.secondaryText,
                            ),
                          ),
                  ),
                  6.verticalSpace,
                  Text(
                    product.name,
                    style: FontPalette.base600(11, color: colors.primaryText),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.price.toCurrency(),
                    style: FontPalette.base700(12, color: colors.primary),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 4.h,
                right: 4.w,
                child: GestureDetector(
                  onTap: onReduce,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Text(
                      '$quantity',
                      style: FontPalette.base700(10, color: ColorPalette.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
