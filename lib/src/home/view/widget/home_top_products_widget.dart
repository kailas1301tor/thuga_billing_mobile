// lib/src/home/view/widget/home_top_products_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/home/model/home_top_product_model.dart';
import 'package:vyapapp/utils/common_widgets/common_cached_network_image.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/common_widgets/common_section_header.dart';

import 'home_section_empty_text.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

class HomeTopProductsWidget extends StatelessWidget {
  const HomeTopProductsWidget({super.key, required this.products});

  final List<HomeTopProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
      child: Column(
        children: [
          CommonSectionHeader(title: Strings.topProductsToday),
          10.verticalSpace,
          if (products.isEmpty)
            const HomeSectionEmptyText(message: Strings.noTopProductsToday)
          else
            Column(
              children: [
                for (final p in products) ...[
                  _ProductRow(product: p),
                  10.verticalSpace,
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({required this.product});

  final HomeTopProductModel product;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return CommonContainer(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      borderRadius: 16.r,
      border: Border.all(color: colors.inputBorder, width: 1.h),
      boxShadow: const [],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonCachedNetworkImage(
            imageUrl: product.imageUrl ?? "",
            width: 48.r,
            height: 48.r,
            memCacheWidth: 100,
            memCacheHeight: 100,
            fit: BoxFit.cover,
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: FontPalette.base700(
                          15,
                          color: colors.primaryText,
                        ),
                      ),
                    ),
                    Text(
                      product.amount.toCurrency(),
                      style: FontPalette.base700(15, color: colors.primary),
                    ),
                  ],
                ),
                4.verticalSpace,
                Text(
                  '${product.quantity} ${product.unitLabel}',
                  style: FontPalette.base400(12, color: colors.secondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
