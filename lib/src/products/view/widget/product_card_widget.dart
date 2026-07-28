// lib/src/products/view/widget/product_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/src/products/model/product_crud_model.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    this.onToggleStatus,
    this.isToggling = false,
  });

  final ProductCrudModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool>? onToggleStatus;
  final bool isToggling;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CommonContainer(
        padding: EdgeInsets.zero,
        color: colors.surface,
        borderRadius: 20.r,
        border: Border.all(color: colors.inputBorder, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            listTileTheme: ListTileThemeData(
              minLeadingWidth: 0,
              horizontalTitleGap: 0,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          child: ExpansionTile(
            showTrailingIcon: false,
            tilePadding: EdgeInsets.all(12.w),
            childrenPadding: EdgeInsets.zero,
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const SizedBox.shrink(),
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
            title: _ProductCardHeader(
              product: product,
              colors: colors,
              isToggling: isToggling,
              onEdit: onEdit,
              onDelete: onDelete,
              onToggleStatus: onToggleStatus,
            ),
            children: [
              _ProductExpandedDetails(product: product, colors: colors),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCardHeader extends StatelessWidget {
  const _ProductCardHeader({
    required this.product,
    required this.colors,
    required this.isToggling,
    required this.onEdit,
    required this.onDelete,
    this.onToggleStatus,
  });

  final ProductCrudModel product;
  final AppColors colors;
  final bool isToggling;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool>? onToggleStatus;

  String get _quantityText {
    final quantity = product.quantity;
    if (quantity == null) return Strings.notAvailable;
    if (quantity % 1 == 0) return quantity.toInt().toString();
    return quantity.toString();
  }

  Color get _quantityColor {
    final quantity = product.quantity;
    if (quantity != null && quantity < 0) return colors.errorText;
    return colors.primaryText;
  }

  String get _priceText => product.price.toCurrency();

  @override
  Widget build(BuildContext context) {
    final hasCategory =
        product.categoryName != null && product.categoryName!.trim().isNotEmpty;
    final categoryText = hasCategory
        ? product.categoryName!.trim()
        : 'Uncategorized';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonCachedNetworkImage(
          imageUrl: product.image ?? '',
          width: 64.r,
          height: 88.h,
          memCacheWidth: 64,
          memCacheHeight: 88,
          borderRadius: 12.r,
          fit: BoxFit.cover,
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: FontPalette.base600(16, color: colors.primaryText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      8.horizontalSpace,
                      _ProductIconButton(
                        icon: Icons.edit_rounded,
                        color: colors.primary,
                        borderColor: colors.primary.withValues(alpha: 0.4),
                        onTap: onEdit,
                      ),
                      6.horizontalSpace,
                      _ProductIconButton(
                        icon: Icons.delete_rounded,
                        color: colors.errorText,
                        borderColor: colors.errorText.withValues(alpha: 0.4),
                        onTap: onDelete,
                      ),
                      6.horizontalSpace,
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18.r,
                        color: colors.secondaryText,
                      ),
                    ],
                  ),
                ],
              ),
              6.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CategoryBadge(
                    label: categoryText,
                    isHighlighted: hasCategory,
                    colors: colors,
                  ),
                  if (isToggling)
                    SizedBox(
                      width: 28.w,
                      height: 24.h,
                      child: Center(
                        child: SizedBox(
                          width: 14.r,
                          height: 14.r,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 2.w,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colors.primary,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    _ProductStatusSwitch(
                      value: product.isActive,
                      onChanged: onToggleStatus,
                      colors: colors,
                    ),
                ],
              ),
              10.verticalSpace,
              Divider(color: colors.inputBorder, height: 1.h),
              10.verticalSpace,
              Row(
                children: [
                  _StatColumn(
                    label: Strings.price.toUpperCase(),
                    value: _priceText,
                    valueColor: colors.primary,
                    colors: colors,
                  ),
                  10.horizontalSpace,
                  Container(
                    width: 1.w,
                    height: 30.h,
                    color: colors.inputBorder,
                  ),
                  10.horizontalSpace,
                  Flexible(
                    child: _StatColumn(
                      label: Strings.quantity.toUpperCase(),
                      value: _quantityText,
                      valueColor: _quantityColor,
                      colors: colors,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({
    required this.label,
    required this.isHighlighted,
    required this.colors,
  });

  final String label;
  final bool isHighlighted;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final accent = isHighlighted ? colors.primary : colors.secondaryText;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: accent.withValues(alpha: isHighlighted ? 0.45 : 0.25),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.eco_rounded, size: 12.r, color: accent),
          4.horizontalSpace,
          Text(
            label,
            style: FontPalette.base500(10, color: accent),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.colors,
  });

  final String label;
  final String value;
  final Color valueColor;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: FontPalette.base500(
            9,
            color: colors.secondaryText.withValues(alpha: 0.85),
          ),
        ),
        4.verticalSpace,
        Text(
          value,
          style: FontPalette.base600(14, color: valueColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ProductStatusSwitch extends StatelessWidget {
  const _ProductStatusSwitch({
    required this.value,
    required this.onChanged,
    required this.colors,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      width: 36.w,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Switch.adaptive(
          value: value,
          activeTrackColor: colors.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _ProductIconButton extends StatelessWidget {
  const _ProductIconButton({
    required this.icon,
    required this.color,
    required this.borderColor,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 28.r,
          height: 28.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            border: Border.all(color: borderColor, width: 1.w),
          ),
          child: Icon(icon, size: 14.r, color: color),
        ),
      ),
    );
  }
}

class _ProductExpandedDetails extends StatelessWidget {
  const _ProductExpandedDetails({required this.product, required this.colors});

  final ProductCrudModel product;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final barcode = product.barcode?.trim();
    final hasBarcode = barcode != null && barcode.isNotEmpty;

    return Column(
      children: [
        Divider(
          color: colors.inputBorder,
          height: 1.h,
          indent: 12.w,
          endIndent: 12.w,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 14.h),
          child: Column(
            children: [
              _ProductDetailRow(
                label: Strings.barcode,
                value: hasBarcode ? barcode : Strings.notAvailable,
                valueColor: colors.primaryText,
                colors: colors,
              ),
              8.verticalSpace,
              _ProductDetailRow(
                label: Strings.sgst,
                value: product.sgst?.toDisplayPercent() ?? Strings.notAvailable,
                valueColor: colors.primaryText,
                colors: colors,
              ),
              8.verticalSpace,
              _ProductDetailRow(
                label: Strings.cgst,
                value: product.cgst?.toDisplayPercent() ?? Strings.notAvailable,
                valueColor: colors.primaryText,
                colors: colors,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductDetailRow extends StatelessWidget {
  const _ProductDetailRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.colors,
  });

  final String label;
  final String value;
  final Color valueColor;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FontPalette.base400(13, color: colors.secondaryText),
        ),
        Flexible(
          child: Text(
            value,
            style: FontPalette.base500(13, color: valueColor),
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
