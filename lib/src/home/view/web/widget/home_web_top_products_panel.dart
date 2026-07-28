// lib/src/home/view/web/widget/home_web_top_products_panel.dart
import 'package:flutter/material.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/src/home/model/home_top_product_model.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/common_widgets/web/web_grid.dart';
import 'package:thuga/utils/helpers/amount_formatter.dart';

class HomeWebTopProductsPanel extends StatelessWidget {
  const HomeWebTopProductsPanel({super.key, required this.products});

  final List<HomeTopProductModel> products;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    if (products.isEmpty) {
      return Text(
        Strings.noTopProductsToday,
        style: FontPalette.base400(14, color: colors.secondaryText),
      );
    }

    return WebGrid(
      mobileColumns: 2,
      tabletColumns: 4,
      desktopColumns: 5,
      minItemWidth: 150,
      spacing: WebSpacing.sm,
      runSpacing: WebSpacing.sm,
      children: [
        for (var i = 0; i < products.length; i++)
          _ProductGridCard(product: products[i], rank: i + 1),
      ],
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  const _ProductGridCard({required this.product, required this.rank});

  final HomeTopProductModel product;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = Color(product.progressColor);

    return Container(
      padding: const EdgeInsets.all(WebSpacing.sm),
      decoration: BoxDecoration(
        color: colors.inputBackground,
        borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
        border: Border.all(color: colors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colors.inputBorder),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CommonCachedNetworkImage(
                        imageUrl: product.imageUrl ?? '',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        borderRadius: 8,
                        memCacheWidth: 240,
                        memCacheHeight: 240,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$rank',
                        style: FontPalette.base700(10, color: ColorPalette.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: WebSpacing.sm),
          Text(
            product.name,
            style: FontPalette.base600(12, color: colors.primaryText),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${product.quantity} ${product.unitLabel}',
                  style: FontPalette.base400(11, color: colors.secondaryText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                formatDisplayCurrency(product.amount),
                style: FontPalette.base700(12, color: colors.primary),
              ),
            ],
          ),
          const SizedBox(height: WebSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (product.salesPercent / 100).clamp(0.0, 1.0),
              minHeight: 3,
              backgroundColor: colors.inputBorder,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}
