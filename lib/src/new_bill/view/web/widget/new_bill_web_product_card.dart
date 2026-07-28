// lib/src/new_bill/view/web/widget/new_bill_web_product_card.dart
import 'package:flutter/material.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import '../../../model/new_bill_model.dart';

class NewBillWebProductCard extends StatefulWidget {
  const NewBillWebProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onReduce,
    this.isOutOfStock = false,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onReduce;
  final bool isOutOfStock;

  @override
  State<NewBillWebProductCard> createState() => _NewBillWebProductCardState();
}

class _NewBillWebProductCardState extends State<NewBillWebProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isSelected = widget.quantity > 0;
    final isDisabled = widget.isOutOfStock;

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: isDisabled ? null : widget.onAdd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
            border: Border.all(
              color: isSelected
                  ? colors.primary
                  : _hovered
                      ? colors.primary.withValues(alpha: 0.35)
                      : colors.inputBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Opacity(
            opacity: isDisabled ? 0.55 : 1,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: CommonCachedNetworkImage(
                        imageUrl: widget.product.imageUrl ?? '',
                        fit: BoxFit.cover,
                        memCacheWidth: 160,
                        memCacheHeight: 160,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(WebSpacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: FontPalette.base600(
                              13,
                              color: colors.primaryText,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.product.price.toCurrency(),
                            style: FontPalette.base700(
                              13,
                              color: colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  Positioned(
                    top: WebSpacing.xs,
                    right: WebSpacing.xs,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${widget.quantity}',
                        style: FontPalette.base700(11, color: ColorPalette.white),
                      ),
                    ),
                  ),
                if (isSelected)
                  Positioned(
                    top: WebSpacing.xs,
                    left: WebSpacing.xs,
                    child: Material(
                      color: colors.errorText,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: widget.onReduce,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.remove_rounded,
                            size: 14,
                            color: ColorPalette.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (isDisabled)
                  Positioned.fill(
                    child: ColoredBox(
                      color: ColorPalette.black.withValues(alpha: 0.2),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: WebSpacing.sm,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colors.surface.withValues(alpha: 0.95),
                            borderRadius:
                                BorderRadius.circular(WebSpacing.xs),
                          ),
                          child: Text(
                            Strings.outOfStock,
                            style: FontPalette.base600(
                              11,
                              color: colors.errorText,
                            ),
                          ),
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
